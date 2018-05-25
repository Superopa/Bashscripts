#!/bin/bash
#Script voor soorteren van foto's
clear
read -p "Geef de directory op waar het bestand staat (bijv. \home\administrator\imgs): " directory;
read -p "Sorteren op week of maand? :" sort
destdir=/home/administrator/images
wdate=$(date +%V)
mdate=$(date +%m)
if [ "$sort" = "week" ]; then
	echo $sort;
	mkdir $destdir/week/$wdate
	destdir=$destdir/week/$wdate
elif [ "$sort" = "maand" ]; then
	echo $sort;
	mkdir $destdir/maand/$mdate
	destdir=$destdir/maand/$mdate
else echo "Prutser";
fi
for file in "$directory"/*
do
	cp $file $destdir
	srcmd5=($(md5sum $file))
	dstmd5=($(md5sum $destdir/${file##*/}))
	if [ "$srcmd5" = "$dstmd5" ]; then
	rm $file
	fi
done

