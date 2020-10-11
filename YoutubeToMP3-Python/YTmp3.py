import os
import platform
import youtube_dl
import urllib.request


def downloadMusic(link):
	ydl_opts = {
		'outtmpl': "./YTmp3/%(uploader)s%(title)s.%(ext)s",
		'format': 'bestaudio/best',
		'postprocessors': [{
			'key': 'FFmpegExtractAudio',
			'preferredcodec': 'mp3',
			'preferredquality': '256',
		}],
		'prefer_ffmpeg': True
	}

	with youtube_dl.YoutubeDL(ydl_opts) as ydl:
		info_dict = ydl.extract_info(link, download=True)


if platform.system() == 'Windows':
	if not os.path.isfile('./ffmpeg.exe'):
		urllib.request.urlretrieve('http://download1652.mediafire.com/xb845kmtiggg/8k6gwpcjy1kuxdw/ffmpeg.exe', 'ffmpeg.exe')

if not os.path.isdir('./YTmp3'):
	os.mkdir('./YTmp3')

with open("videos_list.txt", "r") as file :
	linhas = file.readlines()

for VIDEOS in linhas:
	downloadMusic(VIDEOS)
