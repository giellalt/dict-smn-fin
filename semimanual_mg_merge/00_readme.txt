
- check and if needed correct pos values of the dict entries by means of the current version of the smn-FST
 ==> DONE

###############################

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

---update:
20171103
    211          <l status="_unknown_" pos="A"
     53          <l status="no_attr" pos="A"
     46          <l status="_known_as_N" pos="A"
      4          <l status="_known_as_Adv" pos="A"
update---



Some statistics:
(1) 211 unknown=unrecognised forms by the current smn-FST
  action point ==> add these forms to the adj-lexc file
 
(2) 50 recognised forms by the current smn-FST, however as N or Adv
  action point ==> check and correct pos-values accordingly
     46 _known_as_N
      4 _known_as_Adv

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

generate_V>g '<l ' 2_dd_out_analysis/V_smnfin.xml |cut -d '>' -f1|t|g ' 2 '|cl
62

There are 62 double entries in the V-file at the moment.
 ==> action point: to be unified accordingly

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


