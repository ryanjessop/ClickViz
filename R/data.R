#' Ryan's Sample Data
#'
#' Data made up of clickstream with various states.
#'
#' @docType data
#'
#' @usage data(clickstreams)
#'
#' @format An object of class \code{"cross"}; see \code{\link[qtl]{read.cross}}.
#'
#' @keywords datasets
#'
#' @examples
#' mc <- fitMarkovChain(clickstreams)
#' plot_transition_matrix(mc)
"clickstreams"
