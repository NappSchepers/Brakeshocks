function [amplitude_integrated] = Integration(time, amplitude)

amplitude_integrated = cumtrapz(time, amplitude);
amplitude_integrated = detrend(amplitude_integrated,'constant');

end

