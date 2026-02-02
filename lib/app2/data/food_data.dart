class FoodData {
  static Map<String, Map<String, dynamic>> foods = {
    "แกงกะหรี่ญี่ปุ่น": {
      "price": 120,
      "ingredients": [
        "เนื้อไก่/หมู/เนื้อวัว หั่นชิ้น",
        "หอมใหญ่",
        "มันฝรั่ง",
        "แครอท",
        "ก้อนรูส์แกงกะหรี่",
        "น้ำ",
      ],
      "steps": [
        "ผัดหอมใหญ่ → ใส่เนื้อผัดจนสุก",
        "ใส่มันฝรั่ง แครอท ผัดให้เข้ากัน",
        "เติมน้ำ ต้มจนผักนุ่ม",
        "ปิดไฟอ่อน แล้วใส่ก้อนแกงกะหรี่ คนให้ละลาย",
        "เคี่ยวต่อจนข้น เสิร์ฟกับข้าวญี่ปุ่น",
      ],
      "type": "คาว",
      "videoAsset": "assets/videos/curry.mp4",
      "shopLat": 18.28978,
      "shopLng": 99.49625,
    },

    "ข้าวผัด": {
      "price": 40,
      "ingredients": ["ข้าวสวยเย็น", "ไข่", "กระเทียม"],
      "steps": ["ผัดทุกอย่างรวมกัน"],
      "type": "คาว",
      "videoAsset": "assets/videos/fried_rice.mp4",
      "shopLat": 18.28439,
      "shopLng": 99.51070,
    },

    "ซูชิ": {
      "price": 80,
      "ingredients": ["ข้าวญี่ปุ่น", "ปลา"],
      "steps": ["ปั้นข้าว วางปลา"],
      "type": "คาว",
      "videoAsset": "assets/videos/sushi.mp4",
      "shopLat": 18.28877,
      "shopLng": 99.48490,
    },

    "ราเมน": {
      "price": 120,
      "ingredients": ["เส้นราเมน", "น้ำซุป"],
      "steps": ["ต้มเส้น ใส่น้ำซุป"],
      "type": "คาว",
      "videoAsset": "assets/videos/ramen.mp4",
      "shopLat": 18.28328,
      "shopLng": 99.48882,
    },

    "ขนมปังถั่วแดง": {
      "price": 40,
      "ingredients": ["แป้ง", "ถั่วแดง"],
      "steps": ["นวด อบ"],
      "type": "หวาน",
      "videoAsset": "assets/videos/anpan.mp4",
      "shopLat": 18.28704,
      "shopLng": 99.48814,
    },

    "ขนมปังเมลอน": {
      "price": 45,
      "ingredients": ["แป้ง", "เนย"],
      "steps": ["อบ"],
      "type": "หวาน",
      "videoAsset": "assets/videos/melon_pan.mp4",
      "shopLat": 18.28977,
      "shopLng": 99.49124,
    },

    "ซอฟต์ครีม": {
      "price": 25,
      "ingredients": ["นม", "น้ำตาล"],
      "steps": ["แช่เย็น"],
      "type": "หวาน",
      "videoAsset": "assets/videos/soft.mp4",
      "shopLat": 18.28701,
      "shopLng": 99.47813,
    },
  };
}
