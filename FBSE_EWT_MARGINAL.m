tic
%x=load('O002.txt');
%%
params.SamplingRate = 173.61; 
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
params.N = 20; % maximum number of bands
params.completion = 1; % choose if you want to force to have params.N modes                      % in case the algorithm found less ones (0 or 1)
params.log=1;
% Choose the results you want to display (Show=1, Not Show=0)
Bound=0;   % Display the detected boundaries on the spectrum 
 
N=4097;
%
Fs=173.61;
duration=23.5989;
dt=linspace(0,duration,N);
% Pre-allocate with maximum possible sizes (adjust if you have better estimates)
max_aa = 10;  % Adjust based on your data
shanon_O = zeros(100, max_aa);
reyni_O = zeros(100, max_aa);
Tsallis_O = zeros(100, max_aa);
Energy_O = zeros(100, max_aa);

%%
for i=1:100
    if(i<10)
       
       %S=load(strcat('S00',num2str(i),'.txt'));
      
      F=load(strcat('O00',num2str(i),'.txt'));
%      N=load(strcat('N00',num2str(i),'.txt'));
      
    elseif (i >9)&&(i <= 99)
   %   S=load(strcat('S0',num2str(i),'.txt'));
     F=load(strcat('O0',num2str(i),'.txt'));
%     N=load(strcat('N0',num2str(i),'.txt'));
        
    else   
     % S=load(strcat('S',num2str(i),'.txt'));
      F=load(strcat('O',num2str(i),'.txt'));
%      N=load(strcat('N',num2str(i),'.txt'));
        
    end

strcat('O',num2str(i),'.txt')
 
% [ewt,mfb,boundaries]=EWT1D(S,params);

[freq1,freq1_bndr,freq2,a3,ewt,mfb,boundaries]=FBexp(F,params);



if Bound==1 %Show the boundaries on the spectrum
subplot(3,1,1)
plot(dt,S)
Show_EWTFB_Boundaries(a3,freq1,freq1_bndr)
xlim([0 round(173.61/2)])
xxx=(linspace(0,1,round(length(mfb{1,1}))))*Fs;
subplot(3,1,3)
for ii=1:size(mfb)
plot(xxx,mfb{ii,1})
hold on
end
xlim([0 round(173.61/2)])
ylim([0 3])
title('FBEWT filter bank')
end



clear freq1 freq1_bndr freq2 a3
        
   imf=Modes_EWT1D(ewt,mfb);
   % Dynamic resizing for imf1
    imf1 = []; 
   for i1=1:length(imf)
     imf1(i1,:)=imf{i1,1};  
   end
              
[joint_inst_amp,joint_inst_freq] = INST_FREQ_local(imf1);

freq = 2*pi*linspace(0,0.5,floor(N/2)+1);
        nfreq = length(freq);
        freq=freq/(2*pi);
        df = freq(2)-freq(1);     

        
        joint_inst_ampCopy=joint_inst_amp;
        joint_inst_freqCopy=joint_inst_freq;
        clear joint_inst_amp joint_inst_freq
        
%          figure
  for aa=1:size(joint_inst_ampCopy,1)
  Tf = zeros(nfreq,N);
  joint_inst_amp(1,:)=joint_inst_ampCopy(aa,:); 
  joint_inst_freq(1,:)=joint_inst_freqCopy(aa,:); 
  dw=joint_inst_freq;
  for j=1:1
  for m=1:N        
                 if dw(j,m)<0          
                 else
                     l = round(dw(j,m)/df+1);
                     if l>0 && l<=nfreq  && isfinite(l) 
                         Tf(l,m)=joint_inst_amp(j,m);     
                     end
                 end               
 end
  end
  
  
  
  P=(sum(Tf,2).^2)/sum(sum(Tf,2).^2);
  
  P1=find(P==0);
  P2=P;
  P2(P1)=[];
  
  shanon_O(i,aa)=-sum(P2.*(log(P2)));
  
  reyni_O(i,aa)=-log(sum(P.^2));
  
  Tsallis_O(i,aa)=1-sum(P.^2);
  
  Energy_O(i,aa)=sum(sum(Tf,2).^2);
        
%       subplot(ceil(size(joint_inst_ampCopy,1)/2),2,aa)
%       plot(freq*173.6,sum(Tf,2))
     
     
        end
         clear ewt imf imf1 boundaries joint_inst_ampCopy joint_inst_freqCopy
end
     
toc
      
       