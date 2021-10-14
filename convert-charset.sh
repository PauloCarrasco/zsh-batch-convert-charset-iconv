#!/bin/zsh

PWD="$(pwd)"
BACKUP="backup"
SRC_ENCODING="UTF-8"
TGT_ENCODING=$1
EXT=$2

echo ""

if [ -z $TGT_ENCODING ]; then

	TGT_ENCODING="UTF-8"
fi

if [ -z $EXT ]; then
	echo ""
	echo "Encoding or extension parameters required."
	echo ""
	echo "Usage: convert-charset <target encoding> <extension> "
	echo "   ex: convert-charset UTF-8 txt"
	echo ""
	exit
fi

for file in $PWD/*.$EXT
do
	if [[ $file =~ \.$EXT$ ]]; then

		SRC_ENCODING=$(file -b --mime-encoding "$file")

		echo "[IN > OUT] $SRC_ENCODING > $TGT_ENCODING"
		echo "[ENCODING] iconv -f $SRC_ENCODING -t UTF8 $file"

		mv $file $file.bak
		iconv -f $SRC_ENCODING -t $TGT_ENCODING  $file.bak > $file

		echo "[ENCODED ] $(file -I "$file")"
	else
		echo "[IGNORE  ] is not a $EXT file"
	fi
done

if [ -w $BACKUP ]; then
    	echo "[BACKUP  ] DONE"
	else
		mkdir $BACKUP
fi

mv *.bak backup/.

echo ""
