#' Generate network graph edge data
#'
#' Builds a network graph to represent the transition matrix.
#'
#' @param mc Fitted Markov chain
#' @param lower_bound Threshold for displaying transition probabilities.
#' @return Network visualisation
#' @examples
#' cls <- readClickstreams(file)
#' mc <- fitMarkovChain(cls)
#' prepare_graph_edges(mc)
prepare_graph_edges <- function(data,
                                lower_bound=0.01){

  mc <- clickstream::fitMarkovChain(data)
  transition_matrix <- as.data.frame(t(mc@transitions$`1`))
  state <- rownames(transition_matrix)
  add_state_column <- cbind(state, transition_matrix)

  tidy_transitions <- tidyr::gather(add_state_column,
                                    as.vector(state),
                                    key = 'next_state',
                                    value = 'transition_p') %>%
    dplyr::filter(transition_p > lower_bound) %>%
    dplyr::mutate(join_col = round(transition_p, 2))

  max_p <- max(tidy_transitions$join_col)
  count_sequence <- seq(0,max_p,0.01)

  color_map <- tibble::tibble(
    greyscale = grDevices::gray.colors(max_p*100 + 1,
                                       start = 0,
                                       end = 0,
                                       alpha = count_sequence),
    join_col = count_sequence)

  graph_edges <- dplyr::inner_join(tidy_transitions, color_map, by="join_col")

  return(graph_edges)
}
