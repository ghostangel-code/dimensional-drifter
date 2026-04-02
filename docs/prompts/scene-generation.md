# 场景草图生成提示词 (Scene Generation Prompts)

为了在 Godot 开发阶段有明确的视觉参考，以下为使用 AI 图像生成模型（如 Midjourney, Stable Diffusion, DALL-E 3 或云雾 API）生成游戏场景草图的专用提示词。

所有提示词均遵循游戏核心视觉设定：**3D 第一人称视角，极简白模，Sobel算子线框描边，二值化赛璐璐阴影（Flat Cel-Shading），以及一种“被高维病毒降维抹除”的清冷、虚无氛围。**

---

## 全局通用前缀/后缀 (Style Modifiers)

在每个具体场景提示词的末尾，请务必加上这段**风格约束**，以确保画风统一：
> **Style Prompt:** 
> First-person view video game screenshot. Pure white 3D minimalist geometry, stark flat cel-shading, cold blueish shadows. Black ink-like Sobel outline around all objects, resembling an architectural wireframe or a paper model. Surreal, liminal space, clinical laboratory atmosphere, void-like background. A 2D photorealistic cutout sticker of an everyday object with a thick white border is placed in the 3D scene. Unreal Engine 5 render style but stylized, glitch art undertones, masterpiece, highly detailed.

---

## 场景 1：第一章 - 物质的重量（新手教学）

**场景描述**：一个巨大的废弃纯白实验室，前方有一部巨大的机械升降梯/压力踏板机关。
**AI 提示词 (Prompt)**：
> A massive, abandoned laboratory room entirely made of white geometric blocks. In the center, a huge, heavy-duty mechanical elevator platform or a giant pressure plate mechanism. The environment feels sterile and empty. On the pressure plate, there is a 2D photorealistic cutout sticker of a heavy dictionary book with a thick white border, contrasting sharply with the 3D environment. 
> [附加 Style Prompt]

---

## 场景 2：第二章 - 元素的属性（进阶解谜）

**场景描述**：一扇被巨大的半透明蓝色“坚冰”彻底封死的实验室大门。
**AI 提示词 (Prompt)**：
> A sealed laboratory corridor. The main blast door is completely blocked by a massive, jagged block of translucent, glowing blue ice. The ice has a stylized, low-poly look but refracts light. Scattered near the ice are a few 2D photorealistic cutout stickers of a red sweater and a lit lighter, both with thick white borders. The ice appears to be slightly melting and turning into digital pixels near the red sweater.
> [附加 Style Prompt]

---

## 场景 3：第三章 - 影像的修复（视频生成核心）

**场景描述**：一个空旷冰冷的放映室，中央是控制台，前方是一块正在播放温馨现实画面的巨大银幕。
**AI 提示词 (Prompt)**：
> A vast, empty cinema or screening room made of pure white wireframe geometry. In the foreground, a minimalist futuristic control console. In the background, a massive cinema screen is playing a warm, vibrant, photorealistic video of a sunny afternoon picnic, creating a striking contrast with the sterile white room. Three 2D cutout stickers (a key, an old photo, a dried flower) with thick white borders are floating above the console.
> [附加 Style Prompt]

---

## 场景 4：第四章 - 逻辑的悖论（文字生成核心）

**场景描述**：疯狂的审判法庭，半空中漂浮着由冷色发光线条和机械眼组成的巨大“审判者”。
**AI 提示词 (Prompt)**：
> A surreal, abstract courtroom in a white void. Floating menacingly in the air is 'The Judge', a massive entity composed only of glowing cold-blue geometric lines and a single, piercing mechanical eye. Floating in front of the player's view is a 2D cutout sticker of a broken teddy bear with a white border. A glowing holographic text box with typewriter text is floating between the player and The Judge.
> [附加 Style Prompt]

---

## 场景 5：第五章 - 重构世界（最终决战与星海彩蛋）

**场景描述**：深不见底的白色虚空，头顶极高处有发光的逃生门。玩家用各种现实物品的贴纸堆叠成一座摇摇欲坠的高塔。
**AI 提示词 (Prompt)**：
> An infinite, bottomless white void. Far above, a glowing rectangular exit door shines with warm golden light. Rising from the bottom is a precarious, chaotic, Jenga-like tower built entirely out of dozens of 2D photorealistic cutout stickers (books, cups, shoes, toys), each with a thick white border. The scene feels desperate yet hopeful. A UI overlay showing a 'Starry Sea' inventory of glowing golden items.
> [附加 Style Prompt]