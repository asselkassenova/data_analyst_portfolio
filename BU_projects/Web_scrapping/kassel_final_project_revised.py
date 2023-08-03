#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 25 05:03:43 2023

@author: asselkassenova
"""

import bs4
import requests
import re
import pandas as pd
from car import Car
import json

url = 'https://www.cargurus.com/Cars/inventorylisting/viewDetailsFilterViewInventoryListing.action?zip=02215&maxPrice=50000&distance=50&minPrice=10000'

res = requests.get(url)
soup = bs4.BeautifulSoup(res.text, 'html.parser')

dataset = soup.find_all("script")
dictionary = []

for data in dataset:
    if 'PREFLIGHT' in str(data):
        dictionary.append(data)
        break

data_str = str(dictionary)
dict_object = re.search('({.+})', data_str).group(0).replace("'", '"')

try:
    dict_object = json.loads(dict_object)
except json.JSONDecodeError as e:
    print(f"An error occurred while parsing JSON: {e}")
    dict_object = None
else:
    print("JSON loaded successfully")

if dict_object:
    listings = dict_object["listings"]

    cars = []
    for car_data in listings:
        car = Car(
            car_data['listingTitle'],
            car_data['price'],
            car_data['mileage'],
            car_data['carYear']
        )
        cars.append(car)

    data = [car.get_details() for car in cars]

    output_frame = pd.DataFrame(data)
    output_frame
    
wear_and_tear = [(car.get_details()['Mileage'],round(car.calculate_wear_and_tear(), 2)) for car in cars]

data = []
for car in cars:
    car_data = car.get_details()
    mileage = car_data['Mileage']
    wear_and_tear = [(mileage, round(car.calculate_wear_and_tear(), 2))]
    car_data["Wear and Tear"] = wear_and_tear
    data.append(car_data)
    
output_frame = pd.DataFrame(data)
output_frame
   
    # Save the data to a CSV file
output_frame.to_csv("cars.csv", index=False)
print("Data saved to cars.csv")
