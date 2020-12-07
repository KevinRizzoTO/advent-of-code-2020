import re

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


def traverse(graph, node):
    global found
    global visited

    if node not in visited:
        visited.add(node)

        for neighbour in graph[node]:
            if neighbour == "shiny gold" or traverse(graph, neighbour):
                found.add(node)

        if node in found:
            return True

    else:
        return node in found

for root in m:
    traverse(m, root)

print(len(found))
