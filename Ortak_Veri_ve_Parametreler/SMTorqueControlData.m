%% Parameters for SM Torque Control & Predictive Maintenance Project
% Bu betik, 65 kW Çıkık Kutuplu Senkron Makine (Salient-Pole Synchronous Machine)
% sürücüsünün fiziksel makine, batarya ve kontrol parametrelerini çalışma uzayına (Base Workspace)
% yükler ve projenin tüm alt klasörlerini otomatik olarak MATLAB yoluna (Path) ekler.

%% Machine Parameters
Pmax    = 65000;       % Rated apparent power              [W]
we_base = 1036.73;     % Base electrical angular speed     [rad/s]
Ibase   = 230.749;     % Base stator instantaneous current [A]
Tbase   = 250.79;      % Base torque                       [N*m]
Ifbase  = 25;          % Base instantaneous field current  [A]
L_base  = 0.000785016; % Base inductance                   [H]
Vr      = 230;         % Rated voltage                     [V]
fr      = 165;         % Rated electrical frequency        [Hz]
p       = 4;           % Number of pole pairs
Lad     = 0.9;         % Stator d-axis mutual inductance   [p.u.]
Laq     = 0.55;        % Stator q-axis mutual inductance   [p.u.]
Ll      = 0.15;        % Stator leakage inductance         [p.u.]
L0      = 0.15;        % Stator zero-sequence inductance   [p.u.]
Ld      = Lad+Ll;      % Stator d-axis synchronous ind.    [p.u.]
Lq      = Laq+Ll;      % Stator q-axis synchronous ind.    [p.u.]
Rs      = 0.01;        % Stator resistance                 [p.u.]
Lfd     = 0.2571;      % Rotor field circuit inductance    [p.u.]
Rfd     = 0.06;        % Rotor field circuit resistance    [p.u.]

%% High-Voltage Battery Parameters
Cdc  = 0.001;          % DC-link capacitor                 [F]
Vnom = 350;            % Nominal voltage                   [V]
AH0  = 280;            % Initial charge                    [hr*A]

%% Control Parameters
Ts   = 5e-6;           % Fundamental sample time              [s]
fsw  = 10e3;           % SM drive switching frequency         [Hz]
Tsi  = 1e-4;           % Sample time for current control loop [s]

Kp_id  = 1.0634;       % Proportional gain id controller
Ki_id  = 1685;         % Integrator gain id controller
Kaw_id = 101;          % Anti-windup gain id controller
Kp_iq  = 1.0769;       % Proportional gain iq controller
Ki_iq  = 734.25;       % Integrator gain iq controller
Kaw_iq = 100;          % Anti-windup gain iq controller
Kp_if  = 15;           % Proportional gain if controller
Ki_if  = 1500;         % Integrator gain if controller
Kaw_if = 100;          % Anti-windup gain if controller

%% Proje Alt Klasörlerini Otomatik Olarak MATLAB Yoluna (Path) Ekle
ortak_klasor = fileparts(mfilename('fullpath'));
proje_koku   = fileparts(ortak_klasor);

alt_klasorler = {
    ortak_klasor, ...
    fullfile(proje_koku, 'Bolum1_YapayZeka_TorkKontrolu'), ...
    fullfile(proje_koku, 'Bolum1_YapayZeka_TorkKontrolu', 'Mat_Dosyalari'), ...
    fullfile(proje_koku, 'Bolum1_YapayZeka_TorkKontrolu', 'Gorseller'), ...
    fullfile(proje_koku, 'Bolum2_KestirimciBakim_ArizaTeshisi'), ...
    fullfile(proje_koku, 'Bolum2_KestirimciBakim_ArizaTeshisi', 'Mat_Dosyalari'), ...
    fullfile(proje_koku, 'Bolum2_KestirimciBakim_ArizaTeshisi', 'Gorseller')
};

for k_yol = 1:numel(alt_klasorler)
    if exist(alt_klasorler{k_yol}, 'dir')
        addpath(alt_klasorler{k_yol});
    end
end

%% Current References (3B Optimum Akım Haritaları)
load(fullfile(ortak_klasor, 'SM65kWCurrentReferences.mat'));
clear ortak_klasor proje_koku alt_klasorler k_yol;
