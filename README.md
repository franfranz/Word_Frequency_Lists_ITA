# Word_frequency_Lists_IT
Handy frequency lists in Italian calculated from the corpus ItWac (Baroni, M., Bernardini, S., Ferraresi, A., & Zanchetta, E., 2009).

## Contents: 
### Lists
* **"itwac_nouns_lemmas_notail_2_0_0.csv"** List of word form tagged as nouns. 
  Contains: wordform, lemma, POS, frequency (raw), frequency per million words (fpmw), frequency (zipf). Calculated using countlemma_v2.0.0
  
* **"itwac_verbs_lemmas_notail_2_1_0.csv"** List of word form tagged as verbs. 
  Contains: wordform, lemma, POS, modality, POS2 (ideally, functional verbs), frequency (raw), frequency per million words (fpmw), frequency (zipf).  Calculated using countlemma_verb_2_1_0.
  
* **"itwac_verbs_list_of_lemmas_2_1_0.csv"** List of lemmas from most to least represented across wordforms.
  
  
### Code  
* **"countlemma_v2.0.0.R"** Code used to provide a frequency list of all the NOUN forms present in Itwac, tagged for POS and lemma. 
    This version is less time consuming in handling big files if compared to v_1. 
    
* **"countlemma_verb_2_1_0.R"** Code used to provide a frequency list of all the VERB forms present in Itwac, tagged for POS, lemma, modality. 
    
    
