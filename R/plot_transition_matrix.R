#' Plot transition heatmap
#'
#' Builds an interactive heatmap of the first order Markov chain transition matrix.
#'
#' @param data Clickstream data
#' @return Heatmap of the transition matrix
#' @examples
#' cls <- readClickstreams(file)
#' plot_transition_heatmap(cls)
plot_transition_heatmap <- function(data){

  mc <- clickstream::fitMarkovChain(data)
  matrix <- t(as.matrix(mc@transitions[[1]]))

  plotly::plot_ly(
    x = colnames(matrix),
    y = colnames(matrix),
    z = matrix,
    colors = colorRampPalette(c("white", "yellow", "red", "dark red"))(100),
    colorbar = list(title = 'Transition \n Probability',
                    titlefont = list(size = 20),
                    tickfont = list(size = 20)),
    type = "heatmap",
    zauto = FALSE,
    zmin = 0,
    zmax = max(matrix, na.rm = TRUE)) %>%
    plotly::layout(xaxis = list(title = "To",
                           titlefont = list(size = 30),
                           tickfont = list(size = 20)),
                   yaxis = list(title = "From",
                           titlefont = list(size = 30),
                           tickfont = list(size = 20)))
}
