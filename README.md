# Device::BeagleBone
Support library for BeagleBone projects in Perl.

## Installation

Eventually, I hope that this will be a part of CPAN...  Until that time (or if you prefer
to install the module manually), use one of the methods described below.

### Manual Installation

After cloning the repository, run the following commands:

```
perl Makefile.PL
make
make test
make install
```

See [ExtUtils::MakeMaker](http://perldoc.perl.org/ExtUtils/MakeMaker.html) for customizing the installation.  Parameters may be optionally passed to `Makefile.PL` to alter the behavior.  The most common parameter to set is `INSTALL_BASE` which sets the top of the installation target.

For example, to change the installation location to use your home directory instead of the system Perl lib, change the first line of the steps to:
```
perl Makefile.PL INSTALL_BASE=~/Device-BeagleBone
```


### Self-Installer

Alternatively, you may install the latest verion of the module directly from the source:
```
sh -c "$(curl -fsSL http://bit.ly/devbb_inst)"
```

To customize the installation, the self-installer will pass any extra arguments to [ExtUtils::MakeMaker](http://perldoc.perl.org/ExtUtils/MakeMaker.html).  The arguments must start with `--` to make sure they are handled appropriately.

For example, to change the installation location to use your home directory instead of the system Perl lib:
```
sh -c "$(curl -fsSL http://bit.ly/devbb_inst)" -- INSTALL_BASE=~/Device-BeagleBone
```

The self-installer will also honor some environment variables.
* `confirm=(yes|no)` will bypass the user prompt, making automation or scripting easier - defaults to 'no'
* `dryrun=(yes|no)` will print the steps in the installer without actually doing any work - defaults to 'no'
* `skiptest=(yes|no|` will skip the module tests before installing - defaults to 'no'

Note: the link here is shortened for convenience.  It is simply a redirect to the [`install`](https://raw.githubusercontent.com/Homebrew/install/master/install) script in this repository.  If you are concerned about the content, please visit (http://bit.ly/devbb_inst) to check before installing.
