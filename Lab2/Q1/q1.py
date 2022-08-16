n=raw_input("Enter name:")
r=raw_input("Enter roll no. :")
b=raw_input("Enter branch :")
s=raw_input("Enter semester :")
filename=b[0]+s+".txt"
f=open(filename)
c=raw_input("How many courses you want to take?")
print "Choose from :"
print (f.read())
l=[]
print("Enter course ID's: ")
for i in range(int(c)):
	x=raw_input()
	l.append(x)
with open(filename) as f:
    with open("student course info.txt", "a") as f1:
    	f1.write("\n"+"\n"+"Name: "+n+" Roll No.: "+r+" Semester: "+s+"\n")
        for line in f:
        	l1=[]
        	l1=line.split(" ")
        	if l1[0] in l:
				f1.write(line)
