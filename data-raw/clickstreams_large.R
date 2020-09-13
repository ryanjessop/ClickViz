clickstreams_large <- clickstream::readClickstreams(file="data-raw/clickstreams_large.csv", sep = ",", header = TRUE)

usethis::use_data(clickstreams_large, overwrite = TRUE)
