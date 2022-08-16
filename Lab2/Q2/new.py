def readfile(fname):
	print ((open(fname)).read())
	print '\n'

def top10words(fname):
	print ("Top 10 words :")
	num_words = 0
	c=0
	with open(fname) as f:
	#print (f.read())
		for line in f:
			words = line.split()
			num_words += len(words)
			for x in range(len(words)):
				if c<10:
					print (words[x])
					c=c+1
	print '\n'
	print("Total number of words:"+str(num_words))

def main():
	fname = raw_input("Enter file name: ")
	print '\n'
	readfile(fname)
	top10words(fname)

if __name__ == '__main__':
	main()



