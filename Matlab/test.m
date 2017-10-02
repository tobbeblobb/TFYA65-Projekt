% TFYA65 Test
clear 
clc

%choose string
refHz = input('Enter string: ');

switch refHz
    case 1
        refHz = 329.6;
    case 2
        refHz = 246.9;
    case 3
        refHz = 196;
    case 4
        refHz = 146.8;
    case 5
        refHz = 110;
    case 6
        refHz = 82.4;
end 

% %read audio file
[string, fs] = audioread('ljudfiler\6th_String_E.mp3');

% %live record audio file (fungerar! men inte med v�r h�rdkodade
% %autocorr-funktion)
% fs = 44100;
% recObj = audiorecorder(fs, 16, 2);
% %Record your voice for 5 seconds.
% recObj = audiorecorder;
% disp('Start speaking.')
% recordblocking(recObj, 3);
% disp('End of Recording.');
% %Store data in double-precision array.
% string = getaudiodata(recObj);

%plot sound
plot(string);
figure

nf=1024; %number of point in DTFT
Y = fft(string,nf);
plot(abs(Y(1:nf/2+1)));
figure
h = fdesign.lowpass('Fp,Fst,Ap,Ast', 400, 500, 1, 60, fs);
Hd = design(h, 'equiripple', 'MinOrder', 'any', 'StopbandShape', 'flat');
filter(Hd, Y);


%calculate frequency using autocorrelation
Hz = autocorr(string, fs)

%plot ref-frequency & recorded frequency
t= 0:0.01:10;    
plot(t,ones(size(t))*refHz, '-g');
hold on
plot(t,ones(size(t))*Hz, '-r')
xlim([0 10])
ylim([refHz-500 refHz+500])




