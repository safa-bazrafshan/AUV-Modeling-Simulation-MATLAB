%% EP01 - From 1D Motion to 6-DOF AUV Modeling
clear;
clc;
close all;

%% 1. Simulation Time
dt = 0.01;
T = 20;
t = 0:dt:T;

%% 2. Simple 1D Motion
x0 = 0;
u = 0.5;

x_1D = x0 + u*t;

%% 3. 6-DOF State Definition
% Position:    x, y, z
% Orientation: phi, theta, psi

eta = zeros(6, length(t));

%% 4. Initial State
eta(:,1) = [0; 0; 0; 0; 0; 0];

%% 5. Constant Motion Inputs
vx = 0.5;
vy = 0.2;
vz = -0.1;

roll_rate  = deg2rad(2);
pitch_rate = deg2rad(1);
yaw_rate   = deg2rad(5);

%% 6. 6-DOF Motion Simulation
for k = 2:length(t)

    eta(1,k) = eta(1,k-1) + vx*dt;
    eta(2,k) = eta(2,k-1) + vy*dt;
    eta(3,k) = eta(3,k-1) + vz*dt;

    eta(4,k) = eta(4,k-1) + roll_rate*dt;
    eta(5,k) = eta(5,k-1) + pitch_rate*dt;
    eta(6,k) = eta(6,k-1) + yaw_rate*dt;

end

%% 7. Convert Orientation to Degrees
phi   = rad2deg(eta(4,:));
theta = rad2deg(eta(5,:));
psi   = rad2deg(eta(6,:));

%% 8. Plot 1D Motion
figure;

plot(t, x_1D, 'LineWidth', 1.5);

grid on;
xlabel('Time (s)');
ylabel('Position x (m)');
title('Simple 1D Motion');

%% 9. Plot 6-DOF Position
figure;

plot(t, eta(1,:), 'LineWidth', 1.5);
hold on;
plot(t, eta(2,:), 'LineWidth', 1.5);
plot(t, eta(3,:), 'LineWidth', 1.5);
hold off;

grid on;
xlabel('Time (s)');
ylabel('Position (m)');
title('AUV Position - 3 Translational DOF');
legend('x', 'y', 'z');

%% 10. Plot 6-DOF Orientation
figure;

plot(t, phi, 'LineWidth', 1.5);
hold on;
plot(t, theta, 'LineWidth', 1.5);
plot(t, psi, 'LineWidth', 1.5);
hold off;

grid on;
xlabel('Time (s)');
ylabel('Angle (deg)');
title('AUV Orientation - 3 Rotational DOF');
legend('\phi (Roll)', '\theta (Pitch)', '\psi (Yaw)');

%% 11. Display Final State
disp('Final 6-DOF State:');

disp('Position [x y z] (m):');
disp(eta(1:3,end)');

disp('Orientation [roll pitch yaw] (deg):');
disp([phi(end), theta(end), psi(end)]);