# 场景草图生成提示词 (Scene Generation Prompts)

为了在 Godot 开发阶段有明确的视觉参考，以下为使用 AI 图像生成模型（如 Midjourney, Stable Diffusion, DALL-E 3 或云雾 API）生成游戏场景草图的专用提示词。

所有提示词均遵循游戏核心视觉设定：**3D 第一人称视角，极简白模，Sobel算子线框描边，二值化赛璐璐阴影（Flat Cel-Shading），以及一种“被高维病毒降维抹除”的清冷、虚无氛围。**

---

## 全局通用前缀/后缀 (Style Modifiers)

在每个具体场景提示词的末尾（除最后的黑屏谢幕外），请务必加上这段**风格约束**，以确保画风统一：
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

## 场景 5：第五章 - 重构世界（不同阶段）

您提供的参考图容易让 AI 误以为“塔”是摆在普通地板上的杂物堆。为了凸显“深不见底的虚空”与“异步联机”的震撼感，我们将第五章分为三个关键阶段进行生成：

### 5.1 绝境建塔（前期）
**场景描述**：深不见底的白色虚空，玩家用自己的贴纸艰难堆叠。没有地板，只有无尽深渊。
**AI 提示词 (Prompt)**：
> An extreme low-angle shot looking up in an infinite, bottomless pure white void. High above, a glowing rectangular exit door shines faintly. In the center, a precarious, chaotic, towering stack of 2D photorealistic cutout stickers (old shoes, coffee cups, books, tools) with thick white borders. The tower looks incredibly unstable, balancing defying gravity. There is no floor, just an endless white abyss.
> [附加 Style Prompt]

### 5.2 星海救援（中期彩蛋）
**场景描述**：物品耗尽时，打开散发金光的“星海”物品栏，抓取他人的梦境物品。
**AI 提示词 (Prompt)**：
> First-person view in a white void. The player's hand is holding a 2D cutout sticker of a glowing golden pocket watch. On the screen, a 'Starry Sea' UI inventory panel glows with warm golden light, showing items left by other players. Next to the pocket watch, a beautiful, floating holographic text box displays a heartwarming dream: "A sunny afternoon picnic with my dog". The contrast between the cold void and the warm golden UI is striking.
> [附加 Style Prompt]

### 5.3 终极取舍（高潮结局）
**场景描述**：到达大门，只能带走一样，其他物品分解为数据光斑上传。
**AI 提示词 (Prompt)**：
> Standing right in front of a blindingly bright golden exit door in a white void. A UI prompt forces the player to select only one 2D cutout sticker to keep. Around the player, dozens of other 2D cutout stickers (books, cups, keys) are dissolving, pixelating, and shattering into glowing golden data particles, flying upwards into the cloud. A dramatic, emotional sacrifice.
> [附加 Style Prompt]

---

## 场景 6：谢幕弹幕演出 (Endless Dream Credits)

**场景描述**：游戏通关后的无限循环谢幕。完全脱离白模世界，在漆黑的虚空中滚动全球玩家的“美梦”弹幕，伴随温暖的光斑。
**AI 提示词 (Prompt)**：
> A pitch-black, infinite void. Slowly scrolling upwards are hundreds of glowing, semi-transparent text bubbles, each containing a different short, heartwarming story or dream in various languages. Faint, warm golden light particles drift among the text. A melancholic, deeply emotional and artistic atmosphere, resembling a cinematic end credits sequence. 
> *(注意：此场景不使用白模 Style Prompt，请使用以下专用后缀)*
> **Style Prompt:** Pure black background, glowing typography, masterpiece, highly detailed, emotional lighting.