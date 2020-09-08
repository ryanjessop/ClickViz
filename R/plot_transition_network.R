#' Plot Markov chain transition network
#'
#' @param x A number.
#' @param y A number.
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' cls <- readClickstreams(file)
#' mc <- fitMarkovChain(cls)
#' plot_transition_network(mc)
#'
#'
plot_transition_network <- function(mc,
                                    lower_bound=0.01,
                                    state_hits=c(127,830,557,9800,4749,862,620,65,6323,998,66,572,634,235),
                                    labels = factor(c("Content", "Purchasing", "Content", "Products", "Artificial",
                                                      "Home", "Site Information", "Profile", "Products", "Artificial",
                                                      "Products", "Profile", "Purchasing", "Purchasing")),
                                    node_size_factor=0.06,
                                    edge_width_factor=10,
                                    edge_arrow_size=.8,
                                    edge_curved=.6,
                                    layout_size=1.5,
                                    legend_x=-2.0,
                                    legend_y=-0.5){

  transitions_df <- as.data.frame(t(mc@transitions$`1`))

  previous_state <- rownames(transitions_df)

  df <- cbind(previous_state, transitions_df)

  tidy_df <- tidyr::gather(df,
                           c(rownames(transitions_df)),
                           key = 'next_state',
                           value = 'transition_probability') %>%
    dplyr::filter(transition_probability > lower_bound) %>%
    dplyr::mutate(mapping_values = round(transition_probability, 2))

  # color_map <- tibble::tibble(
  #   greyscale_color = gray.colors(81, start=0, end=0, alpha=seq(0,0.80,0.01)),
  #   mapping_values = seq(0,0.80,0.01))
  #
  # edges <- inner_join(tidy_df, color_map, b="mapping_values")
  #
  # nodes <- data_frame(
  #   previous_state = previous_state,
  #   hit_counts = state_hits,
  #   state_types = labels)
  #
  # net <- graph_from_data_frame(d = tidy_df,
  #                              vertices = nodes)
  #
  # V(net)$size <- log(V(net)$hit_counts)*node_size_factor
  #
  # E(net)$width <- E(net)$transition_probability*edge_width_factor
  #
  # V(net)$color <- c("green", "orange", "green", "gold", "gray50",
  #                   "tomato", "white", "light blue", "gold", "gray50",
  #                   "gold", "light blue", "orange", "orange")
  #
  # colrs <- c("gray50", "green", "tomato", "gold", "light blue", "orange", "white")
  #
  # l <- layout_with_fr(net)
  #
  # l <- norm_coords(l, ymin = -1, ymax = 1, xmin = -1, xmax = 1)
  #
  # igraph::plot(net,
  #      edge.arrow.size = edge_arrow_size,
  #      edge.curved = edge_curved,
  #      edge.color = E(net)$greyscale_color,
  #      rescale = F,
  #      layout = l*layout_size)
  #
  # legend(x = legend_x,
  #        y = legend_y,
  #        levels(nodes$state_types),
  #        pch = 21,
  #        col = "#777777",
  #        pt.bg = colrs,
  #        pt.cex = 3.5,
  #        cex = 1.4,
  #        bty = "n",
  #        ncol = 1)
}
