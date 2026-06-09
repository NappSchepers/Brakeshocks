function [fn, pvsrs_maximax, pvsrs_positive, pvsrs_negative, pvsrs_primary, pvsrs_residual] = PVSRS(time, acceleration, q_factor, sampling_rate, freq_per_octave, freq_range_low, freq_range_high, shock_duration)

%  The frequnecy vector is created
fn(1) = freq_range_low;  %First value of frequency vector is defined
z=1;

while true
    if fn(z) > sampling_rate || fn(z) > freq_range_high
        break
    end
    fn(z+1) = fn(1)*(2^(z/freq_per_octave));
    z = z+1;
end

T = 1/sampling_rate;
pvsrs_maximax = zeros(length(fn), 1);
pvsrs_positive = zeros(length(fn), 1);
pvsrs_negative = zeros(length(fn), 1);
pvsrs_primary = zeros(length(fn), 1);
pvsrs_residual = zeros(length(fn), 1);

pr_transition = find(time == shock_duration);

acceleration_ms2=acceleration*9.81;

%//////////////////////////////////////////////////////////////////////
%  Start of PVSRS-Calculation according to ISO18431-4
for j = 1:1:length(fn)

    omega = 2*pi*fn(j);

    A = omega*T/(2*q_factor);
    B = omega*T*(1-1/(4*q_factor^2))^0.5;
    q = ((1/(2*q_factor^2))-1)/(1-1/(4*q_factor^2))^0.5;

    b0 = (1/(T*omega^2))*((1-exp(-A)*cos(B))/q_factor-q*exp(-A)*sin(B)-omega*T);
    b1 = (1/(T*omega^2))*(2*exp(-A)*cos(B)*omega*T-(1-exp(-2*A))/q_factor+2*q*exp(-A)*sin(B));
    b2 = (1/(T*omega^2))*(-exp(-2*A)*(omega*T+1/q_factor)+exp(-A)*cos(B)/q_factor-q*exp(-A)*sin(B));

    a1 = -2*exp(-A)*cos(B);
    a2 = exp(-2*A);

    BB = [ b0,  b1,  b2 ];
    AA = [1, a1, a2 ];

    response=filter(BB,AA,acceleration_ms2);

    pvsrs_maximax(j) = max(abs(response));
    pvsrs_positive(j) = max(response);
    pvsrs_negative(j) = min(response);
    pvsrs_primary(j) = max(response(1:pr_transition));
    %pvsrs_residual(j) = max(response(pr_transition+1:length(response)));

end



%BB, AA and Response are deleted
clear BB;
clear AA;
clear Response;

end

