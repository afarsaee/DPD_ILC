clc
clear all
close all
%%
addpath('func');        % add path for the functions
load x_in_PA_Test.mat        % load input to the PA (random constellations)
x_in_random = x;        % store the data in "x_in_random"
n_read_y = length(x_in_random); % #samples
gain_average = 500;     % average gain for the PA
y_d_ref = x_in_random * gain_average;    % find desired output of the PA
y_no_DPD = Find_out_PA(x_in_random);     % find output of PA (No DPD)
%% Main Loop, Find Optimal Input to PA
ILC_iteration = 50;                     % #iterations for ILC
x_in_optimal = zeros(size(y_d_ref));    % optimal input for the PA
y_out_PA     = zeros(size(y_d_ref));    % linearized output of the PA
gamma_ILC = 2/5000;                     % learning rate
for i_read_y = 1:n_read_y
   y_d = y_d_ref(i_read_y);
   uk = y_d/gain_average;
   for i_ILC = 2:ILC_iteration
      yk = Find_out_PA(uk);
      ek = y_d - yk;
      uk = uk + gamma_ILC * ek;
   end
   x_in_optimal(i_read_y) = uk;
   y_out_PA(i_read_y)     = yk;
end
%% plot the spectrum of the desired output, with DPD, no DPD
figure;
% find the FFT of the outputs
fft_y_d = fftshift(fft(y_d_ref));       % desired output
fft_y_PA= fftshift(fft(y_out_PA));      % DPD output
fft_y_NDPD = fftshift(fft(y_no_DPD));   % No DPD output
plot(10*log10(abs(fft_y_d)));
hold on;
plot(10*log10(abs(fft_y_PA)));
legend('desired', 'DPD');
NMSE_DPD = sum(abs(y_d_ref - y_out_PA).^2)/sum(abs(y_d_ref).^2);
display(['DPD NMSE = ',num2str(10*log10(NMSE_DPD)), ' dB']);

figure; 
plot(10*log10(abs(fft_y_d)));
hold on;
plot(10*log10(abs(fft_y_NDPD)));
legend('desired', 'no DPD');
NMSE_noDPD = sum(abs(y_d_ref - y_no_DPD).^2)/sum(abs(y_d_ref).^2);
display(['No DPD, NMSE = ',num2str(10*log10(NMSE_noDPD)), ' dB']);