## Introduction

Welcome to the **Godot Tiny MMO Demo**!  
This project is a minimal example of a multiplayer game built with **Godot 4**, providing a foundation for developing MMO-style games. It showcases both the client-side and server-side components required for such games.

In this guide, you will find an overview of the project structure, details about the various components, and tips for exporting the game for production. Whether you're looking to understand how to implement networking, manage server logic, or organize your assets, this documentation will help you get started and customize the demo for your own MMO project.

---

## Project Structure

The project is organized into several key directories to keep the client, different servers, and shared resources well-structured. Each primary directory contains its own `main.gd`, which acts as the entry point for that component.

```
$ tree -L 2
.
|-- project.godot
|-- icon.svg
|-- export_presets.cfg
|-- assets
|-- source
|   |-- client
|		`-- client_main.gd
|   |-- common
|		`-- main.gd
|   |-- gateway_server
|		`-- gateway_main.gd
|   |-- master_server
|		`-- master_main.gd
|   `-- world_server
|		`-- world_main.gd
`-- test_config
    |-- tls
		|-- private_key.key
		`-- certificate.crt
    |-- client_config.cfg
    |-- gateway_config.cfg
    |-- master_server_config.cfg
    `-- world_server_config.cfg
```

---

## Key Directories

- **assets/**: Contains shared assets such as graphics, audio, translations, and other resources used across the game.
- **source/**: This folder contains the scripts, scenes, and other files specific to Godot.
    - **common/**: Resources and logic that are shared between the client and servers.
    - **client/**: Game client-side logic, including the UI and interactions with the game world.
    - **gateway_server/**: Manages authentication and login logic for players.
    - **master_server/**: Coordinates between the various gateway and world servers, ensuring they are in sync.
    - **world_server/**: Handles the game server-side logic where the client interacts with the game world.
- **test_config/**: Configuration files used for local testing, including SSL/TLS certificates and server configuration settings.

> To navigate through the documentation, check the sidebar on the left.
