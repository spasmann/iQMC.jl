# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append("Krylov_QMC/Examples/MultiGroup/")

data = np.genfromtxt("ErrTab(4-4, -5).dat")

Nvals = [2**10, 2**11, 2**12, 2**13]
plt.figure(dpi=200)
plt.title("MultiGroup Error")
plt.plot(Nvals, np.diag(data))
plt.xscale('log')
plt.yscale('log')
