Action points:
 1. add pos value to smn lemma lacking it
  1.1 issue: 

there are 609 smn lemma without pos value
0_inc>cl smn_lemma2tag.txt
     609 smn_lemma2tag.txt

but about 1/3 of them can not be analysed by the current version of the smn analyzer
0_inc>cat smn_lemma2tag.txt |usmn|g '+?'|cl
     192

The list of unkown lemmata is in the file unknown_lemma.txt.

Please, have a look at them!

  1.2 issue:
From the analyzed strings, there are to detected as typos. Please, check them, too,
and if necessary correct the data in the dict src file.

0_inc>g Err fst_smn_lemmata_non-Split_clean1.txt
ATK-terminaalâ	ATK-terminaal+Err/Orth
psykoloog	psykolog+Err/Orth

