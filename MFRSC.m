function data_MFRSC_coloured = MFRSC(data_XYZ,Reflectance,Tr_Reflectance,Return)
% Input
% data_XYZ: Matrix Nx3 with XYZ information, being N the number of points
% Reflectance: Matrix Nx1 with reflectance information
% Tr_Reflectance: Scalar, threshhold to limit the colour reflectace, it depens on the MLS
% Return: Matrix Nx1 with return number information 

% Output
% data_MFRSC_coloured: Matrix Nx6 with XYZ information, and RGB (float 0-1) calculated 

%% Transfor to point cloud data
nube = pointCloud(data_XYZ(:,1:3));

%% Feature exrtaction
% Return number
features.return = Return; % 

%Reflectance
features.intens = Reflectance;

%Depth
features.hor = (data_XYZ(:,1).^2 + data_XYZ(:,2).^2).^0.5;

% Height
features.ver = data_XYZ(:,3);

% Kdtree
Mdl = KDTreeSearcher(nube.Location);
[ind_knn,dist] = knnsearch(Mdl,nube.Location,'K',25);

% Point density
features.dens = dist(:,2)./dist(:,5); %Densidad

% Eigen values
element = 1 : nube.Count;
[~,~,e_values] = arrayfun(@(x) pca(nube.Location(ind_knn(x,:),1:3)), element,'UniformOutput', false);
features.e_values = cell2mat(e_values)';

% Linearity
features.linear = (features.e_values(:,1)-features.e_values(:,2))./features.e_values(:,1);

% Planarity
features.planar = (features.e_values(:,2)-features.e_values(:,3))./features.e_values(:,1);

% Scatter
features.sccater = features.e_values(:,3)./features.e_values(:,1);

% Surface normals
features.normals = pcnormals(nube,25);

% Tilt
features.tilt = abs(atan(sqrt(features.normals(:,1).^2+features.normals(:,2).^2)./features.normals(:,3)))*180/pi;

%% Normlaizar features
features_mat = zeros(nube.Count,9);

features_mat(:,1) = features.intens; %Reflectance
features_mat(features.intens>Tr_Reflectance,1) = Tr_Reflectance;
features_mat(:,1) = (features_mat(:,1))/range(features_mat(:,1));

features_mat(:,2) = features.return/4; %Return number

features_mat(:,3) = (features.hor-min(features.hor))/range(features.hor);  %Depth
features_mat(:,4) = (features.ver-min(features.ver))/range(features.ver);  %Height

features_mat(:,5) = features.dens; %Point density

features_mat(:,6) = features.linear; %Linear
features_mat(:,7) = features.planar; %Planar
features_mat(:,8) = features.sccater; %Scatter

features_mat(:,9) = features.tilt/90; % Inclinacion

%% Conversion to RGB
% Depth-Linear-Height
R = 0.2989 * features_mat(:,3) + 0.5870 * features_mat(:,6) + 0.1140 * features_mat(:,4);

% Return-Reflectance-Inclination 
G = 0.2989 * features_mat(:,2) + 0.5870 * features_mat(:,1) + 0.1140 * features_mat(:,9);

% Planar-Scatter-Density
B = 0.2989 * features_mat(:,7) + 0.5870 * features_mat(:,8) + 0.1140 * features_mat(:,5);

%% Output 
data_MFRSC_coloured = [data_XYZ R G B];

end
