#' Prepare the network edges
#'
#' Transform and clean the clickstream data into transition probabilites, p_{i,j}.
#' Output dataframe of network edges.
#'
#' @param data Clickstream data
#' @param alpha Display only p_{i,j} > alpha
#' @return Network edges data
#' @examples
#' cls <- readClickstreams(file)
#' prepare_network_edges(cls)
prepare_network_edges <- function(data,
                                  alpha=0.01){

  mc <- clickstream::fitMarkovChain(data)
  transition_matrix <- as.data.frame(t(mc@transitions$`1`))
  state <- rownames(transition_matrix)
  add_state_column <- cbind(state, transition_matrix)

  tidy_transitions <- tidyr::gather(add_state_column,
                                    as.vector(state),
                                    key = 'next_state',
                                    value = 'transition_p') %>%
    dplyr::filter(transition_p > alpha) %>%
    dplyr::mutate(join_col = round(transition_p, 2))

  max_p <- max(tidy_transitions$join_col)
  count_sequence <- seq(0,max_p,0.01)

  color_map <- tibble::tibble(
    greyscale = grDevices::gray.colors(max_p*100 + 1, start = 0, end = 0,
                                       alpha = count_sequence),
    join_col = count_sequence)

  network_edges <- dplyr::inner_join(tidy_transitions, color_map, by="join_col")

  return(network_edges)
}
