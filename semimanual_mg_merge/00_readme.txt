- check and if needed correct pos values of the dict entries by means of the current version of the smn-FST
 ==> ONGOING
- using the smn-FST, too, I have to generate the word forms as requested by Hannu Kangasniemi for a “printed” version (HTML/PDF/etc.)
 - for N: Gen+Sg form
   ==> TODO
###############################

 - for A: Attr form
   ==> DONE

 - issue to solve:
   (A_1): more than one Attr form ==> add both?  
     Ex.
<l attr="áánsášmettum___áánsášmáttum" pos="A">áánsášmettum</l>
<l attr="áánsâšmettum___áánsâšmáttum" pos="A">áánsâšmettum</l>
<l attr="arâdis___arâdâs" pos="A">aarrâd</l>
<l attr="aavâštmettum___aavâštmáttum" pos="A">aavâštmettum</l>
<l attr="ahevis___ahevâs" pos="A">ahheev</l>

   (A_2): unknown forms (see file unknown_forms/A_unknown.txt)
    Ex.
abstrakt        +?
addâgâsaddeelhánnáá     +?
addâgâsânaddeelhánnáá   +?
aldaaš  +?
alleen  +?
ánulâs  +?
ášáškuttum      +?
čálálâs +?
čálámuš +?
ceggust +?
celkkimiättum   +?

   (A_3): analysis as anything else but A (grep for '<analysis' in interim_generated_forms/A_smnfin.xml)
    Ex.
   <e id="A_9">
      <lg>
         <l pos="A">aargâi</l>
      <analysis>
aargâi+Adv
argâ+N+Pl+Gen
</analysis></lg>


   <e id="A_22">
      <lg>
         <l pos="A">addiitteijee</l>
      <analysis>
addiđ+V+TV+Der/tt+V+PrsPrc
addiđ+V+TV+Der/tt+V+Der/NomAg+N+Sg+Gen
addiđ+V+TV+Der/tt+V+Der/NomAg+N+Sg+Acc
addiđ+V+TV+Der/tt+V+Der/NomAg+N+Sg+Nom
addiitteijee+N+NomAg+Sg+Gen
addiitteijee+N+NomAg+Sg+Acc
addiitteijee+N+NomAg+Sg+Nom
</analysis></lg>

   <e id="A_23">
      <lg>
         <l pos="A">addiittijjee</l>
      <analysis>
addiđ+V+TV+Der/tt+V+PrsPrc
</analysis></lg>


   (A_4): analysis as A  but not Attr-form generated (grep for '+A+Sg+Nom' in interim_generated_forms/A_smnfin.xml)
    Ex.
   <e id="A_34">
      <lg>
         <l pos="A">áimučavos</l>
      <analysis>
áimučavos+A+Sg+Nom
</analysis></lg>

áimučavos+A+Sg+Nom
jiävtáš+A+Sg+Nom
juárbudeves+A+Sg+Nom
moonnâmkiiđâš+A+Sg+Nom
onnáš+A+Sg+Nom
oovdiš+A+Sg+Nom
tááláš+A+Sg+Nom
táássáš+A+Sg+Nom
tallaš+A+Sg+Nom
tiijmáš+A+Sg+Nom
toldeves+A+Sg+Nom
toovláš+A+Sg+Nom
vááiváš+A+Sg+Nom

###############################

 - for V: Sg1 form
   ==> TODO

###############################

 - for V': Sg1 form and Sg3 form
   ==> TODO

###############################

V' var trestava. Eg har sett litt meir på det, og gjer det litt meir feinschmeckerisch. La oss sjå kva Hannu seier.

3-stava-verb (merka 3_ i lexc): skal ha Ind Prs Sg3
Kontrakte verb (merka C_) skal ha Ind Prs Sg1, Ind Prs Pl3
Andre verb (merka med 2_ eller 4_, men altså: alle andre) skal ha Ind Prs Sg1, Ind Prs Sg3

Vi merker formene med personleg pronomen foran verbforma:
Sg1 = mun
Sg3 = sun
Pl3 = sij

Dei trestava verba har alle leksika som er merka "3_" i stems/verbs.lexc, dvs. det er desse:


3-stava:

 377 3_CIELATTID
 368 3_LEKKASID
 292 3_KUIKETTID
 159 3_PUTESTID
 112 3_CIELATTID_TV
 102 3_VYEJETTID
 102 3_COKKIITTID
 101 3_LEKKASID_TV
  76 3_KUIKETTID_TV
  75 3_MERIDID
  75 3_KUIKETTID_IV
  61 3_LEKKASID_IV
  49 3_CIELATTID_IV
  43 3_PUTESTID_TV
  38 3_ADELID
  30 3_VYEJETTID_TV
  30 3_PUTESTID_IV
  27 3_VYEJETTID_IV
  21 3_MERIDID_IV
  17 3_COKKIITTID_TV
  16 3_MERIDID_TV
   9 3_ADELID_TV
   7 3_COKKIITTID_IV
   6 3_ADELID_IV


Kontrakte:

 277 C_TABAHTUD
 220 C_TUHHID
 141 C_COKKAD
 129 C_TUHHID_TV
 114 C_RAMMUD
  78 C_TABAHTUD_IV
  32 C_COKKAD_IV
  31 C_PALLAD
  28 C_TUHHID_IV
  25 C_RAMMUD_IV
  25 C_COKKAD_TV
  12 C_RAMMUD_TV
  11 C_MERIDUD
   9 C_PALLAD_TV
   8 C_TABAHTUD_TV
   3 C_PALLAD_IV
   2 C_PASS_SH
   2 C_MERIDUD_IV
   1 C_HOLHOD

Resten altså Sg1, Sg3.

========================

Ciprian:
Men jeg tror jeg ar et liten problem.
Når jeg sender grunnformen til generering, har jeg ikke informasjonen at det handler om en vanlig verb eller en trestavaverb.

Det vil si at jeg må greppe informasjonen ut av lexc-filen, ikke sant?

Trond:
Ja, det betyr det.

Det er sjølvsagt mogleg å legge til ein info i xml i ordboka, som vi gjer det i oahpa-xml-filene, kva som er best veit du betre enn eg.

Til ein viss grad (for over halve lista av verb) er det mogleg å sjå skilnaden mellom dei ulike typene ved å sjå på vokalen før final đ kombinert med å telje stavingar, men for ein del verb er det ikkje mogleg, og du må bruke info i contlex.


