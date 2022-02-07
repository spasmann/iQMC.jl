# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append("Krylov_QMC/Examples/MultiGroup/")

data = np.genfromtxt("ErrTab(4-4, -5).dat")

Nvals = [2**10, 2**11, 2**12, 2**13]
NxVals = 50*np.array([1, 2, 4, 8])

diagonal = np.diag(data)
Nx50 = data[0,:]
Nx100 = data[1,:]
Nx400 = data[3,:]

plt.figure(dpi=200)
plt.title("MultiGroup Error")
plt.ylabel("Error")
plt.xlabel("N")
plt.plot(Nvals, diagonal, label='Diagonal')
plt.plot(Nvals, Nx50, '*-',label='Nx = 50')
plt.plot(Nvals, Nx100, '^-',label='Nx = 100')
plt.plot(Nvals, Nx400, 's-',label='Nx = 400')
plt.xscale('log')
plt.yscale('log')
plt.legend()



