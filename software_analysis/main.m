
delimiter = ',';
decimal_separator = '.';
first_line_of_data = 1;
measuring_amplifier = 1.25; %sensitivity from data sheet of 830M1 sensor
lowpass = 10000;
highpass = 100;
q_factor = 10;
freq_per_octave = 6;
freq_range_low = 100;
freq_range_high = 10000;
count_lb = 0;


[time_amplitude_data,num_of_files] = Read_Data( delimiter, decimal_separator, first_line_of_data);

 if num_of_files == 0
            %%%%%%%%%%%%%%%%%%%
            %%%%Calculation%%%%%
            for i=1:length(time_amplitude_data)
                [time, amplitude, sampling_rate] = Scale_Data(time_amplitude_data{i}, measuring_amplifier);
                [acceleration_fft_filtered, frequ, Y_fft] = Filter_FFT(time, amplitude, sampling_rate, highpass, lowpass);
                [velocity] = Integration(time, acceleration_fft_filtered*9.81);
                [displacement] = Integration(time, velocity);
                [sd_start, sd_end] = Shock_Duration(time, velocity);

                [fn_pvsrs, pvsrs_maximax, pvsrs_positive, pvsrs_negative, pvsrs_primary, pvsrs_residual] = PVSRS(time, acceleration_fft_filtered, q_factor, sampling_rate, freq_per_octave, freq_range_low, freq_range_high, sd_end);

                [fn_bias_error, bias_error] = Bias_Error_Ramp_Invariant(sampling_rate, freq_per_octave, freq_range_low, freq_range_high);

                Plot_PVSRS_new(fn_pvsrs, pvsrs_maximax);

                end
            %%%%%%%%%%%%%%%%%%%
 else



                for i=1:length(time_amplitude_data)
                    [time, amplitude, sampling_rate] = Scale_Data(time_amplitude_data{i}, measuring_amplifier);
                    [acceleration_fft_filtered, frequ, Y_fft] = Filter_FFT(time, amplitude, sampling_rate, highpass, lowpass);
                    [velocity] = Integration(time, acceleration_fft_filtered*9.81);
                    [displacement] = Integration(time, velocity);
                    [sd_start, sd_end] = Shock_Duration(time, velocity);

                    [fn_pvsrs, pvsrs_maximax, pvsrs_positive, pvsrs_negative, pvsrs_primary, pvsrs_residual] = PVSRS(time, acceleration_fft_filtered, q_factor, sampling_rate, freq_per_octave, freq_range_low, freq_range_high, sd_end);

                    [fn_bias_error, bias_error] = Bias_Error_Ramp_Invariant(sampling_rate, freq_per_octave, freq_range_low, freq_range_high);

                    pvsrs(:,i) = pvsrs_maximax;
                    pvsrs_pos(:,i) = pvsrs_positive;
                    pvsrs_neg(:,i) = pvsrs_negative;
                    pvsrs_pri(:,i) = pvsrs_primary;
                    pvsrs_res(:,i) = pvsrs_residual;

                end
                 pvsrs_mm_mean = sum(pvsrs,2)/size(pvsrs,2);
                 pvsrs_pos_mean = sum(pvsrs_pos,2);
                 pvsrs_neg_mean = sum(pvsrs_neg,2);
                 pvsrs_pri_mean = sum(pvsrs_pri,2);
                 pvsrs_res_mean = sum(pvsrs_res,2);

                 value = 1;

                 Plot_PVSRS_new(fn_pvsrs, pvsrs_maximax);



            end

