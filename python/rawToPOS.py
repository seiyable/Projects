import nltk, re, pprint
from nltk import word_tokenize

def ie_preprocess(document):
	sentences = nltk.sent_tokenize(document)
	sentences = [nltk.word_tokenize(sent) for sent in sentences]
	sentences = [nltk.pos_tag(sent) for sent in sentences]
	return sentences

source = "My grandfather is going to the hospital. Does she have illness?"
result = ie_preprocess(source)
print(result)
