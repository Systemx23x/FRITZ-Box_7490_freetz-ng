#! /usr/bin/env bash
# generates docs/dad/README.md
SCRIPT="$(readlink -f $0)"
PARENT="$(dirname $(dirname ${SCRIPT%/*}))"


#get
LANG=C  wget --spider --recursive --no-verbose --no-parent 'https://download.avm.de' 2>&1 | tee dad
sed -rn 's,.* URL: (.*\.image) 200 OK,\1,p' -i dad

#cat
for cat in $(sed 's,^https://download.avm.de/,,;s,/.*,,g' dad | uniq); do
c="$cat"
[ "${cat#fritz}" != "$cat" ] && cat="${cat:5}" && cat="Fritz${cat^}"
[ "$cat" != "archive" ] && CATS="$CATS$c $cat\n"
done

#gen
(
echo -e '[//]: # ( Do not edit this file! Run generate.sh to create it. )'
echo -n "Content: "
echo -e "$CATS" | grep -v ^$ | while read c cat; do echo -n "[$cat](#$(echo ${cat,,} | sed 's/ /-/g')) - "; done | sed 's/...$//'
echo
echo -e '# Temporär verfügbare Firmware-Dateien auf [download.avm.de/](https://download.avm.de/)'
echo -e ' - Das Unterverzeichnis archive/ ist nicht enthalten.'
echo -e ' - Diese Liste ist weder vollständig, korrekt noch aktuell.'
echo -e "$CATS" | grep -v ^$ | while read c cat; do
	echo -e "\n### $cat"
	sed -rn "s,^https://download.avm.de/$c/,,p" dad | while read -s line; do
		new="${line%%/*}"
		[ "$old" != "$new" ] && echo " * $new/" && old="$new"
		file="${line#$new/}" ; file="${file//\/fritz.os\//:}" ; file="${file//\/recover\//-recover:}" ; kind="${file%%:*}" ; file="${file##*:}"
		echo "   - ${kind//%20/ }: [${file//%20/ }](https://download.avm.de/$c/$line)"
	done
done
) | sed 's/_-/-/' > $PARENT/docs/dad/README.md

#tmp
rm -f dad
rmdir download.avm.de/*/* download.avm.de/* download.avm.de/ 2>/dev/null

