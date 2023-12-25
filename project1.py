#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Project 1

Created on Thu Aug 31 12:00:18 2023

@author: diaowenshu
"""

# 0. import the time module.
import time 

# record the start time
start_time = time.time()

# 1. Generate a list with numbers from 1 to 20, name the list as list1.
list1 = list(range(1,21))

# 2. Print the first 5 elements of this list.
print(list1[:5])    

# 3. Replace the last entry of the list with 100, and print the list again.
list1[-1] = 100
print(list1)

# 4. Sort the list from largest to smallest element, and print the list agian.
list1.sort(reverse=True)
print(list1)

# 5. Generate a new list with entries from 14 to 40 with step size 2, name it as list2.
list2 = list(range(14,41,2))
print(list2)

# 6. Write a loop, dividing the first 10 entries of list2 by 5, keep the rest of the list unchanged, and store the result into list3.
list3 = []
for x in range(len(list2)):
    if x < 10:
        result = list2[x] / 5
        list3.append(result)
    else:
        list3.append(list2[x])

print(list3)

"""
list3 = []

for x in list2[:10]:
    y = x/5
    list3.append(y)
list3 = list3 + list2[10:]
"""

# 7. Given the dictionary hrbook, print the value associate with the key "emp2".
hrbook= { 
    'emp1': {'name': 'John', 'salary': 7500}, 
    'emp2': {'name': 'Emma', 'salary': 8100}, 
    'emp3': {'name': 'Brad', 'salary': 6500} 
    }

print(hrbook.get('emp2'))

# 8. Add a new record to the hrbook, the key is emp4, value is {'name': 'Misty', 'salary': 7700}
hrbook['emp4'] = {'name': 'Misty', 'salary': 7700}
print(hrbook)

# 9. Use loop and conditional branching to do the following:
    # for those whose salary is lower than 7000, replace the salary with 7000, 
    # for those whose salary is between 7000 and 8000, replace the salary with 8000,
    # for those whose salary is higher than 8000, replace the salary with 8200. 
for employee in hrbook:
    
    if hrbook[employee]['salary'] < 7000:
        hrbook[employee]['salary'] = 7000
    elif hrbook[employee]['salary'] <= 8000:
        hrbook[employee]['salary'] = 8000
    else:
        hrbook[employee]['salary'] = 8200
        
print(hrbook)

# 10. use the time module to "time" your work. print out how long it takes to run the whole script.

# record the end time
end_time = time.time()
t = end_time-start_time
print("spent %s seconds to run this script" %t)
        
        
