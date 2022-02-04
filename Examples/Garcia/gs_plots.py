# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append("Krylov_QMC/Examples/Garcia_Scripts/")

sinf = np.genfromtxt("Siewert:s=1.dat",encoding="ISO-8859-1")
s1 = np.genfromtxt("Siewert:s=Inf.dat",encoding="ISO-8859-1")
