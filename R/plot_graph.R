#' Plot Markov chain transition network
#'
#' Builds a network graph to represent the transition matrix.
#'
#' @param graph_edges Fitted Markov chain
#' @param graph_nodes Threshold for displaying transition probabilities.
#' @param node_size_factor Threshold for displaying transition probabilities.
#' @param edge_width_factor Threshold for displaying transition probabilities.
#' @param edge_arrow_size Threshold for displaying transition probabilities.
#' @param edge_curve_factor Threshold for displaying transition probabilities.
#' @param legend_x_position Threshold for displaying transition probabilities.
#' @param legend_y_position Threshold for displaying transition probabilities.
#' @return Network visualisation
#' @examples
#' cls <- readClickstreams(file)
#' mc <- fitMarkovChain(cls)
#' plot_graph(mc)
plot_graph <- function(graph_edges,
                       graph_nodes,
                       node_size_factor=1.2,
                       edge_width_factor=5,
                       edge_arrow_size=0.6,
                       edge_curve_factor=0.5,
                       legend_x_position=-3.0,
                       legend_y_position=-0.5){

  net <- igraph::graph_from_data_frame(d = graph_edges,
                                       vertices = graph_nodes)

  layout_format <- igraph::layout_with_fr(net)
  layout_format <- igraph::norm_coords(layout_format, ymin = -1, ymax = 1, xmin = -1, xmax = 1)

  plot(net,
       edge.color = igraph::E(net)$greyscale,
       edge.width = igraph::E(net)$transition_p*edge_width_factor,
       edge.arrow.size = edge_arrow_size,
       edge.curved = edge_curve_factor,
       vertex.color = igraph::V(net)$node_color,
       vertex.size = igraph::V(net)$node_size^node_size_factor,
       layout = layout_format)

  legend(x = legend_x_position,
         y = legend_y_position,
         unique(graph_nodes$node_label),
         pch = 21,
         col = "#777777",
         pt.bg = unique(graph_nodes$node_color),
         pt.cex = 3.5,
         cex = 1.4,
         bty = "n",
         ncol = 1)
}
