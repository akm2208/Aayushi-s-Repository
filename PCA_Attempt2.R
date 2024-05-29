#library(readr)
#library(ggplot2)

setwd("/Users/aayushimishra/Documents/Important Documents/PhD/First Year Summer 2024/Internship/Sovereign Physical Risk Original Data")

data <- read_csv("historic_climate_akm.csv")

pca_result <- prcomp(data[, 4:10], center = TRUE, scale. = TRUE)

scores_historical <- pca_result$x

historical_scores_with_ids <- cbind(data[, 1:3], scores_historical)

future_data <- read_csv("future_climate_akm.csv")

future_data_normalized <- scale(future_data[, 4:10], 
                                center = pca_result$center, 
                                scale = pca_result$scale)

future_scores <- predict(pca_result, newdata = future_data_normalized)

future_scores_with_ids <- cbind(future_data[, 1:3], future_scores)

summary_table <- list(
  Historical_Scores = historical_scores_with_ids,
  Future_Scores = future_scores_with_ids
)

summary_table

#write.csv(historical_scores_with_ids, "historical_scores_with_ids.csv", row.names = FALSE)
#write.csv(future_scores_with_ids, "future_scores_with_ids.csv", row.names = FALSE)