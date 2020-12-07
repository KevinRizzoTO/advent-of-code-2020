import re
import matplotlib.pyplot as plt
import networkx as nx

f = open('./input.txt', 'r')

m = {}
r = re.compile(r'(\w+ \w+) bags?[\s|,|.]')

found = set()
visited = set()

for line in f:
    matches = r.findall(line)
    parent = matches[0]

    m[parent] = []

    if matches[1] != "no other":
        for color in matches[1:]:
            m[parent].append(color)

G = nx.Graph(m)
nx.draw_networkx_edges(G, pos=nx.spring_layout(G), alpha=0.5)

plt.figure(figsize=(30,30))
nx.draw_networkx(G, node_size=0.7, width=0.01, font_size=5)

plt.savefig("graph.pdf")
