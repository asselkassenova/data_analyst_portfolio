import datetime
import os
current_directory = os.getcwd()

class Electron:
    def __init__(self, el_type, brand, model, ser_number):
        self.el_type = el_type
        self.brand = brand
        self.model = model
        self.__ser_number = ser_number
        self.__description = ""
        self.__treatment_plan = ""
        if(self.el_type == "phone"):
            self.__description = self.el_type + " will be repaired "  
            self.__treatment_plan = "In order to repair your " + self.el_type + ", you have to wait and pay 40$"  
    def __repr__(self):
        return f'Your Device is("{self.brand}","{self.model}")'

    def __fun(self):
        print(self.__ser_number)
    

    def discharge(self):
        time_of_discharge = datetime.datetime.now()
        file_name = (self.el_type
                     + "_" + str(time_of_discharge.year)
                     + "_" + str(time_of_discharge.day)
                     + "_" + str(time_of_discharge.hour)
                     + "_" + str(time_of_discharge.minute)
                     + "_" + str(time_of_discharge.second) + ".txt")
        try:
            write_to_directory = "/Discharge_Files"
            file_loc = os.path.join(current_directory+write_to_directory,file_name)
            file = open(os.path.join(current_directory+write_to_directory,file_name), "a+")
        
            with open(file_loc, "r+") as f:
                f.seek(0)
                f.write(self.__description + "\n" + 
                        self.__treatment_plan)
                f.truncate()
                print("You can find discharge notes in:" + (file_loc))
        except EnvironmentError:
            print("An error has occured")
        pass


phone_d = Electron(el_type='phone', brand='apple', model='iphone', ser_number='123456')

print("------11111111111111111----------")
print(phone_d)
print("------11111111111111111----------")

print("----------------------------------")

print("------22222222222222222----------")
print(repr(phone_d))
print("------22222222222222222----------")

print("----3333333333333333333----------")
print(phone_d.discharge())
print("----3333333333333333333----------")







