from flask import Flask, request, jsonify
from flask_cors import CORS
import video_processing  # Use absolute import

app = Flask(__name__)
CORS(app)

@app.route('/process_video', methods=['POST'])
def process_video():
    data = request.json
    module = data.get('module')
    sentences = data.get('sentences')
    voice = data.get('voice')
    
    video_url = video_processing.find_and_process_video(module, sentences, voice)
    
    return jsonify({'video_url': video_url})

if __name__ == '__main__':
    app.run(debug=True)
