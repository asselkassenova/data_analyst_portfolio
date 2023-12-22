
import streamlit as st

#from streamlit_jupyter import StreamlitPatcher, tqdm
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
