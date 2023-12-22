
import streamlit as st

#from streamlit_jupyter import StreamlitPatcher, tqdm
#StreamlitPatcher().jupyter() 
import pandas as pd
import pickle
from PIL import Image

st.header("DIGITAL NOMAD INSURANCE QUOTATION")

image_url = 'Insurance_price/yurt.jpg'

# Display the image from the URL
st.image(image_url, use_column_width=True)

st.header("please pick your characteristics")

import pandas as pd
import pickle
import streamlit as st

def load_and_predict(model_path, age, bmi, children, sex, smoker, region):
    # Define the feature data
    data = {
        "age": age,
        "bmi": bmi,
        "children": children,
        "sex_male": sex,      # Male client
        "smoker_yes": smoker, # Smoker
        "region_northwest": region,
        "region_southeast": region,
        "region_southwest": region
    }

    # Create a DataFrame with the feature data
    features = pd.DataFrame(data, index=[0])

    try:
        # Load the model from the specified path
        load_model = pickle.load(open(model_path, 'rb'))
        # Make predictions using the loaded model
        prediction = load_model.predict(features)
        return prediction
    except Exception as e:
        return str(e)

st.title('Insurance Quotation Recommender')
st.subheader('Enter Client Details')

# Input fields for client details
age = st.slider('Age:', 18, 100)
sex = st.radio('Sex:', ['Male', 'Female'])
bmi = st.slider('BMI:', 10, 55)
children = st.slider('Number of Children:', 0, 5)
smoker = st.radio('Smoker:', ['Yes', 'No'])
region = st.radio('Region:', ['Northwest', 'Southeast', 'Southwest'])

if st.button('Predict'):
    model_path = 'Insurance_price/solubility_model.pkl'  # Path to the model file
    prediction = load_and_predict(model_path, age, bmi, children, sex, smoker, region)
    if isinstance(prediction, str):
        st.error(f'Error: {prediction}')
    else:
        st.subheader('Recommended Charges for Given Details:')
        st.write(prediction)


# %%
