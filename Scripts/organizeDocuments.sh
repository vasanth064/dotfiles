#!/usr/bin/bash

cd ~/Documents

#Code
mkdir Code
mv -v *.htm* *.php *.css *.js *.json *.sql *.xml ~/Documents/Code

#Office
mkdir Office
mv -v *.txt *.doc* *.ppt* *.xls* *.csv *.pdf *.PDF ~/Documents/Office

#Others
mkdir Others
mv -v *.ttf *.torrent ~/Documents/Others

#Compressed
mkdir Compressed
mv -v *.iso *.rar *.zip *.tar.** ~/Documents/Compressed

#Executables
mkdir Executables
mv -v *.deb *.exe *.run *.msi *.flatpakref ~/Documents/Executables
