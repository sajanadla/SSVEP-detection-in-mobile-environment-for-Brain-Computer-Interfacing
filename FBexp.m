function [freq1,freq1_bndr,freq2,a3,ewt,mfb,boundaries]=FBexp(f,params)

%%%%
%inputs
%f: input signal
%params: parameters of EWT

%%%%%%
%freq1: frequency in Hz (computed from the relationships of the roots of FB and frequency)
%freq1_bndr: boudary frequencies
%freq2: digital angular frequecies
%a3: FB coeffiecients
%ewt: ewt coefficients
%mfb: generated filterbank
%boundaries: computed boundary frequencies
%plane: scalespace plane
%L: Life time of initial minima points
%th: Computed threshold in scale space plane 
 
N=length(f);
nb=(1:N);
f=f';
MM=N;
if exist('alfa') == 0
    x=2;
    alfa=zeros(1,MM);
    for i=1:MM
        ex=1;
        while abs(ex)>.00001
            ex=-besselj(0,x)/besselj(1,x);
            x=x-ex;
        end
        alfa(i)=x;
%         fprintf('Root # %g  = %8.5f ex = %9.6f \n',i,x,ex)
        x=x+pi;
    end
end
a=N;
for m1=1:MM
    a3(m1)=(2/(a^2*(besselj(1,alfa(m1))).^2))*sum(nb.*f.*besselj(0,alfa(m1)/a*nb));
end
 
 
freq1=(alfa*params.SamplingRate)/(2*pi*length(f));
 

freq2=(freq1/params.SamplingRate)*2*pi;


tic
[boundaries,presig] = EWT_Boundaries_Detect((abs(a3')),params);
toc
%%%%%%%%%%%%%%%boundary completion start%%%%%%%%%%%%%%%%%%%%%%
if(params.completion==1)
if (length(boundaries)<(params.N-1))
    boundaries=EWT_Boundaries_Completion(boundaries,params.N-1);
end

if (length(boundaries)>(params.N-1))
    boundaries=boundaries(1:params.N-1);
end
end
%%%%%%%%%%%%%%boundarycompletion end%%%%%%%%%%%%%%%%%%%%%%%%%%%


index=boundaries;
boundaries=freq2(boundaries);
freq1_bndr=freq1(index);

%boundaries = boundaries*pi/round(length(f));

 
% % %  
% % %  boundaries = 2*pi*(boundaries)/(2*pi*length(f))
 
%% 
 
%% Filtering
% We extend the signal by miroring to deal with the boundaries
l=round(length(f)/2);
f = f';
f=[f(l-1:-1:1);f;f(end:-1:end-l+1)];
ff=fft(f);
 
 
% We build the corresponding filter bank
mfb=EWT_Meyer_FilterBank(boundaries,length(ff));
 
% We filter the signal to extract each subband
ewt=cell(length(mfb),1);
for k=1:length(mfb)
    ewt{k}=real(ifft(conj(mfb{k}).*ff));
    ewt{k}=ewt{k}(l:end-l);
end