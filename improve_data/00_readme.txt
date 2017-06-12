Action points:
  - add pos value to smn lemma lacking it
  - Move Participles out of the V file

Other issues:
  - A file lemma_not_in_fst.rev (see below)

 add pos value to smn lemma lacking it
 =====================================
src>g '<l pos="X"' Saami-suoma_smnfin.xml |cl
      2

src>g '<l pos="X"' Saami-suoma_smnfin.xml
         <l pos="X" rest="">uulgah</l>
         <l pos="X" rest="">vuávnus</l>

Have a look at them in the file more_unknown_lemma.txt.




 Move Participles out of the V file
 =====================================

There are 269 participles in the V file:

grep '<l .*m</l>' src/V_smnfin.xml |wc -l
     269

These should either be removed or moved to the adjektive file.



lemma_not_in_fst.rev
====================

This file contains words that are lemmaforms in the smnfin dictionary
but are not recognised by the fst. These should be
- added to the fst, or
- corrected in the dictionary, or
- both







