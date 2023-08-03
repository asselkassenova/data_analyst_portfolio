### “KASSEL_FINAL_PROJECT.PY” – CarGurus web scrapping & tax calculation 

How to run my code: 
1.	Run “car.py” with user-defined class.
2.	Run “kassel_final_project.py” 
3.	Check output data “cars.csv” on your download’s directory. 

### What program does: 
It scrapes data from CarGurus website, displays used car brand & mark, price, milage and the year. Overall web scrapping of Ecommerce websites is useful to compare prices. For commercial companies web scrapping benefits on price defining the price strategy to enter the new market. For regular Ecommerce customers to catch the best deal. The program also calculates the sales tax, which can be very useful for used car dealers. If its newly opening car dealer company who is limited on budget for special programs, they may use this program to see the amount to be paid for tax.

### In terms of requirements, following have been used:
•	List: cars is a list of Car instances.
•	Tuple: wear and tear is a list of tuples, with milage and wear and tear calculation.
•	Dictionary: dict_object and the dictionaries returned by the get_details() method.
2. One iteration type is used: for loops are used to iterate through the dataset, listings, and cars.
3. One conditional is used: if dict_object: checks if the JSON object is not empty before proceeding.
4. One try block with an else condition is used: The try block is used to handle JSON parsing, and the else block is executed when JSON is loaded successfully.
5. One user-defined function is used: calculate_sales_tax() in the Car class. This function accepts price and tax_rate as arguments and returns the calculated sales tax.
6. One input and/or output file is used: The output is saved to a CSV file called "cars.csv".
7. One user-defined class (Car) is used, which has the required structures:
•	Private and public class attributes: _tax_rate (private), title, price, mileage, and year (public)
•	Private and public class methods: _get_tax_rate() (private), calculate_sales_tax() and get_details() (public)
•	__init__() method: Takes 4 arguments (title, price, mileage, and year)
•	__repr__() method: Returns a formatted string representation of the Car instance
•	A magic class method: __eq__() method is used to compare two Car instances
The main program loads the Car class from a separate file (car.py), creates Car instances, and makes use of the class methods and attributes. JSON parsing is handled by the try-else block, and the output is saved to a CSV file.
