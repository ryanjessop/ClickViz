#' Plot the transition network
#'
#' Generate a network to represent the first order Markov chain transition matrix.
#'
#' @param network_edges Network edges data
#' @param network_vertices Network vertices data
#' @param edge_width_factor Transform the edge width values
#' @param edge_arrow_size Set the arrow size
#' @param edge_curve_factor Set the edge curve
#' @param vertex_size_factor Transform the vertex size values
#' @param legend_x_position x-axis value for the legend
#' @param legend_y_position y-axis value for the legend
#' @return Network visualisation of the transition matrix
#' @examples
#' cls <- readClickstreams(file)
#' edges <- prepare_network_edges(cls)
#' vertices <- prepare_network_vertices(cls, vertex_labels)
#' plot_transition_network(edges, vertices)
plot_transition_network <- function(network_edges,
                                    network_vertices,
                                    edge_width_factor=5,
                                    edge_arrow_size=0.6,
                                    edge_curve_factor=0.5,
                                    vertex_size_factor=1.2,
                                    legend_x_position=-3.0,
                                    legend_y_position=-0.5){

  net <- igraph::graph_from_data_frame(d = network_edges,
                                       vertices = network_vertices)

  layout_format <- igraph::layout_with_fr(net)
  layout_format <- igraph::norm_coords(layout_format, ymin = -1, ymax = 1, xmin = -1, xmax = 1)

  plot(net,
       edge.color = igraph::E(net)$greyscale,
       edge.width = igraph::E(net)$transition_p*edge_width_factor,
       edge.arrow.size = edge_arrow_size,
       edge.curved = edge_curve_factor,
       vertex.color = igraph::V(net)$vertex_color,
       vertex.size = igraph::V(net)$vertex_size^vertex_size_factor,
       layout = layout_format)

  legend(x = legend_x_position,
         y = legend_y_position,
         unique(network_vertices$vertex_label),
         pch = 21,
         col = "#777777",
         pt.bg = unique(network_vertices$vertex_color),
         pt.cex = 3.5,
         cex = 1.4,
         bty = "n",
         ncol = 1)
}
