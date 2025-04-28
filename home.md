## **Godot Tiny MMO**

**A web-based MMORPG demo developed using Godot Engine 4.4**,  
created without relying on the built-in multiplayer nodes.

The project’s design allows both the **client and server** to share the same codebase, with custom export presets to **export client and server builds separately**.  
This helps keep builds secure and optimized by excluding unnecessary components (see [**Exporting Client and Server Builds**](pages/export.md)).

This demo mimics a typical MMO architecture with different types of servers:  
**gateway, world, and master servers** (see [**Network Architecture Diagram**](https://private-user-images.githubusercontent.com/163869998/380446673-78b1cce2-b070-4544-8ecd-59784743c7a0.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDU4NDIyODUsIm5iZiI6MTc0NTg0MTk4NSwicGF0aCI6Ii8xNjM4Njk5OTgvMzgwNDQ2NjczLTc4YjFjY2UyLWIwNzAtNDU0NC04ZWNkLTU5Nzg0NzQzYzdhMC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDI4JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQyOFQxMjA2MjVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1mYTdhMDJmZjk3ZGZiMWM3NmI4MjI1OWEwYzljNWYwODgxN2E5ODQ1OGUzMTM3MWY3ZjY5MTU1MDFjMmJiZGJjJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.6na8ifLhzGgeY7UNSRS9BdCSuWHuIms2z547leXOkQg)).

---

> [!WARNING]
> This project is in **experimental state**. Some features are still missing or in progress. Check the [**#Features**](#features) section for more details.

---

## **Features**

Current and planned features:

- [X] **Client-Server Connection** using `WebSocketMultiplayerPeer`
- [X] **Playable on web browsers and desktops**
- [X] **Network Architecture** (see diagram below)
- [X] **Authentication System** via gateway server with Login UI
- [X] **Account Creation** for persistent player accounts
- [X] **Server Selection UI** to choose between available servers
- [X] **QAD Database** for persistent data storage
- [X] **Guest Login** for quick access
- [X] **Game Version Check** for client compatibility
- [X] **Character Creation** functionality
- [X] **Basic RPG Class System** with three initial classes: Knight, Rogue, Wizard
- [ ] **Weapons** (at least one usable weapon per class)
- [ ] **Basic Combat System**
- [X] **Entity Synchronization** for players within the same instance
- [ ] **Entity Interpolation** to reduce rubber banding
- [X] **Instance-based Chat** for localized communication
- [X] **Instance-based Maps** with the ability to travel between different map instances
- [X] **Three Different Maps**: Overworld, Dungeon Entrance, Dungeon
- [ ] **Private Instances** for solo players or small groups
- [ ] **Server-Side Anti-Cheat** (basic validation for speed hacks, teleport hacks, etc.)
- [ ] **Server-Side NPCs** (AI logic processed on the server)

---

## **Contributing**

Feel free to fork the repository and submit a pull request if you have ideas or improvements!  
You can also open an [**Issue**](https://github.com/SlayHorizon/godot-tiny-mmo-template/issues) to discuss bugs or feature requests.

---

## **Credits**

- **Maps** designed by [@d-Cadrius](https://github.com/d-Cadrius).
- **Screenshots** provided by [@WithinAmnesia](https://github.com/WithinAmnesia).
- Special thanks to [@Anokolisa](https://anokolisa.itch.io/dungeon-crawler-pixel-art-asset-pack) for providing the assets used in this open-source project.

---

> Code source under the [**MIT License**](https://github.com/SlayHorizon/godot-tiny-mmo/blob/main/LICENSE)  
> For inquiries, contact me on Discord: `slayhorizon`

>> To navigate through the website, check the sidebar on the left.
