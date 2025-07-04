extends Node
## Events Autoload (only for the client side)
## Should be removed on non-client exports.

# Chat
signal message_submitted(message: String)
signal message_received(message: String, sender_name: String)

# HUD
signal item_icon_pressed(item_name: String)
signal local_player_ready(local_player: LocalPlayer)

# Guild (WIP)
signal data_requested(data_type: String)
signal data_received(data: Dictionary, data_type: String)

#var events: Dictionary[StringName, Signal]


func _ready() -> void:
	if not OS.has_feature("client"):
		queue_free()


#func add_signal(object: Object, signal_name: StringName):
	#events.set(signal_name, Signal(object, signal_name))


#func listen_to_signal()
