#!/bin/bash
#Script voor soorteren van foto's
clear;
get_sourcedest() {
	directory="";
	while [ -z "$directory" ]; do
		read -p "Geef de directory op waar het bestand staat (bijv. /home/administrator/imgs): " directory;
		if [ -z "$directory" ]; then
			echo "Er moet een directory worden opgegeven!";
		fi
	done
	echo $directory;
}
get_sort() {
	sort="";
	while [ -z "$sort" ]; do
		read -p "Sorteren op week of maand? :" sort
		if [ -z "$sort" ]; then
			echo "Er moet een keuze gemaakt worden tussen week of maand!";
		fi
	done
	echo $sort;
}
create_destdir() {
	wdate=$(date +%V);
	mdate=$(date +%m);
	destdir=/home/administrator/images;
	if [ "$sort" = "week" ]; then
		mkdir $destdir/week/$wdate;
		destdir=$destdir/week/$wdate;
	elif [ "$sort" = "maand" ]; then
		mkdir $destdir/maand/$mdate;
		destdir=$destdir/maand/$mdate;
	else 	echo "Verkeerde input voor de sortering. Start het programma opnieuw.";
		exit 1;
	fi
	echo $destdir;
}
directory=$(get_sourcedest);
sort=$(get_sort);
destdir=$(create_destdir);
for file in "$directory"/*
do
	cp $file $destdir
	srcmd5=($(md5sum $file))
	dstmd5=($(md5sum $destdir/${file##*/}))
	if [ "$srcmd5" = "$dstmd5" ]; then
	rm $file
	fi
done

