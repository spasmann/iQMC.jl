# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append("Krylov_QMC/Examples/Reeds/")

data = np.genfromtxt("ErrTab(6-6, -5).dat")

Nvals = [2**10, 2**11, 2**12, 2**13, 2**14, 2**15]
NxVals = 80*np.array([1, 2, 4, 8, 16, 32])

diagonal = np.diag(data)
Nx50 = data[0,:]
Nx100 = data[1,:]
Nx200 = data[2,:]
Nx400 = data[3,:]
Nx800 = data[4,:]
Nx1600 = data[5,:]
O = diagonal[0]*np.sqrt(Nvals[0])/np.sqrt(Nvals)
#O = diagonal[0]*(Nvals[0])/(Nvals)

plt.figure(dpi=200)
plt.title("Reeds Error")
plt.ylabel("Error")
plt.xlabel("N")
plt.plot(Nvals, diagonal, 'k--',label='Diagonal')
plt.plot(Nvals, Nx50, '*-',label='Nx = 50')
plt.plot(Nvals, Nx200, '^-',label='Nx = 200')
plt.plot(Nvals, Nx1600, 's-',label='Nx = 1600')
plt.plot(Nvals, O, label = r'$O(N^{-1/2})$')
plt.xscale('log')
plt.yscale('log')
plt.legend()
