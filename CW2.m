% Oliver Chadwick
% efyoc4@nottingham.ac.uk

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

clear % clears workspace
clc % clears command window

a = arduino("COM3","Uno"); % establishes a connection between matlab and arduino

for i = 1:5   % loops 5 times 
    writeDigitalPin(a,'D2',1); % turns LED on
    pause(0.5); % adds 0.5 second delay
    writeDigitalPin(a,'D2',0); % turns LED off
    pause(0.5);
end % ends loop 

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clear
clc
a = arduino('COM3','Uno');

duration = 600; % sets duration variable to 600 seconds
TC = 0.01; % sets value of temperature coefficient for the thermistor
V0 = 0.5; % sets value of voltage at 0 degrees celsuis for the thermistor

time = 0:duration-1; % creates time array
voltage = zeros(size(time)); % creates voltage array
temperature = zeros(size(time)); % creates temperature array

for i = 1:length(time) % starts a loop to acquire temperature data
    voltage(i) = readVoltage(a,'A0');  % reads voltage of the thermistor
    temperature(i) = (voltage(i)-V0)/TC; % converts voltage to temperature
    pause(1); % adds 1 second delay
end

minTemp = min(temperature); % retrieves minimum temperature 
maxTemp = max(temperature); % retrieves maximum temperature 
avgTemp = mean(temperature); % calculates maximum temperature 

figure; % creates a figure for the graph
plot(time, temperature); % plots a graph of time against temperature
xlabel('Time (s)'); % labels x axis as time
ylabel('Temperature (°C)'); % labels y axis as temperature
title('Temperature vs Time'); % adds a title to the graph
grid on; % turns grid on for the graph 

fprintf('Date: %s\n', datetime("now")); % displays the date and time in command window
fprintf('Location: Nottingham\n\n'); % displays the location in the command window

% displaying the temperature value at each minute interval in a table
fprintf('Minute\t\tTemperature (°C)\n'); % displays the headers for the table
fprintf('--------------------------------\n');
for i = 1:60:length(time) % starts a loop that displays the values in the table
    minute = (i-1)/60;
    fprintf('%-10d\t%.2f\n', minute, temperature(i));
end
fprintf('--------------------------------\n');
fprintf('Minimum Temperature: %.2f °C\n', minTemp); % displays minimum temperature with 2 decimal places in command window
fprintf('Maximum Temperature: %.2f °C\n', maxTemp); % displays maximum temperature with 2 decimal places in command window
fprintf('Avgerage Temperature: %.2f °C\n\n', avgTemp); % displays average temperature with 2 decimal places in command window

% writes the temperature data in a log file
fid = fopen('capsule_temperature.txt','w');
fprintf(fid,'Date: %s\n', datetime("now"));
fprintf(fid,'Location: Nottingham\n\n');
fprintf('Minute\t\tTemperature (°C)\n');
fprintf('--------------------------------\n');
for i = 1:60:length(time)
    minute = (i-1)/60;
    fprintf('%-10d\t%.2f\n', minute, temperature(i));
end
fprintf('--------------------------------\n');
fprintf('Minimum Temperature: %.2f °C\n', minTemp);
fprintf('Maximum Temperature: %.2f °C\n', maxTemp); 
fprintf('Avgerage Temperature: %.2f °C\n\n', avgTemp); 
fclose(fid);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]



%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% No need to enter any answers here, please answer on the .docx template.


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answers here, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.