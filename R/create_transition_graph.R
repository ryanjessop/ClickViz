#' Create Markov chain transition network
#'
#' Builds a network graph to represent the transition matrix.
#'
#' @param data Fitted Markov chain
#' @param state_labels Threshold for displaying transition probabilities.
#' @return Network visualisation
#' @examples
#' data <- readClickstreams(file)
#' create_transition_graph(data)
create_transition_graph <- function(data, state_labels){

  edges <- prepare_graph_edges(data)
  nodes <- prepare_graph_nodes(data, state_labels)

  plot_graph(edges, nodes)
}
