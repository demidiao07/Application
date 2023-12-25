"""
project 7. the Solow-Swan growth model
@author: wenshudiao
"""
# Section 1. Preparation. Import the necessary libraries
import matplotlib.pyplot as plt
import numpy as np
import copy

# Section 2. Define the Growth model as a class

# ==================
# attributes:
# -a: factor productivity
# -s
# -alpha
# -delta
# -n

# -k
# -K
# -y
# -Y
# -i
# -I
# -L
# -d
# -be
# -steady_state


# methods:
# check_model: print the attribute of the instance
# grwoth: take one argument "year", and drive the economic growth
# get parameters: get the model parameters
# get states: get the states variables
# plot_growth: visualize how the income per capita, investment per capita, and
# plot_income_growth
# find_steady_state: solve for the steady state in this model

# arguments:
# ----------------------------------------------------------------------------
# para_dict:

# ----------------------------------------------------------------------------#\
# state_dict
    
    

class Growth_model:
    """
    This class will create an instance of the Solow-Swan growth model
    
    arguments:
    ------------------
    para_dict: dict
        a dictionary of parameters
    state_dict: dict
        a dictionary of model state
        
    attributes
    --------------
    
    methods:
    -------------
    
    """
    
    def __init__(self,
                 para_dict = {
                            'n': np.array([0.002]),   # pop growth rate
                            's': np.array([0.15]),     # saving rate
                            'alpha': np.array([1/3]),  # share of capital
                            'delta': np.array([0.05]), # depreciation rate
                            'a': np.array([1])         # factor productivity          
                             },
                 state_dict = {
                             'k': np.array([0.1]),     # default capital/capita
                             'L': np.array([100]),     # default population
                              },
                 ):
        # read-in the given parameters and variables
        self.para_dict = para_dict
        self.state_dict = state_dict 
        
        # calculate lower case y
        self.state_dict['y'] = (self.para_dict['a']
                                * self.state_dict['k']**self.para_dict['alpha'])
        
        # calculate upper case K (i.e., aggregate capital)
        self.state_dict['K'] = self.state_dict['k'] * self.state_dict['L']
        # calculate upper case Y
        self.state_dict['Y'] = self.state_dict['y'] * self.state_dict['L']
        # calculate lower case i
        self.state_dict['i'] = self.state_dict['y'] * self.para_dict['s']
        # calculate upper case I
        self.state_dict['I'] = self.state_dict['i'] * self.state_dict['L']
        
        # calculate the break-even investment
        self.state_dict['d'] = (self.para_dict['delta'] + self.para_dict['n']) * self.state_dict['k']
        
        self.steady_state = {}
        
        self.init_param = copy.deepcopy(self.para_dict)
        self.init_state = copy.deepcopy(self.state_dict) 
        
    # print out parameters
    def get_param():
        pass

    def get_state():
        pass
    
    def get_steady_state(self):
        return 
    
    def growth(self, years):
        # reset to initial status
        self.para_dict = self.init_param.copy()
        self.state_dict = self.init_state.copy()
        self.state_dict = copy.deepcopy(self.init_state)
        
        # step 1. define the time line
        time_line = np.linspace(0, years, num=years+1, dtype=int)
        
        # step 2. examine growth
        for t in time_line: 
            
            # 2.1. load parameters
            n = self.para_dict.get('n')[0]
            s = self.para_dict.get('s')[0]
            alpha = self.para_dict.get('alpha')[0]
            delta = self.para_dict.get('delta')[0]
            a = self.para_dict.get('a')[0]
            
            # 2.2. load all current states
            y_t = self.state_dict.get('y')
            k_t = self.state_dict.get('k')
            Y_t = self.state_dict.get('Y')
            L_t = self.state_dict.get('L')
            K_t = self.state_dict.get('K')
            i_t = self.state_dict.get('i')
            I_t = self.state_dict.get('I')
            d_t = self.state_dict.get('d')
            
            # 2.3 calculate new states i.e., the dynamic
            dk = s*y_t[t] - (delta + n) * k_t[t]
            k_next = k_t[t] + dk
            L_next = L_t[t] * (1+n)
            d_next = k_t[t] * delta
            y_next = a * (k_next ** alpha)
            K_next = k_next * L_next
            Y_next = (K_next**alpha) * ((a*L_next)**(1-alpha))
            i_next = y_next*s
            I_next = i_next * L_next

            # 2.4. update the state_dict
            k_t = np.append(k_t, k_next)
            y_t = np.append(y_t, y_next)
            Y_t = np.append(Y_t, Y_next)
            K_t = np.append(K_t, K_next)
            L_t = np.append(L_t, L_next)
            i_t = np.append(i_t, i_next)
            I_t = np.append(I_t, I_next)
            d_t = np.append(d_t, d_next)

            # update the attributes
            self.state_dict['k'] = k_t
            self.state_dict['y'] = y_t
            self.state_dict['Y'] = Y_t
            self.state_dict['K'] = K_t
            self.state_dict['L'] = L_t
            self.state_dict['i'] = i_t
            self.state_dict['I'] = I_t
            self.state_dict['d'] = d_t
        
    def find_steady_state(self):
        # step 1. load paramters
        n = self.para_dict.get('n')[0]
        s = self.para_dict.get('s')[0]
        alpha = self.para_dict.get('alpha')[0]
        delta = self.para_dict.get('delta')[0]
        a = self.para_dict.get('a')[0]  

        # step 2. find the steady state
        k_t = np.linspace(0, 20, 100) # create the k_t domain

        tolerance = 1e-7  # set the tolerance

        num_iter = 0
        for k in k_t:
            y = a * k ** alpha
            i = s * y
            d = (delta + n) * k
            num_iter += 1
            if abs(i - d) < tolerance:
                self.steady_state['k_star'] = k
                self.steady_state['y_star'] = y
                self.steady_state['c_star'] = y - i
                self.steady_state['i_star'] = i
                break
        self.num_iter = num_iter
        return
    
    def plot_income_growth(self):
        # plot income growth over time
        fig = plt.figure(figsize=(10, 6))
        plot_ax = fig.add_subplot(1,1,1)
        time_line = np.linspace(0, len(self.state_dict['y']) - 1, num = len(self.state_dict['y']), dtype=int)
        plot_ax.plot(time_line, self.state_dict['y'])
        plot_ax.set_title(f'aggregate income when saving rate is {self.para_dict["s"]}')
        plot_ax.set_xlabel('time')
        plot_ax.set_ylabel('income per capital')
        plot_ax.legend()
        plt.grid(True)
        plt.show()
        return

    def plot_growth(self):
        # plot_growth(): visualize the relationship between 
        #    income per capita, investment per capita, and capital accumulate. 
        # (i.e., income per capita & investment per capita against capital ) 
        fig = plt.figure(figsize=(10, 6))
        plot_ax = fig.add_subplot(1,1,1)
        plot_ax.plot(self.state_dict['k'], self.state_dict['y'], label = 'income per capita')
        plot_ax.plot(self.state_dict['k'], self.state_dict['i'], label = 'investment per capita')
        plot_ax.plot(self.state_dict['k'], self.state_dict['d'], label = 'break-even')
        plot_ax.set_title(
            f'income, investment, and break-even investment per capital when saving rate is {self.para_dict["s"]}')
        plot_ax.set_xlabel('capital per capital')
        plot_ax.set_ylabel('output per capital')
        plot_ax.legend()
        plt.grid(True)
        plt.show()
        return

