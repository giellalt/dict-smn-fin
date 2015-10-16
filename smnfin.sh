
# Dette skal bli ei makefil for å lage smnfin.fst, 
# ei fst-fil som tar smn og gjev ei fin-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage smnfin.fst

# @cip: makefilen er allerede for lengst ferdig,
# dette skriptet kan slettes.
# ../make-bildict
# kommando:
# make -f make-bildict SLANG=swe TLANG=sma TNUM=all

# sh smnfin.sh

echo ""
echo ""
echo "---------------------------------------------------"
echo "Shellscript to make a transducer of the dictionary."
echo ""
echo "It writes a lexc file to bin, containing the line	 "
echo "LEXICON Root										 "
echo "Thereafter, it picks lemma and first translation	 "
echo "of the dictionary, adds them to this lexc file,	 "
echo "and compiles a transducer bin/smnfin.fst		 "
echo ""
echo "Usage:"
echo "lookup bin/smnfin.fst"
echo "---------------------------------------------------"
echo ""
echo ""

echo "LEXICON Root" > bin/smnfin.lexc
cat src/*_smnfin.xml | \
tr -d '[!:;]'         | \
grep '^ *<[lt][ >]'  | \
sed 's/^ *//g;'      | \
sed 's/<l /™/g;'     | \
tr '\n' '£'          | \
sed 's/£™/€/g;'      | \
tr '€' '\n'          | \
tr '<' '>'           | \
cut -d'>' -f2,6      | \
tr '>' ':'           | \
tr ' ' '_'           | \
sed 's/$/ # ;/g;'    >> bin/smnfin.lexc        

#xfst -e "read lexc < bin/smnfin.lexc"

printf "read lexc < bin/smnfin.lexc \n\
invert net \n\
save stack bin/smnfin.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile



