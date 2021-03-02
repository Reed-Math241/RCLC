import nltk
import pandas as pd

nltk.download('averaged_perceptron_tagger')
nltk.download('punkt')


def clean_str(s0):
  tagged = nltk.pos_tag(nltk.word_tokenize(s0)) #Tags parts of speech
  return " ".join([word[0] for word in tagged if word[1]=="NNP"]) #extraxts proper nouns

def name_clean(authors):
  return [clean_str(mess) if mess == mess else "" for mess in authors] #applies to all values

df = pd.read_csv("dev/RCLC.csv") #reads
df["Author"] = name_clean(df["Author"]) #applies

df.to_csv("dev/RCLC.csv", encoding='utf-8', index=False) #writes
