Before usage unzip the two folders: TMD_DATA & TMD_FUNCTIONS

# Adriatic_Sea_meteotsunami_surrogate_model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%           METEOSTUNAMI SURROGATE MODEL USER INTERFACE                   %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Celia Bolzer & Clea Denamiel
% For information contact: Clea Denamiel at cdenamie@izor.hr
% last modifications: 22/08/2019
%
% The user friendly interface is used to run the meteotsunami surrogate
% model, display the results and save the output in surrogate_results.mat.
%
% output:
% 1x9 struct array with fields:
%    input_surrogate
%    station_name
%    zeta_max
%    tide_max
%
%    output(1).input_surrogate
%         amplitude:      [1x1 struct]
%         direction:      [1x1 struct]
%         speed:          [1x1 struct]
%         period:         [1x1 struct]
%         start_latitude: [1x1 struct]
%         width:          [1x1 struct]
%    output(1:9).station_name
%         Harbor of Vela Luka
%         Harbor of Rijeka Dubrova?ka
%         Harbor of Stari Grad
%         Harbor of Vrboska
%         Harbor of Viganj
%         Harbor of Mali Ston
%         Harbor of Ston
%         Harbor of Mali Lošinj
%         Harbor of Ist
%    output(1:9).zeta_max
%         value: [1x20000 double] / 20000 samples generated by surrogate model
%         units: 'm'
%         nan: 'values under 0.1m'
%         long_name: 'Maximum Meteotsunami Elevation including tide'
%    output(1:9).tide_max
%         value: [1x1 double] / maximum daily tidal elevation
%         units: 'm'
%         long_name: 'Maximum Tidal Elevation extracted with TMD from the Mediterranean OSU model'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
