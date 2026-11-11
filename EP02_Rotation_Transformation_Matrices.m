
%% EP02 - Rotation and Transformation Matrices in MATLAB
clear;
clc;
close all;

%% 1. Define Rotation Angles

phi   = 30;    % Roll angle (deg)
theta = 20;    % Pitch angle (deg)
psi   = 45;    % Yaw angle (deg)


%% 2. Rotation Matrix Around X-Axis

Rx = [1,          0,           0;
      0, cosd(phi), -sind(phi);
      0, sind(phi),  cosd(phi)];


%% 3. Rotation Matrix Around Y-Axis

Ry = [ cosd(theta), 0, sind(theta);
       0,           1, 0;
      -sind(theta), 0, cosd(theta)];


%% 4. Rotation Matrix Around Z-Axis

Rz = [cosd(psi), -sind(psi), 0;
      sind(psi),  cosd(psi), 0;
      0,          0,         1];


%% 5. Combined Rotation Matrix

% ZYX Rotation Sequence
R_BI = Rz * Ry * Rx;

disp('Rotation Matrix R_BI:');
disp(R_BI);


%% 6. Define a Vector in Body Frame

v_B = [1; 0.5; 0.2];


%% 7. Transform Vector from Body to Inertial Frame

v_I = R_BI * v_B;

disp('Vector in Body Frame:');
disp(v_B);

disp('Vector in Inertial Frame:');
disp(v_I);


%% 8. Transform Vector Back to Body Frame

v_B_recovered = R_BI' * v_I;

disp('Recovered Vector in Body Frame:');
disp(v_B_recovered);


%% 9. Check Rotation Matrix Properties

% Orthogonality
orthogonality_check = R_BI' * R_BI;

% Determinant
determinant_check = det(R_BI);

% Reconstruction Error
reconstruction_error = norm(v_B - v_B_recovered);

disp('Orthogonality Check (should be identity):');
disp(orthogonality_check);

disp('Determinant (should be 1):');
disp(determinant_check);

disp('Reconstruction Error (should be close to 0):');
disp(reconstruction_error);


%% 10. Homogeneous Transformation Matrix

% Position of Body Frame Origin in Inertial Frame
p_BI = [0.5; -0.2; 0.3];

% Construct Homogeneous Transformation Matrix
T_BI = [R_BI, p_BI;
        0, 0, 0, 1];

disp('Homogeneous Transformation Matrix T_BI:');
disp(T_BI);


%% 11. Transform a Point Using Homogeneous Coordinates

% Point Coordinates in Body Frame
point_B = [1; 0.5; 0.2; 1];

% Transform Point from Body to Inertial Frame
point_I = T_BI * point_B;

disp('Point in Body Frame:');
disp(point_B(1:3));

disp('Point in Inertial Frame:');
disp(point_I(1:3));


%% 12. Recover Original Point

point_B_recovered = T_BI \ point_I;

disp('Recovered Point in Body Frame:');
disp(point_B_recovered(1:3));

% Homogeneous Transformation Error
homogeneous_error = norm(point_B - point_B_recovered);

disp('Homogeneous Transformation Error:');
disp(homogeneous_error);


%% 13. Visualize Body and Inertial Frames

figure;

hold on;

% Inertial Frame Axes
quiver3(0,0,0,1,0,0,'r','LineWidth',2);
quiver3(0,0,0,0,1,0,'g','LineWidth',2);
quiver3(0,0,0,0,0,1,'b','LineWidth',2);

% Body Frame Axes
% Their Origin is Translated by p_BI

quiver3(p_BI(1),p_BI(2),p_BI(3), ...
    R_BI(1,1),R_BI(2,1),R_BI(3,1), ...
    'm','LineWidth',2);

quiver3(p_BI(1),p_BI(2),p_BI(3), ...
    R_BI(1,2),R_BI(2,2),R_BI(3,2), ...
    'c','LineWidth',2);

quiver3(p_BI(1),p_BI(2),p_BI(3), ...
    R_BI(1,3),R_BI(2,3),R_BI(3,3), ...
    'k','LineWidth',2);

% Transformed Vector
quiver3(0,0,0,v_I(1),v_I(2),v_I(3), ...
    'Color',[0.5 0.2 0.8],'LineWidth',2.5);

% Transformed Point
plot3(point_I(1),point_I(2),point_I(3), ...
    'ko','MarkerFaceColor','y','MarkerSize',8);

grid on;
axis equal;

xlabel('X');
ylabel('Y');
zlabel('Z');

title('Body and Inertial Coordinate Frames');

legend('X_I','Y_I','Z_I', ...
       'X_B','Y_B','Z_B', ...
       'Transformed Vector','Transformed Point');

view(3);
hold off;


%% 14. Final Results Summary

disp(' ');
disp('========== FINAL RESULTS ==========');

disp('Rotation Matrix Determinant:');
disp(determinant_check);

disp('Rotation Matrix Reconstruction Error:');
disp(reconstruction_error);

disp('Homogeneous Transformation Error:');
disp(homogeneous_error);

disp('===================================');
