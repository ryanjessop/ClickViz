
# ClickViz

<!-- badges: start -->
<!-- badges: end -->

The goal of ClickViz is to create interesting visusalitions of Markov chains using clickstream data.

## Installation

You can install the released version of ClickViz from Github with:

``` r
install_github("ryanjessop/ClickViz")
```

## Example

An example of clickstream data 

``` r
library(ClickViz)
clickstreams
```

A heatmap visualisation of the first order Markov chain transition matrix

``` r
plot_transition_matrix(cls)
```

![](images/heatmap_ex1.png)

A network visualisation of the first order Markov chain transition matrix

```r
labels <- c("Type1", "Type2", "Type2", "Type3")
state <- c("H", "P", "D", "E")
vertex_labels_example <- tibble::tibble(state=state,
                                        vertex_label=labels)
    
edges <- prepare_network_edges(clickstreams)
nodes <- prepare_network_vertices(clickstreams,
                                  vertex_labels_example)
plot_transition_network(test_edges,
                        test_nodes,
                        edge_width_factor=5,
                        edge_arrow_size=0.6,
                        edge_curve_factor=0.5,
                        vertex_size_factor=1.2,
                        legend_x_position=-3.0,
                        legend_y_position=-0.5)
```

![](images/network_ex1.png)
