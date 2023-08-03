# Personal loan acceptance prediction model 

## Task
To identify factors that influence customers acceptance of personal loans and develop a predictive model to target potential loan customers.

## Description
Bank is a US bank that has a growing customer base. The majority of customers is liability customers with varying sizes of deposits. 
Not as many customers who are borrowers (asset customers). Bank wants to grow asset customers. Earn more through the interest on loans. 
First i cleaned the data fron NA values, dublicates. Next, i performed discriptive analytic to each column in order to understand whether or not the customer accetance depends on those factors given on the column. (Education level, Family Size, Income, Morgage, Credit Card e.t.c) 

![image](https://github.com/asselkassenova/data_analyst_portfolio/assets/130527153/4d5fdf3a-9f3b-422b-8490-0e6304d34826)

For example, there was 3 types of education levels given. As its shown on the plot, Less Education → More chance of not accepting the loan 
More Education → Higher chance of accepting the loan.

OR 

![image](https://github.com/asselkassenova/data_analyst_portfolio/assets/130527153/9f337f6b-a65b-49fb-ac29-725c00592419)

Higher income more likely to accept: Greater ability to repay loan and Higher Credit Score.

As a next step i checked correlation, and removed " Age" and Security Account. 

![image](https://github.com/asselkassenova/data_analyst_portfolio/assets/130527153/202473ca-b323-4b5a-8c37-f2ce9bae9ba3)

Then i decided to perform logistic regression. Since, Binary Classifier Model (Accepted or Not Accepted)
Binomial Distribution: assume response follows Bernoulli distribution, Simple to execute ,Performs well with categorical (binary) predictor variables and numeric (we have both) Split data → 60% training, 40% test. When tested random customer prediction, the model showed that the customer is more likely to accept the loan. 

Cross Validation: for Real-World Use 
Accuracy: 95.41% 
Kappa: 0.7068
The high accuracy and substantial agreement show:
The model is able to capture meaningful patterns in the data and make accurate predictions.

## Tools
### R , tidyverse, dplyr, ggplot2, rpart, arules, cluster, factoextra, GGally, forecast
