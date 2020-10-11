#!/usr/bin/bash

#Salva o local dos executáveis necessários e o diretório atual em variáveis
ytdl=$(which youtube-dl)
ffmp=$(which ffmpeg)
dir=$(pwd)
cont=0

#Verifica se a pasta YTmp3 já foi criada, se não ela é criada
if [ -e "$dir/YTmp3" ];
then
	cd YTmp3
else
	mkdir YTmp3
	cd YTmp3
fi

echo $'\nDownloading mp3 files in "YTmp3" folder\n'

#Confere se a variável é compatível com o local do executável
if [[ $ytdl == "/usr/local/bin/youtube-dl" && $ffmp == "/usr/bin/ffmpeg" ]];
then
	
	for VIDEOS in $(cat "$dir/videos_list.txt")
	do
		youtube-dl -x --audio-format mp3 --prefer-ffmpeg $VIDEOS && ((cont=cont+1))
	done
	
	echo $'\n'$cont $'mp3 files were downloaded in the YTmp3 folder'
	
else

	#ffmpeg not installed
	if [ $ffmp != $"/usr/bin/ffmpeg" ]
	then
		echo $'\nInstall ffmpeg to download the mp3!!!'
	fi
	
	#youtube-dl not installed
	if [ $ytdl != "/usr/local/bin/youtube-dl" ]
	then
	
		echo $'\nInstall youtube-dl to download the mp3!!!'
		echo $'\nDo you want to install youtube-dl now?'
		echo $'(Press "Y" if yes / Press any other key if not)'
		read -n 1 -r
		
		if [[ ! $REPLY =~ ^[Yy]$ ]]
		then
			echo $'\nyoutube-dl will not be installed...\n'
		else
			#Instalar youtube-dl
			echo $'\nInstalling youtube-dl...\n'
			sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
			sudo chmod a+rx /usr/local/bin/youtube-dl			
		 fi
		 
	fi
	
fi
