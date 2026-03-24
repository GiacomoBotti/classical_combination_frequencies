import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt("../../examples/power_spectrum_q.dat")

x = data[:, 0]
y = data[:, 1]

plt.plot(x, y)
plt.xlabel("Frequency")
plt.ylabel("Intensity")
plt.title("Example Cqq")
plt.grid()