import networkx as nx
G=nx.read_edgelist("articles+4.txt")
pr = nx.pagerank(G,0.4) #0.4 is the value of alpha
print(pr)
