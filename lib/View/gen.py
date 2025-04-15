import json
import requests

api_key = "your-api-key"
base_url = "http://localhost:3040/v1/chat/completions"  # تأكد من أن هذا يعمل

payload = {
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "Hello!"}]
}

headers = {
    "Authorization": f"Bearer {api_key}",
    "Content-Type": "application/json"
}

response = requests.post(base_url, headers=headers, data=json.dumps(payload))

try:
    data = response.json()
    print("Response JSON:", data)  # عرض الاستجابة لمعرفة الخطأ
    if "choices" in data and data["choices"]:
        print(data["choices"][0]["message"]["content"])
    else:
        print("Error: No choices found in response.")
except Exception as e:
    print("Error parsing response:", e)
