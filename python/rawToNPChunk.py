import nltk, re, pprint
from nltk import word_tokenize

# ============ ie_preprocess() ============
# POS tagging to a given source document
def ie_preprocess(document):
	sentences = nltk.sent_tokenize(document)
	sentences = [nltk.word_tokenize(sent) for sent in sentences]
	sentences = [nltk.pos_tag(sent) for sent in sentences]
	return sentences

# a source document
sources = "the little yellow dog barked at the cat."

# get a POS tagged document
pos = ie_preprocess(sources)

# define a grammar for NP chunking
# an NP chunk should be formed whenever the chunker finds an optional determiner (DT) followed by any number of adjectives (JJ) and then a noun (NN)
grammar = "NP: {<DT>?<JJ>*<NN>}"

# create a chunk parcer using the grammar above
cp = nltk.RegexpParser(grammar)

# make a NP chunk from a source sentence using the chunk parcer
result = cp.parse(pos[0])

# print it out
print(result)

# draw it out
result.draw()