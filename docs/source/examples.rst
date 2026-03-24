Example
=======

Running the ``main``
--------------------

To run the ``main_morse.f90`` code, first compile it::

   <fortran compiler> main_morse.f90 -o <main executable name>

then use::

   ./<main executable name>


Running the ``power_spectrum``
------------------------------

To run the ``power_spectrum1D.f90`` code, first compile it::

   <fortran compiler> power_spectrum1D.f90 -o <FT executable name>

then use::

   ./<FT executable name>


Check
-----

To check if the code run successfully, compare your outputs with the provided example files::

   example_energy_plot.dat
   example_phase_space.dat
   example_power_spectrum_p.dat
   example_power_spectrum_q.dat

.. plot::

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

.. plot::

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

.. plot::

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

.. plot::

   import numpy as np
   import matplotlib.pyplot as plt

   data = np.loadtxt("../../examples/power_spectrum_p.dat")

   x = data[:, 0]
   y = data[:, 1]

   plt.plot(x, y)
   plt.xlabel("Frequency")
   plt.ylabel("Intensity")
   plt.title("Example Cpp")
   plt.grid()
