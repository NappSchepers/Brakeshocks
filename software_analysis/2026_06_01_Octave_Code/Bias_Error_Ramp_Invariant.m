function [fn, bias_error] = Bias_Error_Ramp_Invariant(sampling_rate, freq_per_octave, freq_range_low, freq_range_high)

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

bias_error = zeros(length(fn));

%//////////////////////////////////////////////////////////////////////
%  Start of Bias Error-Calculation according to ISO18431-4
for j = 1:1:length(fn)

    bias_error(j) = 1-(sin((pi*fn(j))/sampling_rate)/((pi*fn(j))/sampling_rate))^2;

end

end

