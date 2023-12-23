import streamlit as st
#from streamlit_jupyter import StreamlitPatcher, tqdm
#StreamlitPatcher().jupyter() 
import pandas as pd
import pickle
from PIL import Image

st.markdown("""
    <style>
    body {
        color: black;  /* Text color */
        background-color: white;  /* Background color */
    }
    .st-bw {
        color: #4BC9FF !important;  /* Primary color */
    }
    .st-cz {
        max-width: 200px !important;  /* Max width of the app */
        width: 100% !important;
        margin: 0 auto !important;
        height: 200px !important; /* Height of the app */
        overflow: hidden !important;
    }
    </style>
""", unsafe_allow_html=True)


st.header("DIGITAL NOMAD INSURANCE QUOTATION")

image_url = 'Insurance_price/yurt.jpg'

# Display the image from the URL
st.image(image_url, use_column_width=True)

import pandas as pd
import pickle
import streamlit as st

def load_and_predict(model_path, age, bmi, children, sex, smoker, region):
    # Define the feature data
    # Map 'Male' and 'Female' to 0 and 1
    sex_mapping = {'Male': 0, 'Female': 1}
    sex_numeric = sex_mapping.get(sex, -1)  # Default to -1 for unknown
    
    # Map 'Yes' and 'No' to 1 and 0
    smoker_mapping = {'Yes': 1, 'No': 0}
    smoker_numeric = smoker_mapping.get(smoker, -1)  # Default to -1 for unknown
    
    # Map 'Northwest,' 'Southeast,' and 'Southwest' to 1, 2, and 3
    region_mapping = {'Northwest': 1, 'Southeast': 2, 'Southwest': 3}
    region_numeric = region_mapping.get(region, -1)  # Default to -1 for unknown

    data = {
        "age": age,
        "bmi": bmi,
        "children": children,
        "sex_male": sex_numeric,  # Male client (numeric)
        "smoker_yes": smoker_numeric,  # Smoker (numeric)
        "region_northwest": region_numeric,  # Region (numeric)
        "region_southeast": region_numeric,  # Region (numeric)
        "region_southwest": region_numeric  # Region (numeric)
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
