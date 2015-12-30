#coding: UTF-8

friends = ["cat", "dog", "frog", "monkey"]

def blame(name):
	print "you suck, %s" % name

map(blame, friends)


