#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
In this project, you will use functions to simulate the epidemic of a virus
within a region. 
@author: wenshudiao
"""

import numpy as np  
import matplotlib.pyplot as plt

#=============================================================================
#Section 1. set the model parameters
#=============================================================================
#1.1 set the random seed to 380 (pseudo randomness)
np.random.seed(380) # DO NOT CHANGE THE SEED

#1.2 create a population vector with five areas, population in areas are:
# areaA: 18000. areaB: 22000, areaC:50100,areaD,21010, areaE:25000
n_j = np.array([18000,22000,50100,21010,25000])

#1.3 use the random integer generation function in numpy to create a 5 x 5
# Origination-Destination flow matrix
# Set the lower limit to 1000, upper limit to 3,000 
od_matrix = np.random.randint(1000, 3001, (5, 5))


#1.4 same modal share across all regione (1)
alpha_vec = np.full(len(n_j),1) 
#1.5 same transmission rate across all regions
beta_vec = np.full(len(n_j),0.8) 
#1.6 same recover rate  across all regions
gamma_vec = np.full(len(n_j),0.05) 
#1.7 normal o-d flow
od_flow = od_matrix.copy()
#1.8 Have 300 iterations
days = 300



#=============================================================================
#Section 2. define the initial status table
#=============================================================================
# assume in the beginning, no recover or died yet, 
# infected proportion in areas are:
# areaA: 1%; areaB: 0.5%; areaC:0.1%; arerD:0%, areaE:0%

def start_detect(n_j,infect,immune):
    # create a new matrix called sir
    sir = np.zeros((5,3))
    # record the original condition in sir matrix
    sir[:,0] = n_j
    # store the change on infect and immute population separately
    infect_new = np.round(sir[:,0] * infect)
    immune_new = np.round(sir[:,0] * immune)
    # now everything is done, the simulation starts. move infection to group I
    sir[:,0] = sir[:,0] + infect_new - immune_new
    sir[:,1] += infect_new
    sir[:,2] += immune_new
    
    return sir

sir = start_detect(n_j, np.array([0.01, 0.005, 0.001, 0, 0]), 0)


#=============================================================================
#Section 3. Define a function to simulate the epidemic in this big region
#=============================================================================
# function input should include:
# n_j:              population vector
# initial status:   the initial status of the epidemic
# od_flow:          the 5 x 5 o-d matrix
# alpha_vec:        population density in each region
# beta_vec:         transmission rate in each region
# gamma_vec:        daily recover rate in each region
# days: total       iterations

# function return:
# susceptible_pop_norm: changes in the proportion of S group (aggregated)
# infected_pop_norm: changes in the proportion of  I group (aggregated)
# recovered_pop_norm: changes in the proportion of R group (aggregated)

def epidemic_sim(n_j, initial_status,od_flow, 
                 alpha_vec,beta_vec,gamma_vec,days):
    """
    Parameters
    ----------
    n_j : 5 x1 array
        total population in each area.
    initial_status : 5 x 3 array
        initial status
    alpha : 5 x 1 array
        modal share in each area
    beta : 5 x 1 array
        transmission rate in each area
    fatality: 5 x 1 array 
        daily fatality rate in each area
    gamma : 5 x 1 array
        recover rage in each area
    days: int
        total iterations

    Returns
    -------
    infected_pop_norm : List
        DESCRIPTION.
    susceptible_pop_norm : List
        DESCRIPTION.
    recovered_pop_norm : List
        DESCRIPTION.

    """
     
    #3.1 make copy of the initial sir table
    sir_sim = sir.copy()

    #3.2 create empty list to keep tracking the changes
    susceptible_pop_norm = []
    infected_pop_norm = []
    recovered_pop_norm = []
    dead_pop_norm = []
    
    #3.3. use total_days as the interator
    total_days = np.linspace(1,days,days)
    for day in total_days:
        
        ##3.4 figure out where those infected people go
        
        # normalize the sir table by calculating the percentage of each group
        sir_percent = sir_sim/n_j[:, np.newaxis]
        # assuming the infected people travel to all ares with the same probability:  
        infected_mat = np.array([sir_percent[:, 1],] * len(n_j)).transpose()
        # od_infected gives the flow of infected people. i.e., where they go         
        od_infected = np.round(od_flow * infected_mat)

        # "inflow infected" are those who will spread the disease to susceptible    
        inflow_infected =  od_infected.sum(axis = 0)# total infected inflow in each area
        inflow_infected =  np.round(inflow_infected * alpha_vec)# consider population density

        #3.5 calculate new_infect    
        new_infect = np.round((beta_vec * sir_sim[:,0] * inflow_infected) / 
                              (n_j + od_flow.sum(axis = 0) - od_flow.sum(axis = 1)))
 
        #3.6 set upper limit of the infected group (total susceptible)          
        new_infect = np.where(new_infect > sir_sim[:, 0], sir_sim[:, 0], new_infect)
    
        #3.7 calculate total number of people recovered        
        new_recovered = np.round(gamma_vec * sir_sim[:, 1])

    
        #3.8 remove new infections from susceptible group      
        sir_sim[:,0] -= new_infect

        #3.9 add new infections into infected group, 
        # also remove recovers from the infected group
        sir_sim[:,1] = sir_sim[:,1] + new_infect - new_recovered


        #3.10 add recovers to the recover group       
        sir_sim[:,2] += new_recovered


        #3.11 set lower limits of the groups (0 people)        
        sir_sim = np.maximum(sir_sim, 0)

                 
        #3.12 compute the normalized SIR matrix on aggregate level
        region_sum = np.sum(sir_sim, axis=0)
        region_sum_normalized = region_sum / np.sum(region_sum)
        s = region_sum_normalized[0]
        i = region_sum_normalized[1]
        r = region_sum_normalized[2]

        susceptible_pop_norm.append(s)
        infected_pop_norm.append(i)
        recovered_pop_norm.append(r)
        
    return [ susceptible_pop_norm, infected_pop_norm,recovered_pop_norm]





#3.13 call the function to simulate the epidemic
outcome = epidemic_sim(n_j, sir,od_flow, alpha_vec,beta_vec,gamma_vec,days)

#=============================================================================
#Section 4. define a function to visualize the simulation result
#=============================================================================
def sir_simulation_plot(outcome,days):
    fig = plt.figure(figsize=(10,8))
    ax = fig.add_subplot(1, 1, 1)
    ax.plot(np.linspace(1, days, days), outcome[0], label='Susceptible')
    ax.plot(np.linspace(1, days, days), outcome[1], label='Infected')
    ax.plot(np.linspace(1, days, days), outcome[2], label='Recovered')
    plt.legend()
    plt.title('Epidemic Simulation')
    plt.show()


sir_simulation_plot(outcome, days=days)
#=============================================================================
#Section 5. Policy evaluation
#=============================================================================
# Using the simulation model to evaluate the following policy targets
# Visualize the results, organize the plots in a 2x2 figure, each outcome on 
# one subplot.
policies = []
#Policy 1. do nothing (this should have been done in )
policies.append(epidemic_sim(n_j,sir,od_flow, alpha_vec,beta_vec, gamma_vec,days))

#Policy 2. reduce the o-d flow by 50%, all other arguments stay unchanged
policies.append(epidemic_sim(n_j,sir,od_matrix * 0.5, alpha_vec,beta_vec, gamma_vec,days))

#Policy 3. reduce the o-d flow by 80%, all other arguments stay unchanged
policies.append(epidemic_sim(n_j,sir,od_matrix * 0.8, alpha_vec,beta_vec, gamma_vec,days))

#Policy 4. reduce the o-d flow by 80%, reduce beta by 50%, all other the same
policies.append(epidemic_sim(n_j,sir,od_matrix * 0.8, alpha_vec,beta_vec * 0.5, gamma_vec,days))



plt.style.use('seaborn-whitegrid')

def sir_simulation_plot_all(outcome, days):

    plt.plot(np.linspace(1, days,days), outcome[0], label = 'Susceptible')
    plt.plot(np.linspace(1, days,days), outcome[1], label = 'Infected')
    plt.plot(np.linspace(1, days,days), outcome[2], label = 'Recovered')

    plt.legend()
    
fig = plt.figure(figsize = (20, 16))
for i in range(len(policies)):
    ax = fig.add_subplot(2, 2, (i+1))
    ax.set_title('Policy %s ' %(i+1))
    ax = sir_simulation_plot_all(policies[i],300)
plt.show()
