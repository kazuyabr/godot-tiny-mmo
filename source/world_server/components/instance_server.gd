class_name ServerInstance
extends SubViewport

signal player_entered_warper(player: Player, current_instance: ServerInstance, warper: Warper)

const PLAYER: PackedScene = preload("res://source/common/entities/characters/player/player.tscn")

static var world_server: WorldServer
static var chat_commands: Dictionary[String, ChatCommand]
var local_chat_commands: Dictionary[String, ChatCommand]

var entity_collection: Dictionary = {} #[int, Entity]
var connected_peers: PackedInt64Array = PackedInt64Array()
var awaiting_peers: Dictionary = {} #[int, Player]

var last_accessed_time: float

var instance_map: Map
var instance_resource: InstanceResource

func _ready() -> void:
	world_server.multiplayer_api.peer_disconnected.connect(
		func(peer_id: int):
			if connected_peers.has(peer_id):
				despawn_player(peer_id)
	)

func _physics_process(_delta: float) -> void:
	var state: Dictionary = {"EC" = {}}
	for entity_id: int in entity_collection:
		state["EC"][entity_id] = (entity_collection[entity_id] as Entity).sync_state
	state["T"] = Time.get_unix_time_from_system()
	for peer_id: int in connected_peers:
		fetch_instance_state.rpc_id(peer_id, state)

func load_map(map_path: String) -> void:
	if instance_map:
		instance_map.queue_free()
	instance_map = load(map_path).instantiate()
	add_child(instance_map)
	for child in instance_map.get_children():
		if child is InteractionArea:
			child.player_entered_interaction_area.connect(self._on_player_entered_interaction_area)

func _on_player_entered_interaction_area(player: Player, interaction_area: InteractionArea) -> void:
	if player.just_teleported:
		return
	if interaction_area is Warper:
		player_entered_warper.emit.call_deferred(player, self, interaction_area)
	if interaction_area is Teleporter:
		if not player.just_teleported:
			player.just_teleported = true
			update_node(
				get_path_to(player),
				{^":position": interaction_area.target.global_position}
			)

@rpc("authority", "call_remote", "reliable", 1)
func update_node(node_path: NodePath, to_update: Dictionary[NodePath, Variant]) -> void:
	var root: Node = get_node_or_null(node_path)
	if not root:
		return
	var target: Node
	var target_path: NodePath
	for path: NodePath in to_update:
		target_path = TinyNodePath.get_path_to_node(path)
		if target_path:
			target = root.get_node_or_null(target_path)
		else:
			target = root
		if not target:
			continue
		target.set_indexed(TinyNodePath.get_path_to_property(path), to_update[path])
		root.spawn_state[path] = to_update[path]
	for peer_id: int in connected_peers:
		update_node.rpc_id(peer_id, node_path, to_update)

@rpc("authority", "call_remote", "reliable", 1)
func update_entity(entity: Entity, to_update: Dictionary) -> void:
	for thing: String in to_update:
		entity.set_indexed(thing, to_update[thing])
	for peer_id: int in connected_peers:
		update_entity.rpc_id(peer_id, entity.name.to_int(), to_update)

@rpc("authority", "call_remote", "reliable", 0)
func fetch_instance_state(_new_state: Dictionary):
	pass

@rpc("any_peer", "call_remote", "reliable", 0)
func fetch_player_state(sync_state: Dictionary) -> void:
	var peer_id: int = multiplayer.get_remote_sender_id()
	if entity_collection.has(peer_id):
		var entity: Entity = entity_collection[peer_id] as Entity
		# [CORREÇÃO] Verificação segura do campo "T"
		if sync_state.has("T") and entity.sync_state.has("T"):
			var t_remote = sync_state["T"]
			var t_local = entity.sync_state["T"]
			if typeof(t_remote) in [TYPE_INT, TYPE_FLOAT] and typeof(t_local) in [TYPE_INT, TYPE_FLOAT]:
				if t_local < t_remote:
					for key: String in sync_state:
						entity.sync_state[key] = sync_state[key]
					entity.sync_state = entity.sync_state

@rpc("any_peer", "call_remote", "reliable", 0)
func player_trying_to_change_weapon(weapon_path: String, _side: bool = true) -> void:
	var peer_id: int = multiplayer.get_remote_sender_id()
	var player: Player = entity_collection[peer_id] as Player
	if not player:
		return
	if player.player_resource.inventory.has(weapon_path):
		update_node(
			player.get_path(), 
			{^":weapon_name_right": weapon_path}
		)

@rpc("any_peer", "call_remote", "reliable", 0)
func ready_to_enter_instance() -> void:
	var peer_id: int = multiplayer.get_remote_sender_id()
	spawn_player(peer_id)

