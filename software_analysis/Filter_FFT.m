function [amplitude_fft_filtered, frequ, Y_fft] = Filter_FFT(time, amplitude, sampling_rate, highpass, lowpass)


% FFT filtering
hp_fft = round(highpass*length(time)/sampling_rate);
lp_fft = round(lowpass*length(time)/sampling_rate);

Y = fft(amplitude); % Fourier Transformation - complex

% Highpass
Y_hp=Y;
Y_hp(1:1:hp_fft)=0;
Y_hp(end:-1:end-hp_fft)=0; % symmetric zeroing

% Lowpass - making it a bandpass filter
Y_bp=Y_hp;
halfway=round(length(Y)/2);
Y_bp(lp_fft:1:halfway)=0;
Y_bp(end-lp_fft:-1:halfway)=0; % symmetric zeroing

amplitude_i=ifft(Y_bp); %ifft

amplitude_fft_filtered=real(amplitude_i); %the small imagninary parts are removed

% Now the fft of the filtered signal is calculated
L_half=round(length(time)/2);
Y_fft = 2/length(time)*abs(Y_bp(1:L_half+1));
frequ = sampling_rate*(0:L_half)/length(time);

if lp_fft <= 1
  error("The low-pass filter cannot be resolved with this combination of Fs and N (lp_fft=%d, df=%.3g Hz).", lp_fft, sampling_rate/length(time));
end


end

