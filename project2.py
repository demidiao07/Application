"""
Weekly project 2. The Gale-Shapley algorithm
Due on: September 13, 11:59 PM
@author: Wenshu Diao
"""

# Section 1. Preparation
# 1-1. import all the necessary python modules
import json

# 1-2. import the datasets
with open('/Users/diaowenshu/Desktop/ECON 380/project2_data.json') as f:
    project2 = json.load(f)


# Section 2 Extract information from the dataset, 
# 2-1. create a dictionary 'guyprefer' contains mens' preferences
guyprefers = {men: preference for men, preference in project2["men_preference"].items()}
    
# 2-2. create a dictionary 'galprefer' contains women's preferences
galprefers = {women: preference for women, preference in project2["women_preference"].items()}
    
# 2-3. create a list contains guys who are currently not engaged, 
# sort alphabetically
free_guy = list(project2["men_preference"])
free_guy.sort()

# 2-4. generate an empty dictionary 'engage_book' to store result
engage_book = {}

# 2-5. make copies of guyprefers and gal refers
guypreference = guyprefers.copy()
galpreference = galprefers.copy()


# Section 3. Impletement the Gale-Shapley algorithm 
# Follow the algorithm flowchart, it should be very helpful

while len(free_guy) > 0:
    # pop the first guy in the free_guy list, let him take the move
    a_brave_guy = free_guy.pop(0)
    # get his preference list
    mylist = guypreference[a_brave_guy].copy()
    # let this guy take the move
    for my_girl in mylist:
        # Let's propose to my favorate lady!
        # YOU WILL NEED TO DO THE REST, GOOD LUCK AND HAVE FUN!.
        if my_girl not in engage_book: 
            engage_book[my_girl] = a_brave_guy
            break
        elif my_girl in engage_book and galpreference[my_girl].index(a_brave_guy) < galpreference[my_girl].index(engage_book[my_girl]):
            free_guy.append(engage_book[my_girl])
            engage_book[my_girl] = a_brave_guy
            break
        elif my_girl in engage_book and galpreference[my_girl].index(a_brave_guy) > galpreference[my_girl].index(engage_book[my_girl]):
            continue

pair = [[men, women] for men, women in engage_book.items()]


print(engage_book)
print(pair)
# Section 4 (optional). Stability check
# define stability: there are no two people of opposite sex who would both
# rather have each other than their current partners.

