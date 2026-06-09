function [sd_start, sd_end] = Shock_Duration(time, velocity) %// ECSS, 2015, p.415 /// U=1/2*m*v^2 //Velocity

velocity_squared = 0;
velocity_squared_sum = 0;
sliding_rms = zeros(round(length(velocity)/10),1);
sliding_rms_sum = 0;
rms = 0;

k = 1;
j = 0;
for i = 1:length(velocity)
    velocity_squared = velocity(i)^2;
    velocity_squared_sum = velocity_squared_sum + velocity_squared;
    j = j + 1;

    if(mod(i,10) == 0)
        sliding_rms(k) = sqrt(velocity_squared_sum / j);
        k = k+1;
        velocity_sqaured_sum = 0;
        j = 0;
    end
 end

 % If there are any remaining values (if length(velocity) is not divisible by 10)
if j > 0
    sliding_rms(k) = sqrt(velocity_squared_sum / j);
    k = k + 1;
end

% sum of all RMS values multiplied by 0.9
sliding_rms_sum = sum(sliding_rms(1:k-1)) * 0.9;

t_min_index = 1;
t_max_index = length(sliding_rms);
t_diff = length(sliding_rms);

for i = 1:length(sliding_rms)
    sum_val = 0;
    for j = i:length(sliding_rms)
        sum_val = sum_val + sliding_rms(j);
        if sum_val > sliding_rms_sum
            if (j - i) < t_diff
                t_min_index = i;
                t_max_index = j;
                t_diff = j - i;
            end
            break;
        end
    end
end

% Protection against index out-of-bounds errors when accessing time
idx_start = min(t_min_index * 10, length(time));
idx_end = min(t_max_index * 10, length(time));

sd_start = time(idx_start);
sd_end = time(idx_end);

end



