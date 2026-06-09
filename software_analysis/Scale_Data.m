function [time, amplitude, sampling_rate] = Scale_Data(time_amplitude_data, measuring_amplifier)

amplitude = time_amplitude_data(:,2)/(measuring_amplifier/1000); % acceleration value in Volt divided by e.g. 10 mv/g - 0.01V/g
time = time_amplitude_data(:,1) - time_amplitude_data(1,1);
sampling_rate = length(time)/(time(end)-time(1));

end

