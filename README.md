# DPD_ILC
Implementation of "Iterative Learning Control for RF Power Amplifier Linearization"

This code is the implementation of a simplified ILC algorithm as the Digital Predistortion algorithm.

I assumed the PA is modeled by:
y = \alpha_0 + \alpha_1 x + \alpha_2 x |x|^2 + \alpha_3 x |x|^4 + \alpha_4 x |x|^6
The \alpha_i are estimated using the measured data from "weblab".

For the ILC, please take a look at Section III.D of "Iterative Learning Control for RF Power Amplifier Linearization"

Notes about weblab: 
1- "weblab" is used to access output data from a real power amplifier. Random data input is fed into the PA, and the output is read from "weblab". 
Then, least square estimation is done to find the \alpha_i. 
2- To generate random constellation we used "randconst" function. You should either write your own code to generate random constellaion or ask "RFWebLab@dpdcompetition.com" to access the code.
For more info about "weblab" please see http://www.dpdcompetition.com/
