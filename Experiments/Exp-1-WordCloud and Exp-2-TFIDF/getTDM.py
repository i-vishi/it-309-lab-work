# this program is made to organise the result recieved as output from TFIDF.java.
# this program organises the output in as a Matrix
with open('tfidfnewdata.txt', 'r') as f:
    l = [[num for num in line.split('\t')] for line in f]

pos = 0
for i in l:
    mat.append(i[0].split('#####'))
    mat[pos].append(i[1][:-1])
    pos += 1

terms = set()
docs = set()
for i in mat:
    terms.add(i[0])
    docs.add(i[1])

terms = list(terms)
docs = list(docs)

terms = sorted(terms)
docs = sorted(docs)

termPos = {}
pos = 0
for i in terms:
    termPos[i] = pos
    pos += 1

docPos = {}
pos = 0
for i in docs:
    docPos[i] = pos
    pos += 1

tdm = [[0] * len(docs)] * len(terms)
for i in mat:
    term = i[0]
    doc = i[1]
    val = i[2]
    tdm[termPos[term]][docPos[doc]] = val
tc = 10
print("          ", end="\t\t\t")
for i in range(len(docs)):
    print("Doc", i, end="\t\t")
print("\n")
for i in range(tc):
    print(terms[i], end="\t\t\t")
    print(*tdm[i])
