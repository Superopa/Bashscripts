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
		destdir=$destdir/maand/$wdate;
		if [ ! -d "$destdir" ]; then
			mkdir $destdir;
		fi
	elif [ "$sort" = "maand" ]; then
		destdir=$destdir/maand/$mdate;
		if [ ! -d "$destdir" ]; then
			mkdir $destdir;
		fi
	else 	echo "Verkeerde input voor de sortering. Start het programma opnieuw.";
		exit 1;
	fi
	echo $destdir;
}
copy_files() {
	for file in "$1"/*
	do
		cp $file $destdir
		srcmd5=($(md5sum $file))
		dstmd5=($(md5sum $destdir/${file##*/}))
		if [ "$srcmd5" = "$dstmd5" ]; then
		rm $file
		fi
	done
}

directory=$(get_sourcedest);
sort=$(get_sort);
destdir=$(create_destdir);
copy_files $directory
