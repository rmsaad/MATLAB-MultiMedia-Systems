%  ELE 725 Lab 1 Report
%  *Authors:*  Rami Saad (500637869)
%% Audio File Properties 
    
    % Read in Audio Test
    [y,Fs] = audioread("ELE725_lab1.wav");
    sound(y,Fs);
    
    % Gather Audio Information
    info = audioinfo("ELE725_lab1.wav");
    
    % Sampling rate = 44100
    
    % bitrate = 44100 x 16 x 2
    % bitrate = 1.4Mbs
    
    % File Size = Numchannels * TotalSamples * Bits per Sample
    % File Size = 2 * 116736 * 16 
    % File Size = 456 kb 
    
%% Sampling
    %% DownSampling 
    
    % Read in unaltered Wav for comparison Later
    [y,Fs] = audioread("ELE725_lab1.wav");
    
    % DownSampling variables
    N = 8; pf = 1;

    % run the downsample function
    outFile = DownSample("ELE725_lab1.wav", N, pf);

    % read the new Wav File
    [yDownSample,FsDownSample] = audioread(outFile);

    % Attempt to restore audio with interp1() function
    nSamples            = 0: 1 :(length(yDownSample)-1);
    nInterpolateSamples = 0:1/N:(length(yDownSample))-1/N;

    yRestored = interp1(nSamples, yDownSample, nInterpolateSamples);
    yRestored(isnan(yRestored)) = 0;
    
    %% Playback Unaltered Audio & plot
    sound(y,Fs)
    sampleSize = length(y);
    
    % get fft
    Yfft = fft(y(:, 1));
    Yfft = Yfft(1:sampleSize/2+1);
    
    % freq vectors
    freq = 0:Fs/sampleSize:Fs/2;
    
    % plot magnitude
    subplot(211);
    plot(freq,abs(Yfft)); %axis([0 4000 0 400]);
    
    % plot phase
    subplot(212);
    plot(freq,unwrap(angle(Yfft))); 
    xlabel('Hz');
    
    %% Playback Down Sample & plot
    sound(yDownSample, FsDownSample);
    sampleSize = length(yDownSample);
    
     % get fft
    Yfft = fft(yDownSample(:, 1));
    Yfft = Yfft(1:sampleSize/2+1);
    
    % freq vectors
    freq = 0:FsDownSample/sampleSize:FsDownSample/2;
    
    % plot magnitude
    subplot(211);
    plot(freq,abs(Yfft)); %axis([0 4000 0 100]);
    
    % plot phase
    subplot(212);
    plot(freq,unwrap(angle(Yfft))); 
    xlabel('Hz');
    
    %% Playback Restored Audio & plot
    sound(yRestored, FsDownSample*N);
    sampleSize = length(yRestored);
    
   % get fft
    Yfft = fft(yRestored(:, 1));
    Yfft = Yfft(1:sampleSize/2+1);
    
    % freq vectors
    freq = 0:(FsDownSample*N)/sampleSize:(FsDownSample*N)/2;
    
    % plot magnitude
    subplot(211);
    plot(freq,abs(Yfft)); %axis([0 4000 0 100]);
    
    % plot phase
    subplot(212);
    plot(freq,unwrap(angle(Yfft))); 
    xlabel('Hz');
    
%% Quantization
    %% Uniform
    
    % uniformQuant input variables
    N = 16;
    
    % call the UniformQuant function and store the results
    outFile = UniformQuant("ELE725_lab1.wav", N);
    [yUniform,FsUniform] = audioread(outFile);

    
    % playback the sound
    sound(yUniform, FsUniform);
    
    %% MuLaw
    
    % MuLawQuant input variables
    N = 16;
    Mu = 100;
    
    % call the MuLawQuant function and store the result
    outFile = MuLawQuant("ELE725_lab1.wav", N, Mu);
    [yMuLaw,FsMuLaw] = audioread(outFile);
   
    % playback the sound
    sound(yMuLaw, FsMuLaw);
    
    %% plot 
    
    n = 10001:10200;
    U = yUniform(n);
    M = yMuLaw(n);
    
    %subplot(211);
    %plot(n,U);
    
    %subplot(212);
    plot(n,N);
    