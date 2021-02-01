# Word_frequency_Lists_ITA
Handy frequency lists in Italian calculated from the corpus ItWac (Baroni, M., Bernardini, S., Ferraresi, A., & Zanchetta, E., 2009).

## Contents: 
### Lists
* [itwac_nouns_lemmas_notail_2_0_0.csv](https://github.com/franfranz/Word_Frequency_Lists_ITA/blob/main/itwac_nouns_lemmas_notail_2_0_0.csv) List of word forms tagged as **NOUNS**. The minimum token frequency in this list is 3. 
  Contains: wordform, lemma, POS, frequency (raw), frequency per million words (fpmw), frequency (zipf). Encoding: utf-8. Calculated using countlemma_v2.0.0
 
 * [itwac_nouns_lemmas_raw_2_0_0.zip](https://github.com/franfranz/Word_Frequency_Lists_ITA/blob/main/itwac_nouns_lemmas_raw_2_0_0.zip) List of word forms tagged as **NOUNS**. The minimum token frequency in this list is 1. 
  Contains: wordform, lemma, POS, frequency (raw), frequency per million words (fpmw), frequency (zipf). Encoding: utf-8. Calculated using countlemma_v2.0.0
   
* [itwac_verbs_lemmas_notail_2_1_0.csv](https://github.com/franfranz/Word_Frequency_Lists_ITA/blob/main/itwac_verbs_lemmas_notail_2_1_0.csv) List of word forms tagged as lexical **VERBS** (no auxiliary verbs). 
  Contains: wordform, lemma, POS, modality, POS2 (ideally, functional verbs), frequency (raw), frequency per million words (fpmw), frequency (zipf).  Encoding: utf-8. Calculated using countlemma_verb_2_1_0.
  
* [itwac_verbs_list_of_lemmas_2_1_0.csv](https://github.com/franfranz/Word_Frequency_Lists_ITA/blob/main/itwac_verbs_list_of_lemmas_2_1_0.csv) List of lemmas from most to least represented across lexical **VERB** wordforms. Encoding: utf-8. Calculated using countlemma_verb_2_1_0.
  
  
### Code  
* [countlemma_v2.0.0.R](https://github.com/franfranz/Word_Frequency_Lists_ITA/blob/main/countlemma_v2_0_0.R) Code used to provide a frequency list of all the NOUN forms present in Itwac, tagged for POS and lemma. 
    This version is less time consuming in handling big files if compared to v_1. 
    
* [countlemma_verb_2_1_0.R](https://github.com/franfranz/Word_Frequency_Lists_ITA/blob/main/countlemma_verb_2_1_0.R) Code used to provide a frequency list of all the VERB forms present in Itwac, tagged for POS, lemma, modality. 
 
 
