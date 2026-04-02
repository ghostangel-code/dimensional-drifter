# Plan: Dimensional Drifter Implementation

> Source PRD: `./docs/plans/PRD.md` & `./docs/plans/2026-04-02-dimensional-drifter-design.md`

## Architectural decisions

- **Frontend**: Godot 4, 3D FPS perspective, utilizing 5 independent `.tscn` files to manage physics performance.
- **Backend**: Node.js (Express/FastAPI equivalent), serving as a secure proxy to Yunwu (Gemini) and Volcengine (Seedance 2.0) APIs.
- **Database**: Cloud Database (e.g., MongoDB) to store player dreams, generated standee images, and timestamps.
- **Authentication**: GodotSteam plugin passing Steam Tickets to the Node.js backend for validation and rate-limiting (enforcing the one-time playthrough rule).
- **Physics**: `Sprite3D` with `billboard` enabled, backed by a dynamically extruded `CollisionPolygon3D` to bridge the 2D aesthetic with 3D stacking mechanics.

---

## Phase 1: Core Loop MVP (Camera to Physics)

**User stories**: 1, 3, 9

### What to build
Establish the fundamental gameplay loop: moving in a 3D space, taking a picture via webcam, sending it to the backend, and instantiating a physical 2D standee. 
- **Godot**: Implement a basic FPS controller, a "Logic Camera" UI (Control node overlay), and the logic to capture the webcam frame as Base64.
- **Node.js**: Create the `/api/process_image` endpoint. It calls the Yunwu API (Gemini Vision) to remove the background and extract a simple JSON property (e.g., `mass`).
- **Godot**: Receive the transparent image and JSON, create a `RigidBody3D` with a billboarded `Sprite3D`, and automatically extrude a `CollisionPolygon3D` based on the image's alpha channel.

### Acceptance criteria
- [ ] Player can walk around a basic white Godot test room.
- [ ] Pressing 'C' opens the camera UI and takes a picture of the real world.
- [ ] The photo is sent to the Node.js backend and processed by the Yunwu API.
- [ ] The game spawns a transparent, 2D-looking physical object that falls to the floor and can collide with the environment.

---

## Phase 2: Error Handling, Retrieval, and Thermodynamics (Chapters 1 & 2)

**User stories**: 2, 4

### What to build
Flesh out the gameplay mechanics for the first two chapters by adding error resilience and the cumulative heat system.
- **Node.js**: Update the Vision API prompt to include context (Chapter 1 weight, Chapter 2 heat). Implement error detection if the image is unrecognizable, returning a specific taunt string.
- **Godot**: Implement the Glitch UI error state for the camera. 
- **Godot**: Implement the 'F' key telekinesis retrieval mechanic (raycast/area check to despawn `RigidBody3D` and add back to inventory).
- **Godot**: Build the Chapter 1 pressure plate (detecting `mass` > 500g) and Chapter 2 Ice Door (Area3D that continuously subtracts "HP" based on the cumulative `heat_value` of nearby standees).

### Acceptance criteria
- [ ] Taking a photo of nothing/blackness triggers a red glitch UI and the Judge's taunt without consuming resources.
- [ ] Player can press 'F' to suck a thrown standee back into their UI inventory.
- [ ] Throwing enough "hot" standees near the ice block causes it to melt over time.

---

## Phase 3: Multimodal Generation and Resets (Chapters 3 & 4)

**User stories**: 5

### What to build
Integrate the heavy AI generation features: video synthesis and LLM dialogue.
- **Node.js**: Create `/api/generate_dream_video` calling Volcengine Seedance 2.0 with 3 images and a text prompt.
- **Node.js**: Create `/api/debate` calling Yunwu LLM with conversation history, player text, and a standee image. Implement the strict content moderation (T&S) check here before processing.
- **Godot**: Build the Chapter 3 Projector Room UI. Send 3 inventory items + text to the backend, receive the MP4, and play it via `VideoStreamPlayer`.
- **Godot**: Build the Chapter 4 Judge UI. Send text + item to backend, display the typed-out response.
- **Godot**: Implement the "Reset Dialogue" button for Chapter 4.

### Acceptance criteria
- [ ] Player can submit 3 items and a text string to receive and watch a generated video in-game.
- [ ] Player can submit text and an item to debate the Judge, with the AI providing contextual, in-character responses.
- [ ] Vulgar/Sensitive inputs are blocked by the backend moderation check.
- [ ] Reset button clears the current conversation context.

---

## Phase 4: Steam Auth, Persistence, and Asynchronous Multiplayer (Chapter 5)

**User stories**: 6, 7, 8, 10

### What to build
Lock down the game loop with Steam authentication and build the database infrastructure for the "Starry Sea".
- **Godot**: Integrate GodotSteam. Fetch the session ticket on startup.
- **Node.js**: Implement `/api/auth` to verify the Steam Ticket. Create a database (MongoDB) schema for `Player`, `DreamItem` (image URL, text, tags). 
- **Node.js**: Enforce the "One-Time Playthrough" rule. If a Steam ID is marked complete, block `/process_image` and `/generate_dream_video` endpoints.
- **Node.js**: Create `/api/get_starry_sea` to fetch random items left by other players. Implement the cold-start logic (generate/serve 100 AI fake records if DB count < 50).
- **Godot**: Build Chapter 5. Implement the "Reset Tower" button. If the player runs out of items, trigger the Starry Sea UI, fetching data from the backend.

### Acceptance criteria
- [ ] Game fails to start/connect if Steam is not running or ticket is invalid.
- [ ] Running out of items in Chapter 5 populates the inventory with "other players'" items (or cold-start AI items).
- [ ] Pressing reset in Chapter 5 clears all dropped items and returns them to the inventory.
- [ ] A completed Steam account cannot generate new images/videos upon restarting the game.

---

## Phase 5: Polish, Transitions, and The Endless Credits

**User stories**: (All related to final polish and experience)

### What to build
The final visual wrapper and the emotional climax of the game.
- **Godot**: Implement the global `change_scene` logic using the Glitch/Data Unpacking full-screen Shader.
- **Godot**: Build the final sequence. When the player touches the escape door, trigger the "choose one to keep" UI. 
- **Node.js**: Create `/api/upload_legacy`. Receive the discarded items and save them to the database for future players.
- **Godot**: Build the Endless Credits scene. Continuously fetch random dream texts from the database and scroll them on screen while the emotional soundtrack loops.

### Acceptance criteria
- [ ] Moving between the 5 chapter scenes triggers a seamless Glitch transition.
- [ ] Reaching the end forces the player to discard all but one item.
- [ ] The game ends with an infinitely scrolling list of global player dreams.
