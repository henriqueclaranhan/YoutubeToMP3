@echo off

set wdir=%cd%

if not exist "%wdir%\Requirements" (
	mkdir Requirements
)

if not exist "%wdir%\Requirements\ffmpeg.exe" (
	curl -L http://download1652.mediafire.com/xb845kmtiggg/8k6gwpcjy1kuxdw/ffmpeg.exe -o %wdir%\Requirements\ffmpeg.exe
)

if not exist "%wdir%\Requirements\youtube-dl.exe" (
	curl -L https://yt-dl.org/downloads/2020.09.20/youtube-dl.exe -o %wdir%\Requirements\youtube-dl.exe
)

if not exist "%wdir%\YTmp3" (
	mkdir YTmp3
)

cd YTmp3

for /f "tokens=*" %%a in (%wdir%\videos_list.txt) do (
 	%wdir%\Requirements\youtube-dl.exe -x --audio-format mp3 %%a
)

cd ..
