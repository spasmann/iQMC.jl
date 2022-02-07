# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append("Krylov_QMC/Examples/Reeds/")

data = np.genfromtxt("ErrTab(5-5, -5).dat")

NxVals = 80*np.array([1, 2, 4, 8, 16])
Nvals = np.array([2**10, 2**11, 2**12, 2**13, 2**14])

diagonal = np.diag(data)
Nx80 = data[0,:]
Nx320 = data[2,:]
Nx1280 = data[4,:]
#O = np.ones(5)*7000/Nvals

plt.figure(dpi=200)
#plt.title("Reeds Error")
plt.ylabel("Error")
plt.xlabel("N")
plt.plot(Nvals, diagonal,'o-',label='Diagonal')
plt.plot(Nvals, Nx80, '*-',label='Nx = 80')
plt.plot(Nvals, Nx320, '^-',label='Nx = 320')
plt.plot(Nvals, Nx1280, 's-',label='Nx = 1280')
#plt.plot(Nvals, O, 'k--', label='O(1/N)')
plt.legend()
plt.xscale('log')
plt.yscale('log')