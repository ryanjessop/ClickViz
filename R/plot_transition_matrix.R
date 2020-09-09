#' Plot Markov chain transition matrix
#'
#' Builds a heatmap of the Markov chain transition matrix.
#'
#' @param mc Fitted Markov chain
#' @return Heatmap of the transition matrix
#' @examples
#' cls <- readClickstreams(file)
#' mc <- fitMarkovChain(cls)
#' plot_transition_matrix(mc)
plot_transition_matrix <- function(mc){

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
