from __future__ import division  # Python 2 users only
import nltk, re, pprint
from nltk import word_tokenize

from urllib import request
url = "http://www.gutenberg.org/files/2554/2554.txt"
response = request.urlopen(url)
raw = response.read().decode('utf8')

tokens = word_tokenize(raw)
print(tokens[:10])

nltk.Text(tokens)

print(raw.find("PART I"))

