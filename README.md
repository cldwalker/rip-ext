Description
===========

A rip plugin which rebuilds packages that have C extensions. Can be used manually or automatically
with rvm's hooks. When used automatically with rvm, gem environments are easily synchronized across
ruby versions!

Install
=======

    rip install git://github.com/cldwalker/rip-ext.git


Examples
========

Manually use it with any version switching tool:

    $ rip install hpricot
    installed hpricot (0.8.2)

    # switch ruby version, could use any tool here
    $ rvm use 1.9.1

    # List all packages (across ripenvs) that need to be rebuilt for this ruby version
    $ rip ext -l
    /Users/bozo/.rip/.packages/hpricot-608cb7a0d59bd080f3a1265fef1bfcfd
    # Rebuilds listed packages and symlinks the newly built ones
    $ rip ext
    Building extensions for hpricot ...

Automatically with rvm's hooks:

    # Add a hook to be invoked each time we switch ruby versions
    $ echo "rip ext -i" >> ~/.rvm/hooks/after_use

    $ rip install hpricot
    installed hpricot (0.8.2)

    $ rvm use 1.9.1
    info: running hook after_use
    1 package(s) have extensions to build for this ruby version.
    Proceed? [y]/n
    # Entering return or y builds extensions as above
    # Entering n, only packages with previously built extensions are symlinked
    # Can always build extensions later with `rip ext`
    # Only prompted to build if there are new extensions
