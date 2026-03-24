#Sphinx Guide

## Setup and Installation

Create a new environment

```
python3 -m venv <environment path>
```

and source it

```
source <environment path>/bin/activate
```

Install `sphinx` and dependencies (`sphinx-rtd-theme` is the ReadTheDocs theme and `myst-parser` allows the use of Markdown files):

```

pip install sphinx sphinx-rtd-theme myst-parser ...

```
The full list of packages I have installed are in `requirements.txt`:

```
sphinx
sphinx-rtd-theme
sphinx-fortran
myst-parser
six
numpy
matplotlib
```

Sometimes, the update of `wheel` is required before `sphinx-fortran` is installed:

```
python -m pip install --upgrade pip setuptools wheel
python -m pip install sphinx-fortran
```

## Initialization

Use `sphinx` to initialize the `docs` folder:

```
sphinx-quickstart docs
```

and separate `source` and `build` folder using `y`. Insert the project name, author, release number and default language. 

`sphinx` has now create the folder `docs`:

```
ls docs
build  make.bat  Makefile  source
```

In `build/` you will find the `.html` files. In `source/` you will find the file used by `sphinx` to build the `.html` files.

## Configuration File

The first thing to do is adapting the `conf.py` file. Import the `os` and `sys` packages to feed the correct paths to `sphinx`:

```[Python]
import os
import sys
```

and include all the proper extensions (some of these are for a Fortran code and may not be required for other languages):

```[Python]
extensions = [
    "sphinxfortran.fortran_domain",
    "sphinxfortran.fortran_autodoc",
    "myst_parser",
    "sphinx.ext.mathjax",
    "matplotlib.sphinxext.plot_directive",
]

myst_enable_extensions = [
    "dollarmath",
    "amsmath",
]

fortran_src = [os.path.abspath("../../src/*.f90")]
```

Make sure that the path exported in `fortran_src` is the fortran files path *relative to* `conf.py`.

Finally, use the proper theme for ReadTheDocs:

```[Python]
html_theme = 'sphinx_rtd_theme'
```

and remove

```
html_static_path = ['_static']
```


## The `index.rst` file

The `index.rst` contain the main page of the website. Let's include some files in the `toc`:

```[Python]
Welcome to Classical Combination Bands's documentation!
=======================================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   README.md
   examples
   api/files
```

Don't forget to put those files in `docs/source/`!

The first file is your repository `README` in Markdown. The second file is an example file in `.rst` format, so that you can put there some `matplotlib` plots:

```[Python]
.. plot::

   import numpy as np
   import matplotlib.pyplot as plt

   data = np.loadtxt("../../examples/example_power_spectrum_p.dat")

   x = data[:, 0]
   y = data[:, 1]

   plt.plot(x, y)
   plt.xlabel("Frequency")
   plt.ylabel("Intensity")
   plt.title("Example Cpp")
   plt.grid()
```

The path is relative to the `conf.py` file.

Let's include a link to the `index` page:

```[Python]
Read the paper `here <https://doi.org/10.1063/5.0297591>`_
```

and a cool picture to the `index` page!

```[Python]
.. image:: ../../figures/TOC.png
   :width: 60%
   :align: center
```

## Optional: document the code

If the code is documented properly (see `sphinx` documentation), you can let `sphinx` create the documentation for you! The source files must be linked in `conf.py` (`fortran_src`).

I did this in the `files.rst` file:

```
Fortran API
===========

Morse Dynamics
--------------

.. f:autoprogram:: oscillator
.. f:autosubroutine:: potential
.. f:autosubroutine:: gradient 


Power Spectrum
--------------

.. f:autoprogram:: powerspectrum1D
```

## Test locally

Before deploying the website, test it locally:

```
sphinx-build -b html docs/source docs/build
```

To clean, use

```
sphinx-build -M clean docs/source docs/build/
```

## Build the `.readthedocs.yaml` file

Now it's time to create the file that will guide ReadTheDocs in the creation of the website, `.readthedocs.yaml`:

```
version: 2

build:
  os: ubuntu-24.04
  tools:
    python: "3.12"

sphinx:
  configuration: docs/source/conf.py
  fail_on_warning: true

python:
  install:
    - requirements: requirements.txt
    - method: pip
      path: .

formats:
  - pdf
  - epub
```

The `os:` variable is referring to the servers, and the `python:` variable should be chosen carefully. `format` allows the generation of a downloadable documentation.

## Create the page

1. Go to ReadTheDocs and login with your GitHub account
2. Add a new project
3. Link the repository: if no repo is found, install the app and refresh
4. Look at the building process
5. Honestly? Use ChatGPT for troubleshooting
