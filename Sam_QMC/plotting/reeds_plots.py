# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

phi = np.genfromtxt("../output_data/Reeds-phi_avg-16384-160.dat")
sol = np.genfromtxt("../output_data/Reeds-solution-16384-160.dat")

Nx = np.linspace(-8.0,8.0,num=160)

plt.figure(dpi=300, figsize=(8,4))
plt.plot(Nx,sol,'k',label="True")
#plt.plot(Nx, phi, 'k--',label="QMC")
plt.xlabel('x')
plt.ylabel(r'Scalar Flux ($\phi$)')
plt.title('Reeds Problem: Scalar Flux')
#plt.legend()