import nltk
nltk.download('averaged_perceptron_tagger')
nltk.download('punkt')

import pandas as pd
def clean_str(s0):
  tagged = nltk.pos_tag(nltk.word_tokenize(s0))
  return " ".join([word[0] for word in tagged if word[1]=="NNP"])

def name_clean(authors):
  return clean_str(mess) if mess == mess else "" for mess in authors]
