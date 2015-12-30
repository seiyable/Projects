import nltk, re, pprint
from nltk import word_tokenize

text = word_tokenize("Hello! This is me. How is it going?")
print(nltk.pos_tag(text))




