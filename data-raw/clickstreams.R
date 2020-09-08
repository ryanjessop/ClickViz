clickstreams <- clickstream::readClickstreams("data-raw/clickstreams.csv",
                                               sep = ",",
                                               header = FALSE)

usethis::use_data(clickstreams, overwrite = TRUE)
