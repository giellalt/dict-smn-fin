Action points:
 1. add pos value to smn lemma lacking it
 - issues: 

there are 609 smn lemma without pos value
0_inc>cl smn_lemma2tag.txt
     609 smn_lemma2tag.txt

but about 1/3 of them can not be analysed by the current version of the smn analyzer
0_inc>cat smn_lemma2tag.txt |usmn|g '+?'|cl
     192



