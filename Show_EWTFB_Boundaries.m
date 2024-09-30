function Show_EWTFB_Boundaries(a3,freq1,freq1_bndr)

%===============================================================================
% function Show_EWT_Boundaries(magf,boundaries,R,SamplingRate,InitBounds,presig)
% 
% This function plot the boundaries by superposition on the graph 
% of the magnitude of the Fourier spectrum on the frequency interval 
% [0,pi]. If the sampling rate is provided, then the horizontal axis
% will correspond to the real frequencies. If provided, the plot will
% superimposed a set of initial boundaries (in black). The input presig 
% will be superimposed on the original plot (useful to visualize regularized 
% version of magf)
%
% Input:
%   - magf: magnitude of the Fourier spectrum
%   - boundaries: list of all boundaries
%   - R: ratio to plot only a portion of the spectrum (we plot the
%        interval [0,pi/R]. R must be >=1
%   - SamplingRate: sampling rate used during the signal acquisition (must
%                   be set to -1 if it is unknown)
%		- InitBounds: initial bounds when you use an adaptive detection method
%		- presig: preprocessed version of the spectrum on which the detection is made
%
% Optional inputs:
%   - InitBounds: optional initial boundaries
%   - presig: preprocessed signal
%
% Author: Jerome Gilles
% Institution: UCLA - Department of Mathematics
% Year: 2013
% Version: 2.0
%===============================================================================

% figure;
subplot(3,1,2)
plot(freq1,abs(a3))
set(findobj(gca,'type','line'),'linew',2);
grid on
hold on

NbBound=length(freq1_bndr);
 
for i=1:NbBound
     if freq1_bndr(i)>freq1(length(freq1))
         break
     end
     %line([boundaries(i)-2*pi/length(magf) boundaries(i)-2*pi/length(magf)],[0 max(magf)],'LineWidth',2,'LineStyle','--','Color',[1 0 0]);
     line([freq1_bndr(i) freq1_bndr(i)],[0 max(abs(a3))],'LineWidth',2,'LineStyle','--','Color',[1 0 0]);
set(findobj(gca,'type','line'),'linew',2);
end
 

