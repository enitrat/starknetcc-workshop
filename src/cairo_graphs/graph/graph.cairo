from starkware.cairo.common.memcpy import memcpy
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.math import assert_not_equal

from cairo_graphs.data_types.data_types import Vertex, Edge, AdjacentVertex, Graph
from cairo_graphs.utils.array_utils import Array

// # Adjancency list graph implementation

namespace GraphMethods {
    // @notice Creates a new empty graph and returns it.
    // @returns graph the empty created Graph.
    func new_graph() -> Graph {
        // TODO Number 1
        // Remember that inside a `Graph` DS are two arrays.
        // We need to allocate memory for these array when creating the graph.
    }

    // @notice Builds an undirected graph from an array of edges.
    // @param edges_len : The length of the array of edges
    // @param edges : The array of edges
    // @returns graph : The graph generated from the array of edges
    func build_undirected_graph_from_edges(edges_len: felt, edges: Edge*) -> Graph {
        // TODO Number 8
    }

    // @notice Builds a directed graph from an array of edges.
    // @param edges_len : The length of the array of edges
    // @param edges : The array of edges
    // @returns graph : The graph generated from the array of edges
    func build_directed_graph_from_edges(edges_len: felt, edges: Edge*) -> Graph {
        // TODO Number 9
    }

    // @notice Adds an edge between two graph vertices
    // @dev If the vertices don't exist yet, also adds them to the graph
    // @param graph : The graph we're adding the edges to
    // @param edge : Edge to add to the graph. Has info about the src_identifier, dst_identifier
    // and edge weight.
    // @returns the updated Graph
    func add_edge(graph: Graph, edge: Edge) -> Graph {
        // TODO Number 5
        // Step 1 : get the index of the edge vertices.
        // Step 2 : Add both vertices to the graph if they aren't already there
        // Step 3 : Add the src->dst edge to the graph. It's stored inside the adjacency list of
        // a given vertex
    }

    // @notice Adds a vertex to the graph.
    // @dev Creates a new vertex stored at graph.vertices[graph_len].
    // @param graph : The graph we want to add the vertex to.
    // @param identifier : Unique identifier of the vertex to add.
    // @returns graph_len : The updated graph.
    func add_vertex_to_graph(graph: Graph, identifier: felt) -> Graph {
        // TODO number 4
        // Step 1 : allocate memory for the felt array that will hold all neighbors of the vertex.
        // Step 2 : Create the new vertex structure & append it to the graph vertices.
        // Step 3 : Don't forget to track how many neighbors this new vertex has - here, 0.
        // Step 4 : Updated the graph and return it.
    }

    // @notice Recursive function returning the index of the node in the graph
    // @dev We can use implicit arguments to avoid the need to specify them in each subsequent call.
    // @param graph : The graph we're working with.
    // @param identifier, The unique identifier of the vertex.
    // @returns -1 if it's not in the graph, the index in the graph.vertices array otherwise
    func get_vertex_index{graph: Graph, identifier: felt}(current_index) -> felt {
        // TODO Number 2
        // Simple recursion loop that stops when the current index equals the graph length
        // or when the vertex is found.
    }
}

// @notice adds a neighbor to the adjacent vertices of a vertex
// @param vertex : The vertex to add the neighbor to.
// @param new_neighbor : The neighbor to add to the vertex.
// @param adj_vertices_count_len : The length of the adj_vertices_count array.
// @param adj_vertices_count : Array that tracks how many adjacent vertices each vertex has.
// @param vertex_index_in_graph : The index of the vertex in the graph.
// @return the updated adj_vertices_count
func add_neighbor(
    vertex: Vertex, new_neighbor: Vertex, graph: Graph, vertex_index_in_graph: felt, weight: felt
) -> Graph {
    // TODO Number 3
    // Step 1 : Append the new neighbor to the neighbors array of the current vertex.
    // Step 2 : Update neighbor count for the vertex (use Array.update_value_at_index).
    // Step 3 : Return the updated graph.
}

// @notice internal function to build the graph recursively
// @dev
// @param pairs_len : The length of the pairs edges_len
// @param edges : The edges array
// @param graph : The graph
func build_undirected_graph_from_edges_internal(
    edges_len: felt, edges: Edge*, graph: Graph
) -> Graph {
    alloc_locals;
    // TODO Number 7
    // Stop condition : edges_len = 0
    // Loop on all edges : add 1. Edge(src,dst,weight) 2. Edge(dst,src,weight)
}

// @notice internal function to build the graph recursively
// @dev
// @param pairs_len : The length of the pairs array
// @param pairs : The pairs array
// @param graph : The graph
func build_directed_graph_from_edges_internal(
    edges_len: felt, edges: Edge*, graph: Graph
) -> Graph {
    alloc_locals;
    // TODO Number 6
    // Stop condition : edges_len = 0
    // Loop on all edges : add 1. Edge(src,dst,weight)
}
