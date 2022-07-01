%%  Load data
% Considering a point cloud XYZ Intens Return
% Read data
data = load("pointcloud_XYZ_I_Rn.txt");

% Select geometry
data_XYZ = data(:,1:3);

% Select Reflectance
Reflectance = data(:,4);

% Select Return Number
Return = data(:,5);


%% MFRSC calculation
Tr_Reflectance = 1500; % Tr_Reflectance: Scalar, threshhold to limit the colour reflectace, it depens of the MLS

data_MFRSC_coloured = MFRSC(data_XYZ,Reflectance,Tr_Reflectance,Return);

%% Save to disk coloured point cloud
dlmwrite('pointcloud_RGB_MFRSC.txt',data_MFRSC_coloured,'delimiter',' ','precision',12);