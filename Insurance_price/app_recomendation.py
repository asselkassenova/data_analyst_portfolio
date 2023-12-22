#!/usr/bin/env python
# coding: utf-8
# %%
import pandas as pd              
import numpy as np                        
  

df = pd.read_csv('Medical_Insurance_dataset.csv')
data = df
data


# %%
data['charges'] = data['charges'].astype(int)


# %%


import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.svm import SVR
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score


# Convert categorical variables to dummy variables
data = pd.get_dummies(data, columns=["sex", "smoker", "region"], drop_first=True)

# Split the data into training and test sets
X = data.drop("charges", axis=1)
y = data["charges"]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=123)

# Linear Regression
model_lm = LinearRegression()
model_lm.fit(X_train, y_train)
pred_lm = model_lm.predict(X_test)

# Decision Tree
model_rpart = DecisionTreeRegressor()
model_rpart.fit(X_train, y_train)
pred_rpart = model_rpart.predict(X_test)

# Random Forest
model_rf = RandomForestRegressor()
model_rf.fit(X_train, y_train)
pred_rf = model_rf.predict(X_test)

# Support Vector Machine (SVM)
model_svm = SVR()
model_svm.fit(X_train, y_train)
pred_svm = model_svm.predict(X_test)

# Naive Bayes
model_nb = GaussianNB()
model_nb.fit(X_train, y_train)
pred_nb = model_nb.predict(X_test)

# Calculate model performance
lm_mae = mean_absolute_error(y_test, pred_lm)
lm_mse = mean_squared_error(y_test, pred_lm)
lm_r2 = r2_score(y_test, pred_lm)

rpart_mae = mean_absolute_error(y_test, pred_rpart)
rpart_mse = mean_squared_error(y_test, pred_rpart)
rpart_r2 = r2_score(y_test, pred_rpart)

rf_mae = mean_absolute_error(y_test, pred_rf)
rf_mse = mean_squared_error(y_test, pred_rf)
rf_r2 = r2_score(y_test, pred_rf)

svm_mae = mean_absolute_error(y_test, pred_svm)
svm_mse = mean_squared_error(y_test, pred_svm)
svm_r2 = r2_score(y_test, pred_svm)

nb_mae = mean_absolute_error(y_test, pred_nb)
nb_mse = mean_squared_error(y_test, pred_nb)
nb_r2 = r2_score(y_test, pred_nb)

# Create a data frame to compare the results
results = pd.DataFrame({
    "Model": ["Linear Regression", "Decision Tree", "Random Forest", "Support Vector Machine", "Naive Bayes"],
    "MAE": [lm_mae, rpart_mae, rf_mae, svm_mae, nb_mae],
    "RMSE": [lm_mse, rpart_mse, rf_mse, svm_mse, nb_mse],
    "R2": [lm_r2, rpart_r2, rf_r2, svm_r2, nb_r2]
})

# Print the results
print(results)


# %%
data_for = data.drop('charges', axis=1, inplace=True)


# %%
import streamlit as st

from streamlit_jupyter import StreamlitPatcher, tqdm
#StreamlitPatcher().jupyter() 
import pandas as pd
import pickle
from PIL import Image

st.header("DIGITAL NOMAD INSURANCE QUOTATION")
image = Image.open('yurt.jpg') 
st.image(image, use_column_width=True)

st.header("please pick your characteristics")

age = st.slider('age:', 18, 100)
sex = st.radio('sex:',
                  ['0',
                   '1'])
bmi = st.slider('bmi',10, 55)
children = st.slider('children:', 0, 5)
smoker = st.radio('smoker_yes:',
                   ['1',
                     '0'])
region = st.radio('region:',
                 [ '1'  , 
                   '2' ,
                   '3'])             
data = {
    "age": age,
    "bmi": bmi,
    "children": children,
    "sex_male": sex,  # Male client
    "smoker_yes": smoker,# Smoker
    "region_northwest": region,
    "region_southeast": region,
    "region_southwest": region}


features = pd.DataFrame(data, index=[0])

load_model = pickle.load(open('solubility_model.pkl', 'rb'))

prediction = load_model.predict(features)

st.subheader('Recomended Charges for given details:') 
st.write(prediction)


# %%
