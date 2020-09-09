clickstreams <- clickstream::readClickstreams("data-raw/clickstreams.csv")

usethis::use_data(clickstreams, overwrite = TRUE)
