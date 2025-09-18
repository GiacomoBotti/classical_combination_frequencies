# Classical Combination Frequencies in a Morse potential

This code has been developed to investigate the presence of classical combination frequencies in a Morse potential, as part of the paper _Classical combination frequencies in classical spectra_. *Please refer to the paper for any additional informations, or contact me*

## The input file

The input file for `main_morse.f90` (`input`) allows the user to input the trajectory parameters:
```
!Initial conditions (quanta)
0.d0
!Time step
0.1
!Number of steps
100000
!Parameters: omega mass zpe_scaling
1.d0 1.d0 0.25d0
```
The initial conditions are provided as vibrational quanta of excitation, following the usual harmonic quantization:
$$
q_{0} = q_{\mathrm{eq}} \qquad \qquad \qquad p_{0} = \sqrt{2E_{\mathrm{tot}} (n)}
$$
where $E_{\mathrm{tot}}$ is the Morse oscillator total energy:
$$
E(n) = \omega \left( n +\frac{1}{2} \right) - \frac{\left[ \omega (n + \frac{1}{2} )\right]^{2}}{4D_{e}}
$$
See the paper for further informations. Adding quanta of excitation has no real impact on the classical spectra, but it's a good way to gauge the initial energy. 

The potential parameters are hard-coded into the `potential` and `gradient` subroutines.

## The main run
To run the `main_morse.f90` code, first compile it
```
<fortran compiler> main_morse.f90 -o <main executable name>
```
then use
```
./<main executable name>
```
The code prints on terminal the initial energy and momentum. The output is printed in two files:
- `energy_plot.dat` contains the time and the total energy at that time, for debugging purposes
- `phase_space.dat` contains the $q$ and $p$ time evolution, to be given in input to the Fourier transform code.

## The Fourier-transform input
The input file for `power_spectrum1D.f90` (`FT_input`) allows the user to define the parameters of the Fourier transform procedure:
```
!Number of steps to read, step size
50000 0.1
!Omega: Start Stop Step
0.0 5.0 0.01
```
The number of steps should be less of equal to that of the classical trajectory, while the step size must be equal to that of the classical trajectory. The `Omega` parameters define the 1D grid on which the Fourier transform is computed.

## The Fourier-transform run
To run the `power_spectrum1D.f90` code, first compile it:
```
<fortran compiler> power_spectrum1D.f90 -o <FT executable name>
```
then use
```
./<FT executable name>
```
The code automatically reads the `phase_space.dat` file written by `main_morse.f90`
The output is printed in two files:
- `power_spectrum_p.dat` contains the time-averaged quasiclassical trajectory $p$ spectrum
- `power_spectrum_q.dat` contains the time-averaged quasiclassical trajectory $q$ spectrum

The code to compute the common $C_{vv}$ or $C_{xx}$ Fourier-spectra is present in the code, but it is commented. If decommented properly, the two spectra are printed in 
- `real_FTCvv.dat` for the $C_{vv}$ spectrum
- `real_FTCxx.dat` for the $C_{xx}$ spectrum





*References to the methods can be recovered in the paper. Contact me for further informations*
