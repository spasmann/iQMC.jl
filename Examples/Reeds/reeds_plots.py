# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append("Krylov_QMC/Examples/Reeds/")

data = np.genfromtxt("ErrTab(7-6, -5).dat")

Nvals = [2**10, 2**11, 2**12, 2**13, 2**14, 2**15]
plt.figure(dpi=200)
plt.title("Reeds Error")
plt.plot(Nvals, np.diag(data),label='Diagonal')
plt.legend()
plt.xscale('log')
plt.yscale('log')