# Section 3. Specify model parameters and examine economic grwoth
# set parameters (exgoneousely given):
if __name__ == '__main__':
    parameters = {'n': np.array([0.002]),                 # population growth rate
                      's': np.array([0.15]),                  # saving rate
                      'alpha': np.array([1/3]),               # share of capital
                      'delta': np.array([0.05]),              # depreciation rate
                      'a': np.array([1])                      # technology 
                      }
        
    states = {              # factor productivity
                  'k': np.array([1]),
                  'L': np.array([100])}


    # instantiate a growth model
    model = Growth_model(para_dict = parameters, state_dict = states)
        
    # simulate the growth
    model.growth(100)
  
    # 3.2  visualize the growth by 
        
    #   (a). plotting income per worker (y), investment per worker (i), 
    #   and break-even investment against capital per worker (k).
    model.plot_growth()
    #    (b) plotting aggregate income (Y) against time.
    model.plot_income_growth()
        
    # 3.3  find the steady state of the model
    # 3-4. how many iterations it take to converge to the steady state?
    model.find_steady_state()
    print(model.get_steady_state())
    
# Section 4. Use the growth model class to perform "what-if" analysis.
# 4-1. Holding all other factors the same as 3-1, what would happen to the steady state consumption (c*) 
# if the saving rate is 33%?
    parameters['s'] = np.array([1/3])
    model = Growth_model(para_dict=parameters, state_dict=states)
    model.growth(100)
    model.plot_growth()
    model.plot_income_growth()
    model.find_steady_state()
    print(model.get_steady_state())
    print("""The steady state consumption (c*) is higher if the saving rate is 33% since the rate increases.
People are nmore willing to invest, which boosts the economics.""")
    
# 4-2. Holding all other factors the same as 3-1, what would happen to the steady state consumption (c*) 
# if the saving rate is 50%?    
    parameters['s'] = np.array([1/2])
    model = Growth_model(para_dict=parameters, state_dict=states)
    model.growth(100)
    model.plot_growth()
    model.plot_income_growth()
    model.find_steady_state()
    print(model.get_steady_state())
    print("""The steady state consumption (c*) is higher if the saving rate is 50% since the rate increases.
People are nmore willing to invest, which boosts the economics.""")
    