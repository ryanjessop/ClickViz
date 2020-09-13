#' Prepare the network vertices
#'
#' Find the frequency of each state in the clickstream data.
#' Output dataframe of network vertices and labels.
#'
#' @param data Clickstream data
#' @param vertex_labels A dataframe of labelled states (state, vertex_label)
#' @return Network vertices data
#' @examples
#' cls <- readClickstreams(file)
#' prepare_network_vertices(cls, vertex_labels)
prepare_network_vertices <- function(data,
                                     vertex_labels){

  state_frequencies <- colSums(clickstream::frequencies(data))

  frequency_df <- tibble::tibble(state = names(state_frequencies),
                                 vertex_size = as.numeric(state_frequencies))

  distinct_labels <- unique(vertex_labels$vertex_label)

  qual_col_pals <- RColorBrewer::brewer.pal.info[RColorBrewer::brewer.pal.info$category == 'qual',]
  colors <- unlist(mapply(RColorBrewer::brewer.pal,
                          qual_col_pals$maxcolors,
                          rownames(qual_col_pals)))[1:length(distinct_labels)]

  colors_df <- tibble::tibble(vertex_label = distinct_labels,
                              vertex_color = colors)

  label_colors <- dplyr::inner_join(vertex_labels, colors_df, by="vertex_label")

  network_vertices <- dplyr::inner_join(frequency_df, label_colors, by="state")

  return(network_vertices)
}
