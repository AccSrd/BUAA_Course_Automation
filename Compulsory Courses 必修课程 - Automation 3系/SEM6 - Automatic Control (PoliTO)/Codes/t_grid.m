function [] = T_grid(W_mag)

% T_grid(T_mag)
%    T_grid plots on the Nichols chart the 'T_mag' constant magnitude locus 
%    of the complementary sensitivity function T:
%    T = L/(1+L), (L is the open loop tf)
%    The value of 'T_mag' has to be expressed in dB. 
%    The locus is plotted using a blue dotted line.
%
% Author: Massimo Canale, 2000
% Last Modified : 20/11/2004
%

% Plotting the locus of |T| = W_mag 
mm=10^(W_mag/20);
px=linspace(-359.99,-0.001,500);
[p,m]=meshgrid(px,mm);
i=sqrt(-1);
z=m.*exp(i*p/180*pi);
g=z./(1-z);
gain=20*log10(abs(g));
phase=rem(angle(g)/pi*180+360,360)-360;
plot(phase, gain, ':b','LineWidth',2);

% Plotting the label
pp = find(phase <= -300);
if (isempty(pp))
    pp = find(phase <= -220);
    if(isempty(pp))
        pp = find(phase <= -200);
        if (isempty(pp))
            pp = find(phase <= -180);
        end
    end
end
[v, pt] = min(gain(pp));
t = text(phase(pp(pt(1))), gain(pp(pt(1))), sprintf(' %g dB', W_mag));
set(t, 'FontSize', 11);
set(t, 'FontWeight', 'bold');
set(t, 'HorizontalAlignment', 'right');
set(t, 'VerticalAlignment', 'top');
set(t, 'Color', 'b');

phase=rem(angle(g)/pi*180+360,360);
plot(phase, gain, ':b','LineWidth',2);

% Plotting the label
pp = find(phase <= 300);
if (isempty(pp))
    pp = find(phase <= 220);
    if(isempty(pp))
        pp = find(phase <= 200);
        if (isempty(pp))
            pp = find(phase <= 180);
        end
    end
end
[v, pt] = min(gain(pp));
t = text(phase(pp(pt(1))), gain(pp(pt(1))), sprintf(' %g dB', W_mag));
set(t, 'FontSize', 11);
set(t, 'FontWeight', 'bold');
set(t, 'HorizontalAlignment', 'right');
set(t, 'VerticalAlignment', 'top');
set(t, 'Color', 'b');

