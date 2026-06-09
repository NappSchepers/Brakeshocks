function [time_amplitude_data,num_of_files] = Read_Data(delimiter, decimal_separator, first_line_of_data)


[filename, pathname] = uigetfile({'*.csv;*.txt', 'CSV and TXT files (*.csv, *.txt)'}, 'Choose a CSV- or TXT-file');
files = dir(fullfile(pathname, '*.*'));



[~,~,ext] = fileparts(filename);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The CSV file is now being read

if strcmpi(ext, '.csv')

if length(files) > 1
    num_of_files = 1;
else num_of_files = 0;
end

for i=1:length(files)
    file_path = strcat(pathname, '\', filename);

    time_amplitude_data{i} = csvread(file_path,first_line_of_data-1,0);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The txt files is now being read

elseif strcmpi(ext,'.txt')
   files = dir(fullfile(pathname, '*.txt'));
   num_of_files = length(files);
   time_amplitude_data = cell(1, num_of_files);
   Fs = 97553.362; %Sampling frequency for sequential data acquisition 97,553362 kHz
   dt = 1/Fs;

   for i = 1:num_of_files
     file_path = fullfile(pathname, files(i).name);
     data = dlmread(file_path, ' ');

     amplitude_vector = data(:);


     N = length(amplitude_vector);
     time_vector = (0:N-1)'*dt;



     output_matrix = [time_vector, amplitude_vector];


     time_amplitude_data{i} = output_matrix;



   end

end

end


