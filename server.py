from inference import inference
from flask import Flask, request, jsonify
from PIL import Image
from io import BytesIO
from base64 import b64decode, b64encode


app = Flask(__name__)


@app.route('/infer', methods=['POST'])
def infer():
    data = request.get_json()  # 获取 POST 请求中的 JSON 数据
    input_image = data["input_image"]
    # 从 base64 解码出图片
    image = Image.open(BytesIO(b64decode(input_image)))
    output_image = inference(image)
    buffered = BytesIO()
    output_image.save(buffered, format='PNG')
    output_image = b64encode(buffered.getvalue()).decode('utf-8')
    result = {'result': {'output_image': output_image}}
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
