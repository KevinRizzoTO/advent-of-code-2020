BEGIN {
  adapters[1] = 0
}

{
  adapters[NR + 1] = $0
}

function create_graph(arr,  i, j, nlength) {
  for (i = 1; i <= length(arr); i++) {
    curr = arr[i]
    for (j in graph) {
      
      if (graph[j][1] == "READY") {
        delete graph[j][1]
      }

      if (curr <= j + 3) {
        nlength = length(graph[j]) 
        graph[j][nlength + 1] = curr
      }
    }

    graph[curr][1] = "READY"
  }
}

function count_paths(g, c, d,   visited, i, n) {
  visited[c] = 1

  if (c == d) {
    paths++
  } else {
    for (i in g[c]) {
      n = g[c][i]
      if (!visited[n]) {
        count_paths(g, n, d, visited)
      }
    }
  }

  visited[c] = 0
}

END {
  asort(adapters)

  adapters_length = length(adapters)

  # Add device to list of adapters
  device_joltage = adapters[adapters_length] + 3
  adapters[adapters_length + 1] = device_joltage

  create_graph(adapters)
  
  count_paths(graph, 0, device_joltage)

  print(paths)
}
