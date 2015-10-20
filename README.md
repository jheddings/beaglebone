# Device::BeagleBone
Support library for BeagleBone projects in Perl.

## Installation

Eventually, I hope that this will be a part of CPAN...  Until that time (or if you prefer
to install the module manually), use one of the methods described below.

After cloning the repository, run the following commands (see [ExtUtils::MakeMaker](http://perldoc.perl.org/ExtUtils/MakeMaker.html) for customizing the installation):

```
perl Makefile.PL
make
make test
make install
```

Alternatively, you may install the latest verion of the module directly from the source:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jheddings/beaglebone/master/install)"
```
