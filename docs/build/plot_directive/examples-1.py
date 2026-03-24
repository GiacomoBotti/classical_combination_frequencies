import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter

data = np.loadtxt("../../examples/energy_plot.dat")

x = data[:, 0]
y = data[:, 1]

plt.plot(x, y)
plt.ylim(0.03, 0.032)
plt.gca().yaxis.set_major_formatter(FormatStrFormatter('%.3f'))
plt.xlabel("Time")
plt.ylabel("Energy")
plt.title("Example energy")
plt.grid()