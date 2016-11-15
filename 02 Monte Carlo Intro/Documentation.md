# Documentation - Relocation Cost Monte Carlo Simulator
This is a brief documentation about the Monte Carlo Simulator file "Relocation Cost MC Sim.xlsx", which is here for download. It is based on my blog article here: [https://www.steffenruefer.com/2016/11/monte-carlo-simulation-introduction/](https://www.steffenruefer.com/2016/11/monte-carlo-simulation-introduction/ "Monte Carlo Simulation Introduction")

## Software
The file was created and tested with MS Excel 2016.

## Add-Ons
To run the simulation, the free Add-On **SIPmath Modeler Tools** must be installed. This file was run and tested with version 3.1.57. It can be downloaded from here: [http://probabilitymanagement.org/tools.html](http://probabilitymanagement.org/tools.html)

## Introduction
The simulator creates distributions of input values ("cost items"), subtracts the employer coverage (a deterministic value) and sums up what remains. It creates two charts: a histogram and a cumulative probabilities chart.

## Input Values and Distributions
For the inputs I chose different distributions that seemed appropriate. This is only an example to explain the concept - there might be better distributions based on better input data.

- Yearly Rent: **Normal Distribution** with Mean = 42,500 USD and Standard Deviation = 5,000 USD
- Damages: **Triangular Distribution** with Min = 0, Most Likely = 200 and Max = 500 USD
- Child 1 School: **Uniform Distribution** with Min = 12,000 and Max = 20,000 USD
- Child 2 School: **Uniform Distribution** with Min = 10,000 and Max = 16,000 USD
- Utilities: **Triangular Distribution** with Min = 4,000, Most Likely = 6,000 and Max = 12,000 USD

The **coverage** is a deterministic number that is subtracted from each respective input distribution. 

## Limitations
This is a very simple model that is just for demonstration purposes. Its main flaw is that it assumes that all input values are independent from each other. In real life this is rarely the case. 

For example, yearly rent and utilities are most likely strongly correlated. Higher rent means a larger property - which means higher electricity and water usage. This is not taken into account in this model, and there will be simulated scenarios where high rent and low utilities (and vice versa) appear. This will change the result of the simulation. In later models this will be taken into account.

## Notes
If you have a question, please leave a comment on the blog article website.