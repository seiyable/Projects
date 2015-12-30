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
sources = "Mary saw the cat sit on the mat"
sentence = [("Mary", "NN"), ("saw", "VBD"), ("the", "DT"), ("cat", "NN"),
    ("sit", "VB"), ("on", "IN"), ("the", "DT"), ("mat", "NN")]

# get a POS tagged document
pos = ie_preprocess(sources)

# define a grammar for a chunk parser
grammar = r"""
	NP: {<DT|JJ|NN.*>+}          # Chunk sequences of DT, JJ, NN
	PP: {<IN><NP>}               # Chunk prepositions followed by NP
	VP: {<VB.*><NP|PP|CLAUSE>+$} # Chunk verbs and their arguments
	CLAUSE: {<NP><VP>}           # Chunk NP, VP
	"""

# make a chunk parser with the grammar
cp = nltk.RegexpParser(grammar)

# parse the POS tagged document
result = cp.parse(sentence)

print(result)
result.draw()