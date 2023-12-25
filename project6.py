#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Project 6. optimization and consumer theory

In this project, you will be practicing on root finding and optimization problems
In addition, you will apply the computational method to solve the utility
maximization problem in economics.
"""
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import root
from scipy.optimize import minimize
import scipy.optimize as opt

#=============================================================================
# Section 1. Root finding and optimization
#=============================================================================
# 1.1. define the function y = ln(x) + (x-6)^3 - 4x + 30
# you can find the printed equation on Canvas
def f(x):
    return np.log(x) + (x - 6)**3 - 4*x + 30

# 1.2. plot the function on the domain [1, 12]
def plot_function(x, y):
    plt.plot(x, y)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.hlines(0, 1, 12, linestyle='--', color='r')
    plt.legend()
    plt.show()
    
x = np.linspace(1, 12, 1000)
plot_function(x,f(x))    

# 1.3. derive and define the first-order derivative of the function
def fp(x):
    return 1/x + 3*(x - 6)**2 - 4

# 1.4. plot it on the domain [1, 12]

x = np.linspace(1, 12, 1000)
plot_function(x,fp(x))

# 1.5. Define the Newton-Raphson algorithm (as a function)
def newton_raphson(f,fp, initial_guess, tolerance=1e-9 , max_iteration=100):
    x = initial_guess
    for i in range(max_iteration):
        x_new = x - f(x) / fp(x)
        if x_new < 0:
            x_new = 0.1
        if abs(x_new - x) < tolerance:
            return x_new
        x = x_new
    return x

# 1.6.Use the Newton-Raphson algorithm you defined to find the root of the function
# store the result in a list named as res_1
res_1 = newton_raphson(f,fp, 6)
print('root 1:', res_1)

# 1.7. use the Newton-Raphson method to find the
# maximum value on the domain [4, 8], name the returned variable as res_2
def fpp(x):
    return -1 / (x**2) + 6 * (x - 6)

res_2 = newton_raphson(fp, fpp, 6.0)
print('maximum 1:', res_2)

# 1.8. use the Newton-Raphson method to find the
# minimum value on the domain [4, 8], name the returned variable as res_3
res_3 = newton_raphson(fp, fpp, 10.0)
print('minimum 1:', res_3)


def plot_all_function(x, y1, y2, y3):
    plt.plot(x, y1, label = 'f(x)')
    plt.plot(x, y2, label ='f(x) derivative')   
    plt.plot(x, y3, label ='f(x) double derivative')  
    plt.xlabel('x')
    plt.ylabel('y')
    plt.hlines(0, 1, 12, linestyle='--', color='r')
    plt.legend()
    plt.show()

x = np.linspace(1, 12, 1000)
plot_all_function(x, f(x), fp(x), fpp(x))

# 1.9. use the scipy.optimize library to
# (a). find the root of f(x), store the result in variable res_4
res_4 = root(f, 4.0)
print('root 2:', res_4)

# (b). find miniumn value of f(x) on the domain [4, 8],
# name the returned var as res_5
res_5 = minimize(f,  6.0)
print('maximum 2:', res_5)

# (3). find maximum value of f(x) on the domain [4, 8],
# name the returned var as res_6
def neg_f(x):
    return -f(x)

res_6 = minimize(neg_f,  6.0)
print('minimum 2:', res_6)


#=============================================================================
# Section 2. Utiliyt Theory and the Application of Optimization
#=============================================================================

# Consider a utility function over bundles of A (apple) and B (banana)
#  U(B, A) =( B^alpha) * (A^(1-alpha))
# hint: you can find the printed equation on Canvas: project 7.

# 2.1. Define the given utility function
def utility(A, B, alpha):
    return (B**alpha) * (A**(1-alpha))

# 2.2. Set the parameter alpha = 1/3,
# Assume the consumer always consume 1.5 units of B.
# plot the relationship between A (x-axis) and total utility (y-axis)
# set the range of A between 1 and 10
alpha = 1/3
B = 1.5
A = np.linspace(1, 10, 100)
u_level = utility(A, B, alpha)


def plot_utility(A, u_level):
    figure = plt.figure(figsize=(12, 12))
    ax = figure.add_subplot(1, 1, 1)
    ax.plot(A, u_level)
    ax.set_xlabel("Consumption of A")
    ax.set_ylabel("Total Utility")
    plt.show()

plot_utility(A, u_level)

# 2.3.  plot the 3-dimensional utility function
# 3-d view of utility
A = np.linspace(1, 10, 1000)
B = np.linspace(1, 10 ,1000).reshape((1000,1))
A, B = np.meshgrid(A, B)

u_level = utility(A, B, 1/3)

def plot_utility_3d(A, B, u_level):
    fig = plt.figure(figsize=(12, 12))
    ax_3d = fig.add_subplot(1, 1, 1, projection='3d')
    ax_3d.contour3D(A, B, u_level, 20, cmap=plt.cm.Blues)
    ax_3d.set_xlabel("Consumption of A")
    ax_3d.set_ylabel("Consumption of B")
    ax_3d.set_zlabel("Total Utility")
    plt.show()

plot_utility_3d(A, B, u_level)

# 2.4.plot the utility curve on a "flatten view"
A = np.linspace(1, 10, 1000)
B = np.linspace(1, 10 ,1000).reshape((1000,1))
u_level = utility(A, B, 1/3)

def plot_utility_flat(A, B, u_level):
    fig = plt.figure(figsize=(12, 12))
    ax1 = fig.add_subplot(1, 1, 1)
    contours = ax1.contourf(A, B.flatten(), u_level, cmap=plt.cm.Blues)
    fig.colorbar(contours)
    ax1.set_xlabel("Consumption of A")
    ax1.set_ylabel("Consumption of B")
    ax1.set_title("Indifference map")
    plt.show()

plot_utility_flat(A, B, u_level)

# 2.5. from the given utitlity function, derive A as a function of B, alpha, and U
# plot the indifferences curves for u=1 ,3,5,7,9 on the same figure.
# Put B on the x-axis, and A on the y-axis
def A_indifference(B, ubar, alpha=1/3):
    ln_b = np.log(B)
    ln_ubar = np.log(ubar)
    
    A = np.exp((ln_ubar - alpha * ln_b) / (1 - alpha))
    return A
    
def plot_indifference_curves(ax, alpha=1/3):
    for u in [1, 3, 5, 7, 9]:
        B = np.linspace(0.5, 20, 1000)
        A = A_indifference(B, u, alpha)
        ax.plot(B, A)

fig, ax = plt.subplots()
plot_indifference_curves(ax)


# 2.6.suppose pa = 2, pb = 1, Income W = 20,
# Add the budget constraint to the  previous figure
def plot_budget_constraint(ax, W, pa, pb): 
    B = np.linspace(0, W/pb, 1000)
    A = (W - B * pb) / pa
    ax.plot(B, A, label="budget constraint")
    ax.fill_between(B, A, 0.3)
    ax.set_xlabel("Consumption of B")
    ax.set_ylabel("Consumption of A")

plot_budget_constraint(ax, 20, 2, 1)
fig =plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.legend()
plt.show()


# 2.7. find the optimized consumption bundle and maximized utility
def objective(B, W=20, pa=2, pb=1):
    def utility_fn(x):
        return -utility(x[0], x[1], 1/3)

    def budget_fn(x):
        return W - pa * x[0] - pb * x[1]

    x0 = np.array([W / pa, 0])
    res = opt.minimize(utility_fn, x0, constraints={"type": "eq", "fun": budget_fn})
    return res

opt = objective(2, 1, 20)
optimal_B = opt.x[1]
optimal_A = opt.x[0]
optimal_U = -opt.fun
res_8 = {
    "B": optimal_B,
    "A": optimal_A,
    "Total Utility": optimal_U
}

print(f"{res_8}")
