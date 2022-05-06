function [] = S_grid(S_mag)
% S_grid(S_mag)
%    S_grid plots on the Nichols chart the 'S_mag' constant magnitude locus 
%    of the sensitivity function S.
%    S = 1/(1+L), (L is the open loop tf)
%    The value of 'S_mag' has to be expressed in dB. 
%    The locus is plotted using a red dotted line.
%
%
% Author: Massimo Canale, 2000
% Last Modified : 20/11/2004
%

mm=10^(S_mag/20);
px=linspace(-359.99,-0.01,500);
[p,m]=meshgrid(px,mm);
i=sqrt(-1);
z=m.*exp(i*p/180*pi);
g=(1-z)./z;
gain=20*log10(abs(g));
phase=rem(angle(g)/pi*180+360,360)-360;
hold on, plot(phase',gain',':r','LineWidth',2), zoom on;

% Plotting the label
pp = find(phase <= -200);
if (isempty(pp))
    pp = find(phase <= -150);
    if (isempty(pp))
        pp = find(phase <= -180);
    end
end
[v, pt] = max(gain(pp));
t = text(phase(pp(pt(1))), gain(pp(pt(1))), sprintf(' %g dB', S_mag));
set(t, 'FontSize', 11);
set(t, 'FontWeight', 'bold');
set(t, 'HorizontalAlignment', 'right');
set(t, 'VerticalAlignment', 'bottom');
set(t, 'Color', 'r');

phase=rem(angle(g)/pi*180+360,360)-0*360;
hold on, plot(phase',gain',':r','LineWidth',2), zoom on;

% Plotting the label
pp = find(phase <= 200);
if (isempty(pp))
    pp = find(phase <= 150);
    if (isempty(pp))
        pp = find(phase <= 180);
    end
end
[v, pt] = max(gain(pp));
t = text(phase(pp(pt(1))), gain(pp(pt(1))), sprintf(' %g dB', S_mag));
set(t, 'FontSize', 11);
set(t, 'FontWeight', 'bold');
set(t, 'HorizontalAlignment', 'right');
set(t, 'VerticalAlignment', 'bottom');
set(t, 'Color', 'r');
