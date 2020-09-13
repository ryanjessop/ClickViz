#' Create the transition network
#'
#' A quick plot of the first order Markov chain transition matrix.
#'
#' @param data Clickstream data
#' @param vertex_labels A dataframe of labelled states (state, vertex_label)
#' @return Network visualisation of the transition matrix
#' @examples
#' cls <- readClickstreams(file)
#' create_transition_network(cls, vertex_labels)
create_transition_network <- function(data, vertex_labels){

  edges <- prepare_network_edges(data)
  vertices <- prepare_network_vertices(data, vertex_labels)

  plot_transition_network(edges, vertices)
}
