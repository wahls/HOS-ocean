This a fork of the original HOS-ocean repository with some personal modifications. Please visit
[https://github.com/LHEEA/HOS-ocean](https://github.com/LHEEA/HOS-ocean) for the original code.

# Changes to the original repository

- When the parameter random_phases in the file input_HOS.dat is set to 2,3,4,..., different sets of repeatable quasi-random phases are generated. That is, the same value of the parameter results in the same quasi-random phases being used for the simulation (as long as the compiler etc. stay the same).
- Added a matlab function for reading HOS-ocean's 3d.dat files.
- Use march=native flag for compilation.
- Adapted linker flags.
