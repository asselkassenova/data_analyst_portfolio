library(arules)
library(Matrix)
data('Groceries')

class(Groceries)
dim(Groceries)

library(tibble)
library(dplyr)
item_freq <- itemFrequency(Groceries)

# Get top 12 items
top_12_items <- head(sort(item_freq, decreasing = TRUE), 12)
top_12 <- as.data.frame(top_12_items)

top  <- rownames_to_column(top_12, var = "index")

#barplot of the top 12 items
barplot(top$top_12_items, names.arg = top$index, col = "blue", las = 2,  
        main = "Top 12 Most Common Grocery Items",
        ylab = "Item Frequency")

#3
grocery_rules <- apriori(Groceries, parameter = list(confidence = 0.5, minlen = 2))

butter_rules <- subset(grocery_rules, lhs %in% "butter")

inspect(butter_rules)
summary(butter_rules)

milk_rules <- subset(grocery_rules, rhs %in% "whole milk")
# Print the sugar rules and their support, confidence, and lift
inspect(milk_rules)


#4
library(arulesViz)

rules <- apriori(Groceries, parameter = list(support = 0.001, confidence = 0.8, minlen = 2))
subset_rules <- subset(rules, lhs %in% "sugar" | rhs %in% "whole milk")
three_rules <- sample(subset_rules, 3)

plot(three_rules, method = "scatterplot")


pastry_rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.2, target = "rules"), appearance = list(lhs = c("pastry"), default = "rhs"))

# Generate a scatter plot of three rules involving the grocery item
plot(pastry_rules, method = "scatter", jitter = 0.2, shading = "lift", main = "Scatter Plot of Three Rules Involving Coffee")

# Generate a scatter plot of the same three rules, but with method="graph" and engine="htmlwidget"
plot(pastry_rules, method = "graph", engine = "htmlwidget")


##"**Task 2: Hierarchical Clustering**"
tiktok <- read.csv('tiktok_top_1000.csv')
dim(tiktok)

#2
set.seed(14308752)  # set your BUID as the seed
sample_rows <- sample(nrow(tiktok), 25, replace = FALSE)
sampled_data <- tiktok[sample_rows, ]

#3
numeric_vars <- c("Subscribers.count", "Views.avg.", "Likes.avg.", "Comments.avg.", "Shares.avg.")
scaled_df <- sampled_data
scaled_df[numeric_vars] <- scale(sampled_data[numeric_vars])

#5
dist_matrix <- dist(scaled_df[, c("Subscribers.count", "Views.avg.", "Likes.avg.", "Comments.avg.", "Shares.avg.")])

hclust_model <- hclust(dist_matrix, method = "complete")

plot(hclust_model, hang = -1, cex = 0.6, main = "Dendrogram of 25 TikTok accounts")

cluster_assignments <- cutree(hclust_model, k = 5)

library(dplyr)
clustered_df <- scaled_df %>% mutate(cluster = cluster_assignments)

summary_stats <- clustered_df %>% 
  group_by(cluster) %>% 
  summarize(avg_subs = mean(Subscribers.count),
            avg_views = mean(Views.avg.),
            avg_likes = mean(Likes.avg.),
            avg_comments = mean(Comments.avg.),
            avg_shares = mean(Shares.avg.)) %>% 
  arrange(cluster)
head(clustered_df)

