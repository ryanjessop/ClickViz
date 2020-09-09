#' Generate network graph node data
#'
#' Builds a network graph to represent the transition matrix.
#'
#' @param data Fitted Markov chain
#' @param state_labels Threshold for displaying transition probabilities.
#' @return Network visualisation
#' @examples
#' cls <- readClickstreams(file)
#' mc <- fitMarkovChain(cls)
#' prepare_graph_nodes(mc)
prepare_graph_nodes <- function(data,
                                state_labels=state_labels_ex){

  state_frequencies <- colSums(clickstream::frequencies(data))

  frequency_df <- tibble::tibble(state = names(state_frequencies),
                                 node_size = as.numeric(state_frequencies))

  distinct_labels <- unique(state_labels$node_label)

  qual_col_pals <- RColorBrewer::brewer.pal.info[brewer.pal.info$category == 'qual',]
  colors <- unlist(mapply(RColorBrewer::brewer.pal,
                          qual_col_pals$maxcolors,
                          rownames(qual_col_pals)))[1:length(distinct_labels)]

  state_colors <- tibble::tibble(node_label = distinct_labels,
                                 node_color = colors)

  label_colors <- dplyr::inner_join(state_labels, state_colors, by="node_label")

  graph_nodes <- dplyr::inner_join(frequency_df, label_colors, by="state")

  return(graph_nodes)
}
