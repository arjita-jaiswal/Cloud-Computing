
from nltk.corpus import stopwords 
from nltk.tokenize import word_tokenize 
f=open("q2.txt")
  
filename = f.read()
  
stop_words = set(stopwords.words('english')) 
  
word_tokens = word_tokenize(filename) 
  
filtered_sentence = [w for w in word_tokens if not w in stop_words] 

for w in word_tokens: 
    if w not in stop_words: 
        filtered_sentence.append(w)

print "Top 10 keywords ignoring stopwords\n"
for x in range(10):
	print(filtered_sentence[x])
