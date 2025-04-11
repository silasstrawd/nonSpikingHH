This code is meant to simulate neural models without fast Na channels (i.e. nonspiking). 
There are 4 main types of code in this repo:
- Input Classes: Contain all parameters necessary for simulation - saved as default values
- Output Class: A standard format for all simulation results upon which standard postprocessing functions can act
- Functions: Act on standard input/output classes to do things like convert voltage to outputs or calculate bursting frequency.
- Model Specific Code: (e.g. code to sweep over inhibitory inputs to all nodes in Ausborn model) - see Template.m
-   This type of code:
-     Initializes an input class of parameters
-     Makes changes to the default values as necessary
-     Calls the solveNonSpikingFunction
-     Operates on the output class to complete analysis as necessary
