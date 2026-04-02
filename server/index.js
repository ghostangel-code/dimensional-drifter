require('dotenv').config();
const express = require('express');
const cors = require('cors');
const multer = require('multer');
const axios = require('axios');

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ extended: true, limit: '50mb' }));

// Multer for handling file uploads in memory
const upload = multer({ storage: multer.memoryStorage() });

app.get('/health', (req, res) => {
    res.json({ status: 'ok', message: 'Dimensional Drifter Backend is running.' });
});

// API endpoint for processing image from Godot
app.post('/api/process_image', upload.single('image'), async (req, res) => {
    try {
        let base64Image = '';
        
        if (req.file) {
            base64Image = req.file.buffer.toString('base64');
        } else if (req.body.image) {
            base64Image = req.body.image;
        } else {
            return res.status(400).json({ error: 'No image provided' });
        }
        
        const context = req.body.context || '需要重量超过500g';

        const apiKey = process.env.YUNWU_API_KEY;
        if (!apiKey) {
            console.error('YUNWU_API_KEY is not set');
            return res.status(500).json({ error: 'Server configuration error' });
        }

        // Call Yunwu API (gemini-3.1-flash-image-preview) for background removal and property extraction
        const prompt = `请提取图中主体，去除背景并生成纯净透明图。同时，请分析该物体在现实中的物理属性。当前关卡目标是【${context}】。如果该物体不符合条件，请生成一句刻薄嘲讽的旁白；如果符合，请生成赞许旁白。请在文本中仅返回如下 JSON 格式数据：{"name": "名称", "mass": 300, "material": "材质", "tags": ["标签1"], "is_passed": true/false, "narration": "生成的旁白内容"}`;

        const yunwuResponse = await axios.post(
            'https://yunwu.ai/v1beta/models/gemini-3.1-flash-image-preview:generateContent',
            {
                contents: [
                    {
                        role: 'user',
                        parts: [
                            { text: prompt },
                            {
                                inline_data: {
                                    mime_type: 'image/png',
                                    data: base64Image
                                }
                            }
                        ]
                    }
                ],
                generationConfig: {
                    responseModalities: ['TEXT', 'IMAGE']
                }
            },
            {
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${apiKey}`
                }
            }
        );

        // Process Yunwu API response
        // Expected to return both TEXT (JSON) and IMAGE
        // We will implement robust parsing here once we see the exact payload structure,
        // but generally we look for text and image data in the parts array.
        
        let jsonText = '';
        let extractedImageBase64 = '';

        const candidates = yunwuResponse.data.candidates;
        if (candidates && candidates.length > 0 && candidates[0].content && candidates[0].content.parts) {
            for (const part of candidates[0].content.parts) {
                if (part.text) {
                    jsonText = part.text;
                } else if (part.inline_data && part.inline_data.data) {
                    extractedImageBase64 = part.inline_data.data;
                }
            }
        }

        // Clean up markdown formatting from JSON if present
        jsonText = jsonText.replace(/```json/g, '').replace(/```/g, '').trim();
        
        let properties = {};
        try {
            properties = JSON.parse(jsonText);
        } catch (e) {
            console.warn('Failed to parse JSON directly from LLM:', jsonText);
            // Fallback object
            properties = {
                name: 'Unidentified Object',
                mass: 1,
                material: 'unknown',
                tags: ['error'],
                is_passed: false,
                narration: '连实体都捕捉不到的观测者，你是在拍自己的脑子吗？'
            };
        }

        res.json({
            success: true,
            properties: properties,
            image_base64: extractedImageBase64 || base64Image // fallback to original if model didn't return image
        });

    } catch (error) {
        console.error('Error processing image:', error.response ? error.response.data : error.message);
        res.status(500).json({ 
            success: false, 
            error: 'Failed to process image',
            narration: '连实体都捕捉不到的观测者，你是在拍自己的脑子吗？'
        });
    }
});

app.listen(port, () => {
    console.log(`Dimensional Drifter backend listening at http://localhost:${port}`);
});
