import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt("../../examples/phase_space.dat")

x = data[:, 0]
y = data[:, 1]

plt.plot(x, y)
plt.xlabel("Position")
plt.ylabel("Momentum")
plt.title("Example Phase Space")
plt.grid()