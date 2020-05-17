###############################################################################################
#								 	                      #
#                               BRATS INSTALLATION INSTRUCTIONS                               #
#								  	                      #
#  BRATS is dependent on 2 non standard libraries, both of which must first be obtained       #
#  before installation. These are PGPLOT and Funtools. We have generally found that using     #
#  standard repository tools (e.g. yum or apt-get) to install these libraries causes the      # 
#  least compatibility issues and provides the easiest installation.			      #
#                                                                                             #
#  Other requirements, which come packaged with most Linux builds, include: GCC, OpenMP, GSL, #
#  Readline and X11. 									      #
#											      #
#  To install BRATS, the paths to these dependencies must be updated below. The required      #
#  paths are as follows:								      #
#											      #
#  INSTALLFROM - Directory containing the install files					      #
#  INSTALLTO   - Directory which you wish BRATS to be installed to			      #
#  PGPLOT      - Directory where PGPLOT is installed					      #
#  LIBS        - Directory containing standard libraries				      #
#  X11LIBS     - Directory containing the X11 libraries					      #
#  GCC	       - Directory containing the GCC libraries					      #
#  INCLUDE     - Directory containing any additional libraries or files			      #
#											      #
#  It is also required that enviroment variables are set before running BRATS. We recommend   #
#  adding these variables to your shell configurations files (e.g. .cshrc .bashrc).	      #
#											      #
#  CSH Example:										      #
#  setenv LD_LIBRARY_PATH /usr/local/pgplot						      #
#  setenv PGPLOT_DIR /usr/local/pgplot/							      #
#											      #
#  BASH Example:									      #
#  export LD_LIBRARY_PATH='/usr/local/pgplot'						      #
#  export PGPLOT_DIR='/usr/local/pgplot/'						      #
#  											      #
#  Non-standard machine setups may require additional fine tuning of the commands directly.   #
#  											      #
#  BRATS then be installed using the 'make brats'.					      #
#											      #
#                                    ***** IMPORTANT *****				      #
#											      #
#  If you have any issues, please get in touch via the BRATS website or facebook group:       #
#  Website: http://www.askanastronomer.co.uk/brats					      #
#  Facebook: https://www.facebook.com/groups/903563349676136/				      #
#											      #
#  Dependency websites:									      #
#  PGPLOT: http://www.astro.caltech.edu/~tjp/pgplot/					      #
#  Funtools: https://www.cfa.harvard.edu/~john/funtools/				      #
#											      #
###############################################################################################


INSTALLFROM = /some/path/to/BRATS_v263_Linux
INSTALLTO = /some/path/to/install/brats
PGPLOT = /soft/pgplot
LIBS = /soft/lib
INCLUDE = /soft/include
X11LIBS = /usr/lib
GCC = /usr/lib/gcc/x86_64-redhat-linux/3.4.6/


brats: main.c
	mkdir -p $(INSTALLTO)
	mkdir -p $(INSTALLTO)/docs
	gcc -fopenmp -w -g -O2 -c main.c -c $(INSTALLFROM)/synchrotron_src/synchrotron.c $(INSTALLFROM)/synchrotron_src/bessel.c $(INSTALLFROM)/synchrotron_src/gsl_integ.c -I$(INCLUDE) -I$(PGPLOT) -I$(INSTALLFROM)/synchrotron_src
	gfortran -fopenmp main.o bessel.o gsl_integ.o -L$(X11LIBS) -L$(LIBS) -L$(PGPLOT) -L$(GCC) -lcpgplot -lpgplot -lfuntools -lm -lX11  -lpng -lgsl -lgslcblas -lg2c -lreadline -o $(INSTALLTO)/brats
	cp $(INSTALLFROM)/updates.txt $(INSTALLTO)/docs/
	cp $(INSTALLFROM)/bratscookbook.pdf $(INSTALLTO)/docs/

