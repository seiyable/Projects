from __future__ import division  # Python 2 users only
import nltk, re, pprint
from nltk import word_tokenize

f = open('document.txt')
raw = f.read()

print(raw[:30])