# Starknet-CC Workshop : Develop your own graph

## Introduction

In this workshop, you'll need to code in Cairo all the methods required to create a Graph in Cairo.
You will need to write code that matches the function descriptions. Each time you have finished coding a function, you can test it by calling `protostart test ::test_function_name`.

## Adapting data structures to Cairo

How would you code a graph in a "normal" programming language ?
In a regular language, you would probably define your graph as an adjacency list, such that to each vertex would be associated a list of (destination, weight)
It could look like something like this:

```typescript
type Graph : Map<source,AdjacentVertices>
type AdjacentVertices : List<AdjacentVertex>
type AdjacentVertex : Pair<destination,weight>
```

It would then be fairly easy to define function to build a graph from an array of edges by simply adding vertices to the `AdjacentVertices` list corresponding to the current node with something like

```javascript
let graph = new HashMap<>();
for (edge in edges) {
  let originId = edge.getOriginId();
  let destinationId = edge.getDestinationId();
  let weight = edge.getWeight();

  let adjacentVertices = graph.getVertex(originId) || new List();
  adjacentVertices.push(new Pair(destinationId, weight));
  graph[originId] = adjacentVertices;
}
```

We could translate this behavior in cairo to something like this :

```
struct Graph {
    length:felt,
    vertices: Vertex*,
    adjacent_vertices_count: felt*,
}

struct Vertex {
    index: felt,
    identifier: felt,
    adjacent_vertices: AdjacentVertex*,
}

struct AdjacentVertex {
    dst: Vertex,
    weight: felt,
}

```

But why does it look different than in another programming language ?
Things get harder when writing this in Cairo, because remember :
In Cairo, memory is **write-once only** and remember, we have to **keep track of each array's length**

Are you adding a new vertex to an adjacency list `adjacent_vertices` ?
You also need to update the `adjacent_vertices_len` value. But if each `Vertex` has `adjacent_vertices` and
`adjacent_vertices_len` members, and your Graph is represented as a list of `Vertex*`, well, then you're stuck.
Because while you can append a new member to an existing array, you can't update the value `adjacent_vertices_len`
which has already been written into memory. This forces you to recreate a new Vertex with the updated length value, but then,
your graph data structure is not correct anymore because the `vertices` array points to the wrong vertex.

Here's how we're going to solve this :

- We're not going to track each vertex's adjacency list length inside the vertex, but rather we're going to track it inside the graph
  stored as a list that associates each vertex to its number of neighbors.
- When appending a new destination vertex to an adjacency list, we are going to update the value in `Graph.adjacent_vertices_count`
  (see `func update_value_at_index` in `src.utils`). This allows us to not recreate the whole data structure on each update,
  but to only recreate the updated array, saving computation ressources.

Just a few words on the design choice of the Graph itself : as you noticed, it's not defined as a mapping from `id->AdjacencyList`.
It's a simple array. To each index of the array is associated a specific vertex, which holds this information, so that we can access
it in constant times by calling `graph[vertex_id]`

## Summary

In this example,

- The graph is an array of vertices.
- To each vertex is associated an index.
- We can access in O(1) every vertex by calling `Graph.vertices[index]`.
- We need to externally keep track of each vertex's adjacency list length, because cairo's memory is immutable.
- We also need to keep track of the graph's length (i.e. the number of vertices) by updating the `Graph` data structure upon each vertex creation.
