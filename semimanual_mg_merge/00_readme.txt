
- check and if needed correct pos values of the dict entries by means of the current version of the smn-FST
 ==> DONE

###############################

TODO: double entries in the Adv file:
      2 čyevtib
      2 čuákkist
      2 čuottii
      2 čoođâg
      2 uáivist
      2 ucánjihhii
      2 tástán
      2 tievâ
      2 pelijieggâst
      2 pajeláá
      2 pajeláhháá
      2 ovdâlist
      2 nubetuv
      2 nubetove
      2 njihhood
      2 máccud
      2 mielâst
      2 mannjeed
      2 kuhe
      2 jävriláá



- using the smn-FST, too, I have to generate the word forms as requested by Hannu Kangasniemi for a “printed” version (HTML/PDF/etc.)
 - for N: Gen+Sg form
   ==> DONE

(1) dict sg nouns without sg_gen form
g '<l ' 4_final_output_sg/N_smnfin.xml |g -v ' sg_'|g -v ' status'
         <l pos="N">penâkkullâm</l>
         <l pos="N">psykiatrâ</l>
         <l pos="N">siemkiärtuš</l>
         <l pos="N">telegram</l>

(2) 1184 dict sg noun entries with analysis issues

g '<l ' 4_final_output_sg/N_smnfin.xml |g ' status'|cut -d '>' -f1|t
   1184          <l pos="N" status="_unknown_N"

###

 - for A: Attr form
   ==> DONE


Some statistics:
(1) 26 unknown=unrecognised forms by the current smn-FST
  action point ==> add these forms to the adj-lexc file
 
(2) recognised forms by the current smn-FST, however as N, Adv,
    V, or even A but not as base form (26)
  action point ==> check and correct pos-values accordingly
     58 _known_as_N
      6 _known_as_Adv
      26 +A+Attr
      62 _known_as_V

(3) Overgeneration of attr forms with the current smn-FST:
 action point ==> correct paths in the continuation classes

src>pwd
/Users/cipriangerstenberger/main/words/dicts/smnfin/src
src>grep '<l ' A_smnfin.xml |g ';'|cut -d '"' -f2|tr ';' '\n'|sort|uniq -c|sort -nr

      4 epilyetittettee
      2 siskelumos
      2 ovdemuš
      2 koskâlumos

 ==> TODO

(4) still double-entries
      2 sävri
      2 häänis

 == TODO

(5) analysed as Adj but not attr form generated (might be an error but it might be not: there are adj without attr forms, I assume)
 53
Example:
<l status="no_attr" pos="A">tulcesčievâg</l>

###

 - for V: Sg1, Sg3, and Pl3 form
   ==> DONE

There are 59 double entries in the V-file at the moment.
 ==> action point: to be unified accordingly

There are only 15 verbs missing.

         <l pos="V">čuárvuđâttâđ</l>
         <l pos="V">hámsutâttâđ</l>
         <l pos="V">ráijâšuđ</l>
         <l pos="V">registeeriđ</l>
         <l pos="N">räđđejeijee</l>
         <l pos="V">sámáiditteđ</l>
         <l pos="V">seivâgistiđ</l>
         <l pos="V">siävŋuditteđ</l>
         <l pos="V">skaappuđ</l>
         <l pos="V">spelliđ</l>
         <l pos="V">taaidârâššâđ</l>
         <l pos="V">vaaibâs leđe</l>
         <l pos="V">vyebdimed</l>
         <l pos="V">peessiđ</l>
         <l pos="V">viskâdâs</l>


TODO: the gt-dict-norm-generator delivers nothing for some entries: to debug (perhaps because of +Hom flag)

generate_V>g '+?' 2_dd_out_analysis/V_smnfin.xml
         <l pl3="juávviđ+V+Ind+Prs+Pl3&#09;+?" sg1="juávviđ+V+Ind+Prs+Sg1&#09;+?" sg3="juává" pos="V">juávviđ</l>
         <l pl3="kuullâđ+V+Ind+Prs+Pl3&#09;+?" sg1="kuullâđ+V+Ind+Prs+Sg1&#09;+?" sg3="kuullâđ+V+Ind+Prs+Sg3&#09;+?" pos="V">kuullâđ</l>


###

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


