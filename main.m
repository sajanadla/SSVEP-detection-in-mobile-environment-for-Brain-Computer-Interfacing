duration=30;
Fs=100;
filename = 'normalspeed_sub8ses2_epochs_8channel'; 


% Channel you want to extract (replace 'PO7' with your desired channel label)
channel_label = 'O2';

% Load data from text file
data = readtable(filename);

% Get the column index for the desired channel
channel_index = find(strcmp(data.Properties.VariableNames, channel_label));

% Extractchannel data
f = data{:, channel_index};% input signal
f=f(200:round(Fs*duration));
N=length(f);
dt=linspace(0,duration,N);

figure
subplot(4,1,1)
plot(dt,f)
set(findobj(gca,'type','line'),'linew',2);
grid on

title('Bessel EEG')

params.SamplingRate = Fs; 

% Choose the wanted global trend removal (none,plaw,poly,morpho,tophat)
params.globtrend = 'none';
params.degree=6; % degree for the polynomial interpolation

% Choose the wanted regularization (none,gaussian,avaerage,closing)
params.reg = 'gaussian';
params.lengthFilter = 10;
params.sigmaFilter = 1.5;

% Choose the wanted detection method (locmax,locmaxmin,ftc,
% adaptive,adaptivereg,scalespace)
params.detect = 'scalespace';
params.typeDetect='otsu'; %for scalespace:otsu,halfnormal,empiricallaw,mean,kmeans
params.N = 10; % maximum number of bands
params.completion = 0; % choose if you want to force to have params.N modes
                       % in case the algorithm found less ones (0 or 1)
params.log=1;

% Choose the results you want to display (Show=1, Not Show=0)
Bound=1;   % Display the detected boundaries on the spectrum


          
subresf=1;
[freq1,freq1_bndr,freq2,a3,ewt,mfb,boundaries]=FBexp(f,params);


if Bound==1 %Show the boundaries on the spectrum
    div=1;
    
        %ShFBEWT(abs(a3),freq1,boundaries,div,params.SamplingRate);
        Show_EWTFB_Boundaries(a3,freq1,freq1_bndr)
        
   axis tight
    title('FBEWT boundaries')
    xxx=(linspace(0,1,round(length(mfb{1,1}))))*Fs;
subplot(4,1,3)
for i=1:size(mfb)
plot(xxx,mfb{i,1})
hold on
end
xlim([0 round(100/2)])
ylim([0 3])
title('FBEWT filter bank')
end
 
rec=Modes_EWT1D(ewt,mfb);
for i=1:length(rec)
imf(i,:)=rec{i,1};
end
disp(boundaries);
boundaries = boundaries'
 
% Parameters for EWT_TF_Plan
Fe = Fs;       % Sampling frequency (assuming Fs is defined earlier in your code)
sig = f;        % Original signal (optional, for overlay on the plot)
rf = 1;         % Frequency axis ratio (default: full range)
rt = 1;         % Time axis ratio (default: full range)
resf = 2;       % Frequency resolution ratio (adjust as needed for visualization)
color = 1;      % Plot in color (0 for grayscale)

% Generate and plot the time-frequency representation
tf = EWT_TF_Plan(ewt, boundaries, Fe, sig, rf, rt, resf, color); 