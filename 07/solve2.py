import re

f = open('./input.txt', 'r')

m = {}

parentRe = re.compile(r'^(\w+ \w+)')
childrenRe = re.compile(r'(\d+) (\w+ \w+) bags?[\s|,|.]')

for line in f:
    parent = parentRe.search(line)

    m[parent[0]] = []

    children = childrenRe.findall(line)

    for c in children:
        m[parent[0]].append({
            'number': int(c[0]),
            'color': c[1]
        })

def get_bag_sum(graph, node):
    s = 0

    for neighbour in graph[node]:
        if len(graph[neighbour['color']]):
            s += neighbour['number'] * get_bag_sum(graph, neighbour['color'])
        
        s += neighbour['number'] 

    return s

print(get_bag_sum(m, 'shiny gold'))
