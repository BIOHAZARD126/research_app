import requests
from bs4 import BeautifulSoup
from moviepy.editor import VideoFileClip, concatenate_videoclips, AudioFileClip
from gtts import gTTS
import os

def scrape_video_url(module_name, trauma_word=''):
    # Implement your web scraping logic here based on the module name
    if (module_name == 'Anxiety'):
        search_query = "satisfying ASMR videos task completion"
    elif (module_name == 'ADHD'):
        search_query = "videos requiring focus patterns"
    elif (module_name == 'Depression'):
        search_query = "supportive help videos"
    elif (module_name == 'SleepImprovement'):
        search_query = "calm scenic nighttime videos"
    elif (module_name == 'PTSD'):
        search_query = f"calm relaxing slow videos -{trauma_word}"
    elif (module_name == 'StressManagement'):
        search_query = "take it easy on yourself videos"
    elif (module_name == 'AlzheimersDementia'):
        search_query = "calm memory cognition videos"
    else:
        raise ValueError("Invalid module name")

    response = requests.get(f"https://www.youtube.com/results?search_query={search_query}")
    soup = BeautifulSoup(response.text, 'html.parser')
    video_ids = [vid['href'].split('=')[1] for vid in soup.select('a[href^="/watch?v="]')]
    return f"https://www.youtube.com/watch?v={video_ids[0]}"

def download_video(video_url, output_path):
    # You can use youtube-dl or pytube to download the video
    os.system(f"youtube-dl -o {output_path} {video_url}")

def process_video(input_path, output_path, sentences, selected_voice):
    clip = VideoFileClip(input_path)
    duration = clip.duration

    if duration > 120:
        clip = clip.subclip(0, 120)

    tts = gTTS(text=sentences, lang='en', slow=False)
    tts.save('tts_output.mp3')
    audio_clip = AudioFileClip('tts_output.mp3').volumex(0.65)

    video_clip = clip.set_audio(audio_clip)
    video_clip.write_videofile(output_path, codec='libx264')

    os.remove('tts_output.mp3')

def process_module(module_name, sentences, selected_voice, trauma_word):
    video_url = scrape_video_url(module_name, trauma_word)
    download_video(video_url, 'input_video.mp4')
    process_video('input_video.mp4', 'output_video.mp4', sentences, selected_voice)
    return 'output_video.mp4'
