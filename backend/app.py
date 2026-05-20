import os
import io
from flask import Flask, render_template, send_file, abort
from mutagen.mp3 import MP3
from mutagen.id3 import ID3, APIC

app = Flask(__name__)
MUSIC_DIR = os.path.join(app.static_folder, 'music')

@app.route('/')
def home():
    if not os.path.exists(MUSIC_DIR):
        os.makedirs(MUSIC_DIR)
        
    tracks = [f for f in os.listdir(MUSIC_DIR) if f.endswith('.mp3')]
    tracks.sort()
    return render_template('index.html', tracks=tracks)

# Новый маршрут, который вытаскивает картинку из MP3
@app.route('/cover/<track_name>')
def get_cover(track_name):
    track_path = os.path.join(MUSIC_DIR, track_name)
    
    if not os.path.exists(track_path):
        abort(404)
        
    try:
        audio = MP3(track_path, ID3=ID3)
        # Ищем тег APIC (Attached Picture) внутри ID3-тегов
        for tag in audio.tags.values():
            if isinstance(tag, APIC):
                # Отдаем байты картинки как файл обратно в браузер
                return send_file(
                    io.BytesIO(tag.data),
                    mimetype=tag.mime
                )
    except Exception as e:
        print(f"Ошибка чтения обложки из {track_name}: {e}")
        
    # Если обложки нет или произошла ошибка, отдаем пустой ответ (или заглушку)
    abort(404)

if __name__ == '__main__':
    # Читаем переменную окружения FLASK_DEBUG. Если её нет — по умолчанию False
    # И переводим в булево значение, так как из окружения всегда летит строка
    is_debug = os.getenv('FLASK_DEBUG', 'False').lower() in ['true', '1', 'yes']
    
    app.run(host='0.0.0.0', port=5000, debug=is_debug)