#region spawn/despawn
@rpc("authority", "call_remote", "reliable", 0)
func spawn_player(peer_id: int, spawn_state: Dictionary = {}) -> void:
	var player: Player
	var spawn_index: int = 0
	if awaiting_peers.has(peer_id):
		player = awaiting_peers[peer_id]["player"]
		spawn_index = awaiting_peers[peer_id]["target_id"]
		awaiting_peers.erase(peer_id)
	else:
		player = instantiate_player(peer_id)
	player.spawn_state[":position"] = instance_map.get_spawn_position(spawn_index)
	player.just_teleported = true
	add_child(player, true)
	entity_collection[peer_id] = player
	connected_peers.append(peer_id)
	propagate_spawn(peer_id, player.spawn_state)

func instantiate_player(peer_id: int) -> Player:
	var player_resource: PlayerResource = world_server.connected_players[peer_id]
	var character_resource: CharacterResource = ResourceLoader.load(
		"res://source/common/resources/custom/character/character_collection/" +
		player_resource.character_class + ".tres"
	)
	var new_player: Player = PLAYER.instantiate() as Player
	new_player.name = str(peer_id)
	new_player.player_resource = player_resource
	new_player.spawn_state = {
		"character_class": player_resource.character_class,
		"display_name": player_resource.display_name,
		"health_component:health": character_resource.base_health + character_resource.health_per_level * player_resource.level,
		"health_component:max_health": character_resource.base_health + character_resource.health_per_level * player_resource.level,
	}
	print(new_player.spawn_state)
	return new_player

func propagate_spawn(player_id: int, spawn_state: Dictionary) -> void:
	for peer_id: int in connected_peers:
		spawn_player.rpc_id(peer_id, player_id, spawn_state)
		if player_id != peer_id:
			spawn_player.rpc_id(player_id, peer_id, entity_collection[peer_id].spawn_state)

@rpc("authority", "call_remote", "reliable", 0)
func despawn_player(peer_id: int, delete: bool = false) -> void:
	connected_peers.remove_at(connected_peers.find(peer_id))
	if entity_collection.has(peer_id):
		var player: Entity = entity_collection[peer_id] as Entity
		if delete:
			player.queue_free()
		else:
			remove_child(player)
		entity_collection.erase(peer_id)
	for id: int in connected_peers:
		despawn_player.rpc_id(id, peer_id)
#endregion

#region chat
@rpc("any_peer", "call_remote", "reliable", 1)
func player_submit_message(new_message: String) -> void:
	var peer_id: int = multiplayer.get_remote_sender_id()
	propagate_rpc(fetch_message.bindv([new_message, peer_id]))
	for id: int in connected_peers:
		fetch_message.rpc_id(id, new_message, peer_id)

@rpc("authority", "call_remote", "reliable", 1)
func fetch_message(_message: String, _sender_id: int) -> void:
	pass

@rpc("any_peer", "call_remote", "reliable", 1)
func player_submit_command(command: String) -> void:
	var peer_id: int = multiplayer.get_remote_sender_id()
	if not command.begins_with("/"):
		return
	var args: PackedStringArray = command.split(" ")
	var command_name: String = args[0]
	var chat_command: ChatCommand = find_chat_command(command_name)
	if chat_command:
		fetch_message.rpc_id(
			peer_id,
			chat_commands[command_name].execute(args, peer_id, self),
			1
		)
	else:
		fetch_message.rpc_id(peer_id, "Command not found.", 1)

func find_chat_command(command_name: String) -> ChatCommand:
	if local_chat_commands.has(command_name):
		return local_chat_commands.get(command_name)
	return chat_commands.get(command_name)
#endregion

@rpc("any_peer", "call_remote", "reliable", 1)
func player_action(action_index: int, action_direction: Vector2, peer_id: int = 0) -> void:
	peer_id = multiplayer.get_remote_sender_id()
	var player: Player = entity_collection.get(peer_id) as Player
	if not player:
		return
	if player.equiped_weapon_right.try_perform_action(action_index, action_direction):
		propagate_rpc(player_action.bindv([action_index, action_direction, peer_id]))

@rpc("any_peer", "call_remote", "reliable", 1)
func request_data(data_type: String) -> void:
	var peer_id: int = multiplayer.get_remote_sender_id()
	var player: Player = entity_collection.get(peer_id) as Player
	if not player:
		return
	match data_type:
		"guild":
			var guild: Guild = player.player_resource.guild
			var result: String
			if guild:
				result = guild.guild_name
			else:
				result = ""
			fetch_data.rpc_id(
				peer_id,
				{"guild": result},
				"guild"
			)

@rpc("authority", "call_remote", "reliable", 1)
func fetch_data(_data: Dictionary, _data_type: String) -> void:
	pass

func propagate_rpc(callable: Callable) -> void:
	for peer_id: int in connected_peers:
		callable.rpc_id(peer_id)
