#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 25 05:05:34 2023

@author: asselkassenova
"""

class Car:
    _tax_rate = 0.04  # private class attribute
    _wear_rate = 0.1  # private class attribute

    def __init__(self, title, price, mileage, year):
        self.title = title  # public instance attribute
        self.price = price  # public instance attribute
        self.mileage = mileage  # public instance attribute
        self.year = year  # public instance attribute

    def __repr__(self):
        return f"{self.title} ({self.year}) - ${self.price} with {self.mileage} miles"

    def __eq__(self, other):
        return self.title == other.title and self.year == other.year

    def _get_tax_rate(self):  # private instance method
        return Car._tax_rate

    def _get_wear_rate(self):  # private instance method
        return Car._wear_rate

    def calculate_sales_tax(self):  # public instance method
        return round(self.price * self._get_tax_rate(),1 )

    def calculate_wear_and_tear(self):  # public instance method
        return self.mileage * self._get_wear_rate()

    def get_details(self):  # public instance method
        return {
            'Title': self.title,
            'Price': self.price,
            'Mileage': self.mileage,
            'Year': self.year,
            'Sales Tax': self.calculate_sales_tax(),
            'Wear and Tear': self.calculate_wear_and_tear()
        }
