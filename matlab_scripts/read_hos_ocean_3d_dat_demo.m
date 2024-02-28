% This script demonstrates the use of READ_HOS_OCEAN_3D_DAT.
% It is provided under the same terms as HOS-ocean (GPLv3).

% run HOS-ocean in the ../bin folder first to generate the data file
dat = read_hos_ocean_3d_dat('../bin/Results/3d.dat');

figure
plot_eta(dat, 1)

figure
plot_eta(dat, 100)
