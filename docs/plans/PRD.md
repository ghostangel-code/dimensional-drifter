## Problem Statement

The user wants to develop a PC game titled 《维度漂流者》(Dimensional Drifter) built with Godot 4 and a Node.js backend. It's a "Mandatory Always-Online" game integrating GodotSteam for authentication to enforce a strict "One-Time Playthrough" rule and prevent API abuse. The game features AI multimodal mechanics (vision, LLM, video) where players take pictures of real objects via camera to generate 2D "sticker-like" physics standees. 

The previous design document outlines the core gameplay loop, chapter progression, visual style, and backend architecture. However, to transition from a design concept to a fully executable Product Requirements Document (PRD), several engineering edge cases and detailed mechanics need to be defined. These include the camera UI and error handling, the physical behavior and retrieval of 2D standees in a 3D space, level reset mechanics, and a server cold-start strategy for the asynchronous multiplayer features.

## Solution

This PRD solidifies the implementation details for the engineering edge cases identified:

1.  **Camera UI & Error Handling**: A robust camera interface with a "cyberpunk scanning" aesthetic. If the AI vision model fails to identify an object (e.g., image is too dark or lacks a subject), the game provides immediate, free retries accompanied by a specific, in-character taunt from "The Judge" (e.g., "连实体都捕捉不到的观测者，你是在拍自己的脑子吗？"), enhancing the narrative even during failures.
2.  **Standee Physics & Retrieval**: Standees will use a "Billboard" effect (always facing the player) combined with an extruded 3D collision shape (`CollisionShape3D`). This creates a surreal "2D in 3D" aesthetic crucial for the game's theme. A "vacuum-like" telekinesis mechanic (e.g., pressing 'F') allows players to instantly retrieve thrown standees back into their inventory, preventing soft-locks if items fall out of bounds.
3.  **Level Reset Mechanics**: Implemented specifically for Chapters 3, 4, and 5 to prevent frustration. Resetting clears the LLM conversation context in the dialogue chapters. In Chapter 5, resetting clears the physical tower and returns all placed standees to the player's inventory for a fresh attempt.
4.  **Server Cold-Start Strategy**: To ensure the "Starry Sea" (asynchronous multiplayer) and the endless credits sequence function on day one when the player database is empty, the backend will be pre-populated with AI-generated "fake" data (using LLMs and image generation APIs). These will be explicitly labeled as "Fragments of System Redundancy" to maintain narrative consistency without breaking the illusion of a populated world.

## User Stories

1.  **As a player**, I want to see a clear, thematic UI when I open the "Logic Camera", so that I feel immersed in the "Observer" role.
2.  **As a player**, I want the game to tell me immediately and in-character if my photo is unusable (e.g., too dark), so that I can retry without losing resources or immersion.
3.  **As a player**, I want the standees to always face me but interact physically with the 3D world, so that the "降维" (dimensionality reduction) theme is visually apparent.
4.  **As a player**, I want to easily retrieve thrown standees from a distance, so that I don't get stuck if an item falls into an unreachable area.
5.  **As a player**, I want to be able to reset the dialogue context in Chapters 3 and 4, so that I can try a different philosophical approach if I get stuck.
6.  **As a player**, I want to be able to instantly recall all placed items to my inventory in Chapter 5 if my tower collapses, so that I can quickly rebuild without tedious manual cleanup.
7.  **As an early adopter (player)**, I want to experience the "Starry Sea" ending and endless credits even if few others have played, so that I get the full emotional impact of the game's conclusion.
8.  **As a developer**, I want the server to automatically serve pre-generated AI "redundancy fragments" when the real player database is low, so that the asynchronous multiplayer features never appear broken or empty.
9.  **As a developer**, I want the Godot client to handle Billboard rendering while maintaining accurate 3D physics collisions, so that the stacking mechanic in Chapter 5 remains challenging but fair.
10. **As a developer**, I want the backend to handle the logic of determining when to serve real player data vs. AI-generated cold-start data, so that the transition as the player base grows is seamless.

## Implementation Decisions

-   **Camera UI**: Implement a full-screen Control node in Godot overlaying the webcam feed with shader-based scanning lines.
-   **Error Handling**: The Node.js backend will return a specific error code/flag if the Vision API fails to extract properties. The Godot client will interpret this, trigger a Glitch UI effect, play the pre-recorded/generated taunt audio, and reset the camera state without incrementing any internal usage counters (if applicable).
-   **Standee Rendering**: Use `Sprite3D` with the `billboard` property set to enabled (Y-Billboard or full Billboard depending on visual testing).
-   **Standee Physics**: Generate a `CollisionPolygon3D` by extruding the 2D polygon generated from the alpha channel of the returned image. This ensures the physical shape matches the visual shape despite the Billboard rendering.
-   **Retrieval System**: Implement a raycast or area-of-effect check centered on the player camera. When triggered (key press), identified standee `RigidBody3D` nodes are despawned from the scene tree and their data is re-added to the inventory UI array.
-   **Level Reset (Chap 3/4)**: Add a UI button to clear the current session's conversation history array before sending the next prompt to the Node.js backend.
-   **Level Reset (Chap 5)**: Add a UI button that iterates through a specific "Placed Items" group in the scene tree, frees the nodes, and repopulates the inventory data structure.
-   **Cold Start Backend Logic**: Create a script to pre-generate ~100 records (Image + Dream Text + Tags) using Gemini and image generation APIs. Store these in the database with a specific flag (e.g., `is_system_redundancy: true`). The API endpoint serving the "Starry Sea" data will query real player data first; if the count is below a threshold (e.g., 50), it will pad the response with these pre-generated records.

## Testing Decisions

-   **Good Test Definition**: Tests should verify the expected state changes (e.g., inventory count increases, scene node count decreases) rather than internal variable states.
-   **Backend Testing**:
    -   Test the API endpoint for handling unidentifiable images to ensure it returns the correct error format and taunt flag.
    -   Test the "Starry Sea" retrieval endpoint to ensure it correctly falls back to padding with AI-generated data when the database is nearly empty.
-   **Godot Testing (Manual/Automated UI)**:
    -   Verify the camera UI correctly transitions to the error state upon receiving a failure response from a mock server.
    -   Verify the retrieval mechanic correctly removes items from the 3D world and adds them back to the inventory UI.
    -   Verify the Chapter 5 reset button correctly clears the scene and restores the inventory.
    -   Verify that standees physically collide with each other and the environment while visually always facing the camera.

## Out of Scope

-   Specific UI layout design (colors, fonts, exact pixel positioning).
-   The specific implementation details of the GodotSteam plugin integration (covered in the broader design document).
-   The exact prompts used to generate the AI cold-start data.

## Further Notes

-   The visual disconnect between a 2D billboarded sprite and a 3D physical collision shape is intentional and central to the game's aesthetic, but requires careful tuning to ensure the stacking gameplay in Chapter 5 remains intuitive and not frustratingly unpredictable.