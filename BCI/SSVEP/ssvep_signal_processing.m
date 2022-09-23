files=4; %%%number of files
samples=10; %%%�number of samples
sample=5; %%%number of individual samples
T=10; %%%sampling time
Fs=1000; %%%sampling frequency
Channel=16;
times=5;%%number of test cycles

%%
testingAccuracy_mean=[];
% for mmm=1:3
%     for nnn=2:5
% T1=nnn; %%%window length
% T2=0.25*2^(mmm-1); %%����
T1=4; %%%window length
T2=0.25; %%length of each step
T3=(T-T1)/T2+1; %%%command number per every stimulus
T5=(T*sample-T1)/T2+1; %%%total number commands

NFFT=8192; %%%sample*T*Fs
T_interval=T/T2;
for N=1:4
   eval(['load(''C:\Users\Luojie\Documents\Thesis\Data\SSVEP Data of Two Subjects\Subject 5','\Finalleft',num2str(N),'.mat'');']);
   eval(['load(''C:\Users\Luojie\Documents\Thesis\Data\SSVEP Data of Two Subjects\Subject 5','\Finalright',num2str(N),'.mat'');']);
end
for N=1:files;
%%
    for i=1:T5
        eval(['frequency1= abs(fft(Finalleft',num2str(N),'(((T2*Fs*(i-1)+1):(T1*Fs+T2*Fs*(i-1))),:), NFFT));']);
        for l=1:3;
        %�ҵ�5.5-6.5Hz,11.5-12.5Hz,23.5-24.5Hz���
        eval(['power_12_mid_left',num2str(N),'(i,l)=sum(frequency1((floor(11.5*NFFT/Fs)+1:floor(12.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_low_left',num2str(N),'(i,l)=sum(frequency1((floor(5.5*(NFFT)/Fs)+1:floor(6.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_high_left',num2str(N),'(i,l)=sum(frequency1((floor(23.5*(NFFT)/Fs)+1:floor(24.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_superhigh_left',num2str(N),'(i,l)=sum(frequency1((floor(35.5*NFFT/Fs)+1:floor(36.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_ultrahigh_left',num2str(N),'(i,l)=sum(frequency1((floor(47.5*NFFT/Fs)+1:floor(48.5*(NFFT)/Fs)+1),l));']);
               %�ҵ�6-7Hz,12.5-13.5Hz,25.5-26.5Hz�����      
        eval(['power_13_mid_left',num2str(N),'(i,l)=sum(frequency1((floor(12.5*(NFFT)/Fs)+1:floor(13.5*(NFFT)/Fs)+1),l));']);
        eval(['power_13_low_left',num2str(N),'(i,l)=sum(frequency1((floor(6*(NFFT)/Fs)+1:floor(7*(NFFT)/Fs)+1),l));']);
        eval(['power_13_high_left',num2str(N),'(i,l)=sum(frequency1((floor(25.5*(NFFT)/Fs)+1:floor(26.5*(NFFT)/Fs)+1),l));']);
        eval(['power_13_superhigh_left',num2str(N),'(i,l)=sum(frequency1((floor(38.5*NFFT/Fs)+1:floor(39.5*(NFFT)/Fs)+1),l));']);
        eval(['power_13_ultrahigh_left',num2str(N),'(i,l)=sum(frequency1((floor(51.5*NFFT/Fs)+1:floor(52.5*(NFFT)/Fs)+1),l));']);
       
        end
    end
    for time_command=1:T3    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ���ֶ����������
        eval(['L_12_stimuli_O1_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_low_left',num2str(N),'(time_command:T_interval:T5,1);']); %3��O1��λ���ǵھ��� 
        eval(['L_12_stimuli_O1_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_mid_left',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['L_12_stimuli_O1_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_high_left',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['L_12_stimuli_O1_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_superhigh_left',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['L_12_stimuli_O1_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_ultrahigh_left',num2str(N),'(time_command:T_interval:T5,1);']);
        
        eval(['L_12_stimuli_O2_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_low_left',num2str(N),'(time_command:T_interval:T5,2);']); %4��O2��λ���ǵھ��� 24=6/T2
        eval(['L_12_stimuli_O2_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_mid_left',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['L_12_stimuli_O2_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_high_left',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['L_12_stimuli_O2_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_superhigh_left',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['L_12_stimuli_O2_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_ultrahigh_left',num2str(N),'(time_command:T_interval:T5,2);']);
        
        eval(['L_12_stimuli_Oz_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_low_left',num2str(N),'(time_command:T_interval:T5,3);']); %5��Oz��λ���ǵھ��� 24=6/T2
        eval(['L_12_stimuli_Oz_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_mid_left',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['L_12_stimuli_Oz_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_high_left',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['L_12_stimuli_Oz_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_superhigh_left',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['L_12_stimuli_Oz_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_ultrahigh_left',num2str(N),'(time_command:T_interval:T5,3);']);
        
        eval(['L_13_stimuli_O1_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_low_left',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['L_13_stimuli_O1_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_mid_left',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['L_13_stimuli_O1_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_high_left',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['L_13_stimuli_O1_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_superhigh_left',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['L_13_stimuli_O1_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_ultrahigh_left',num2str(N),'(time_command:T_interval:T5,1);']);
        
        eval(['L_13_stimuli_O2_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_low_left',num2str(N),'(time_command:T_interval:T5,2);']) ; 
        eval(['L_13_stimuli_O2_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_mid_left',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['L_13_stimuli_O2_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_high_left',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['L_13_stimuli_O2_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_superhigh_left',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['L_13_stimuli_O2_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_ultrahigh_left',num2str(N),'(time_command:T_interval:T5,2);']);
                
        eval(['L_13_stimuli_Oz_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_low_left',num2str(N),'(time_command:T_interval:T5,3);']) ;
        eval(['L_13_stimuli_Oz_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_mid_left',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['L_13_stimuli_Oz_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_high_left',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['L_13_stimuli_Oz_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_superhigh_left',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['L_13_stimuli_Oz_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_ultrahigh_left',num2str(N),'(time_command:T_interval:T5,3);']);
      
    end
    
    eval(['L_12_stimuli_mid',num2str(N),'=[ L_12_stimuli_O1_mid',num2str(N),';L_12_stimuli_O2_mid',num2str(N),';;L_12_stimuli_Oz_mid',num2str(N),'];']); %%%%����������Oz�����ݵĻ�����ǰ����Ҫ��12��Ϊ18
    eval(['L_12_stimuli_low',num2str(N),'=[ L_12_stimuli_O1_low',num2str(N),';L_12_stimuli_O2_low',num2str(N),';L_12_stimuli_Oz_low',num2str(N),'];']);
    eval(['L_12_stimuli_high',num2str(N),'=[ L_12_stimuli_O1_high',num2str(N),';L_12_stimuli_O2_high',num2str(N),';L_12_stimuli_Oz_high',num2str(N),'];']);
    eval(['L_12_stimuli_superhigh',num2str(N),'=[ L_12_stimuli_O1_superhigh',num2str(N),';L_12_stimuli_O2_superhigh',num2str(N),';L_12_stimuli_Oz_superhigh',num2str(N),'];']);
    eval(['L_12_stimuli_ultrahigh',num2str(N),'=[ L_12_stimuli_O1_ultrahigh',num2str(N),';L_12_stimuli_O2_ultrahigh',num2str(N),';L_12_stimuli_Oz_ultrahigh',num2str(N),'];']);
   
    
    eval(['L_13_stimuli_mid',num2str(N),'=[L_13_stimuli_O1_mid',num2str(N),';L_13_stimuli_O2_mid',num2str(N),';L_13_stimuli_Oz_mid',num2str(N),'];']); %%%%����������Oz�����ݵĻ�����ǰ����Ҫ��12��Ϊ18
    eval(['L_13_stimuli_low',num2str(N),'=[ L_13_stimuli_O1_low',num2str(N),';L_13_stimuli_O2_low',num2str(N),';L_13_stimuli_Oz_low',num2str(N),'];']);
    eval(['L_13_stimuli_high',num2str(N),'=[ L_13_stimuli_O1_high',num2str(N),';L_13_stimuli_O2_high',num2str(N),';L_13_stimuli_Oz_high',num2str(N),'];']);
    eval(['L_13_stimuli_superhigh',num2str(N),'=[ L_13_stimuli_O1_superhigh',num2str(N),';L_13_stimuli_O2_superhigh',num2str(N),';L_13_stimuli_Oz_superhigh',num2str(N),'];']);
    eval(['L_13_stimuli_ultrahigh',num2str(N),'=[ L_13_stimuli_O1_ultrahigh',num2str(N),';L_13_stimuli_O2_ultrahigh',num2str(N),';L_13_stimuli_Oz_ultrahigh',num2str(N),'];']);
   
    %%%���ｫͬһʱ�̵������е�һ��stimuli_front��ǰ10��Ϊ��һ��ʱ�̵����ݣ�Ts����֮��10��Ϊ��T.25s�������ݣ��Դ�����
%     eval(['stimuli_left',num2str(N),'=[ L_12_stimuli_low',num2str(N),';L_12_stimuli_mid',num2str(N),';L_12_stimuli_high',num2str(N),';L_13_stimuli_low',num2str(N),' ; L_13_stimuli_mid',num2str(N),'; L_13_stimuli_high',num2str(N),']; ']);
    eval(['stimuli_left',num2str(N),'=[L_12_stimuli_ultrahigh',num2str(N),';L_12_stimuli_high',num2str(N),';L_12_stimuli_mid',num2str(N),';L_12_stimuli_low',num2str(N),';L_12_stimuli_superhigh',num2str(N),';L_13_stimuli_ultrahigh',num2str(N),';L_13_stimuli_high',num2str(N),';L_13_stimuli_superhigh',num2str(N),';L_13_stimuli_low',num2str(N),';L_13_stimuli_mid',num2str(N),']; ']);


%%
    for i=1:T5
        eval(['frequency2=abs(fft(Finalright',num2str(N),'(((T2*Fs*(i-1)+1):(T1*Fs+T2*Fs*(i-1))),:),NFFT));']);
        for l=1:3;
        %�ҵ�5.5-6.5Hz,11.5-12.5Hz,23.5-24.5Hz���
        eval(['power_12_mid_right',num2str(N),'(i,l)=sum(frequency2((floor(11.5*NFFT/Fs)+1:floor(12.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_low_right',num2str(N),'(i,l)=sum(frequency2((floor(5.5*(NFFT)/Fs)+1:floor(6.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_high_right',num2str(N),'(i,l)=sum(frequency2((floor(23.5*(NFFT)/Fs)+1:floor(24.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_superhigh_right',num2str(N),'(i,l)=sum(frequency2((floor(35.5*(NFFT)/Fs)+1:floor(36.5*(NFFT)/Fs)+1),l));']);
        eval(['power_12_ultrahigh_right',num2str(N),'(i,l)=sum(frequency2((floor(47.5*(NFFT)/Fs)+1:floor(48.5*(NFFT)/Fs)+1),l));']);
        %�ҵ�6-7Hz,12.5-13.5Hz,25.5-26.5Hz�����      
        eval(['power_13_mid_right',num2str(N),'(i,l)=sum(frequency2((floor(12.5*(NFFT)/Fs)+1:floor(13.5*(NFFT)/Fs)+1),l));']);
        eval(['power_13_low_right',num2str(N),'(i,l)=sum(frequency2((floor(6*(NFFT)/Fs)+1:floor(7*(NFFT)/Fs)+1),l));']);
        eval(['power_13_high_right',num2str(N),'(i,l)=sum(frequency2((floor(25.5*(NFFT)/Fs)+1:floor(26.5*(NFFT)/Fs)+1),l));']);
        eval(['power_13_superhigh_right',num2str(N),'(i,l)=sum(frequency2((floor(38.5*(NFFT)/Fs)+1:floor(39.5*(NFFT)/Fs)+1),l));']);
        eval(['power_13_ultrahigh_right',num2str(N),'(i,l)=sum(frequency2((floor(51.5*(NFFT)/Fs)+1:floor(52.5*(NFFT)/Fs)+1),l));']);
        end
    end
    for time_command=1:T3    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ���ֶ����������
        eval(['R_12_stimuli_O1_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_low_right',num2str(N),'(time_command:T_interval:T5,1);']); %3��O1��λ���ǵھ��� 
        eval(['R_12_stimuli_O1_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_mid_right',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['R_12_stimuli_O1_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_high_right',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['R_12_stimuli_O1_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_superhigh_right',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['R_12_stimuli_O1_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_ultrahigh_right',num2str(N),'(time_command:T_interval:T5,1);']);
                
        eval(['R_12_stimuli_O2_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_low_right',num2str(N),'(time_command:T_interval:T5,2);']); %4��O2��λ���ǵھ��� 24=6/T2
        eval(['R_12_stimuli_O2_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_mid_right',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['R_12_stimuli_O2_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_high_right',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['R_12_stimuli_O2_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_superhigh_right',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['R_12_stimuli_O2_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_ultrahigh_right',num2str(N),'(time_command:T_interval:T5,2);']);
        
        eval(['R_12_stimuli_Oz_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_low_right',num2str(N),'(time_command:T_interval:T5,3);']); %5��Oz��λ���ǵھ��� 24=6/T2
        eval(['R_12_stimuli_Oz_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_mid_right',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['R_12_stimuli_Oz_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_high_right',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['R_12_stimuli_Oz_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_superhigh_right',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['R_12_stimuli_Oz_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_12_ultrahigh_right',num2str(N),'(time_command:T_interval:T5,3);']);
        
        eval(['R_13_stimuli_O1_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_low_right',num2str(N),'(time_command:T_interval:T5,1);']) ;
        eval(['R_13_stimuli_O1_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_mid_right',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['R_13_stimuli_O1_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_high_right',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['R_13_stimuli_O1_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_superhigh_right',num2str(N),'(time_command:T_interval:T5,1);']);
        eval(['R_13_stimuli_O1_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_ultrahigh_right',num2str(N),'(time_command:T_interval:T5,1);']);
        
        eval(['R_13_stimuli_O2_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_low_right',num2str(N),'(time_command:T_interval:T5,2);']) ; 
        eval(['R_13_stimuli_O2_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_mid_right',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['R_13_stimuli_O2_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_high_right',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['R_13_stimuli_O2_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_superhigh_right',num2str(N),'(time_command:T_interval:T5,2);']);
        eval(['R_13_stimuli_O2_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_ultrahigh_right',num2str(N),'(time_command:T_interval:T5,2);']);
        
        eval(['R_13_stimuli_Oz_low',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_low_right',num2str(N),'(time_command:T_interval:T5,3);']) ;
        eval(['R_13_stimuli_Oz_mid',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_mid_right',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['R_13_stimuli_Oz_high',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_high_right',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['R_13_stimuli_Oz_superhigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_superhigh_right',num2str(N),'(time_command:T_interval:T5,3);']);
        eval(['R_13_stimuli_Oz_ultrahigh',num2str(N),'((1+(time_command-1)*sample):time_command*sample)=power_13_ultrahigh_right',num2str(N),'(time_command:T_interval:T5,3);']);
        
    end
    
    eval(['R_12_stimuli_mid',num2str(N),'=[ R_12_stimuli_O1_mid',num2str(N),';R_12_stimuli_O2_mid',num2str(N),';;R_12_stimuli_Oz_mid',num2str(N),'];']); %%%%����������Oz�����ݵĻ�����ǰ����Ҫ��12��Ϊ18
    eval(['R_12_stimuli_low',num2str(N),'=[ R_12_stimuli_O1_low',num2str(N),';R_12_stimuli_O2_low',num2str(N),';R_12_stimuli_Oz_low',num2str(N),'];']);
    eval(['R_12_stimuli_high',num2str(N),'=[ R_12_stimuli_O1_high',num2str(N),';R_12_stimuli_O2_high',num2str(N),';R_12_stimuli_Oz_high',num2str(N),'];']);
    eval(['R_12_stimuli_superhigh',num2str(N),'=[ R_12_stimuli_O1_superhigh',num2str(N),';R_12_stimuli_O2_superhigh',num2str(N),';R_12_stimuli_Oz_superhigh',num2str(N),'];']);
    eval(['R_12_stimuli_ultrahigh',num2str(N),'=[ R_12_stimuli_O1_ultrahigh',num2str(N),';R_12_stimuli_O2_ultrahigh',num2str(N),';R_12_stimuli_Oz_ultrahigh',num2str(N),'];']);
    
    eval(['R_13_stimuli_mid',num2str(N),'=[R_13_stimuli_O1_mid',num2str(N),';R_13_stimuli_O2_mid',num2str(N),';R_13_stimuli_Oz_mid',num2str(N),'];']); %%%%����������Oz�����ݵĻ�����ǰ����Ҫ��12��Ϊ18
    eval(['R_13_stimuli_low',num2str(N),'=[ R_13_stimuli_O1_low',num2str(N),';R_13_stimuli_O2_low',num2str(N),';R_13_stimuli_Oz_low',num2str(N),'];']);
    eval(['R_13_stimuli_high',num2str(N),'=[ R_13_stimuli_O1_high',num2str(N),';R_13_stimuli_O2_high',num2str(N),';R_13_stimuli_Oz_high',num2str(N),'];']);
    eval(['R_13_stimuli_superhigh',num2str(N),'=[ R_13_stimuli_O1_superhigh',num2str(N),';R_13_stimuli_O2_superhigh',num2str(N),';R_13_stimuli_Oz_superhigh',num2str(N),'];']);
    eval(['R_13_stimuli_ultrahigh',num2str(N),'=[ R_13_stimuli_O1_ultrahigh',num2str(N),';R_13_stimuli_O2_ultrahigh',num2str(N),';R_13_stimuli_Oz_ultrahigh',num2str(N),'];']);
    
    %%%���ｫͬһʱ�̵������е�һ��stimuli_front��ǰ10��Ϊ��һ��ʱ�̵����ݣ�Ts����֮��10��Ϊ��T.25s�������ݣ��Դ�����
%     eval(['stimuli_right',num2str(N),'=[ R_12_stimuli_low',num2str(N),'; R_12_stimuli_mid',num2str(N),';R_12_stimuli_high',num2str(N),'; R_13_stimuli_low',num2str(N),'; R_13_stimuli_mid',num2str(N),';R_13_stimuli_high',num2str(N),']; ']);
    eval(['stimuli_right',num2str(N),'=[R_12_stimuli_ultrahigh',num2str(N),';R_12_stimuli_superhigh',num2str(N),'; R_12_stimuli_low',num2str(N),';R_12_stimuli_high',num2str(N),'; R_12_stimuli_mid',num2str(N),';R_13_stimuli_high',num2str(N),';R_13_stimuli_ultrahigh',num2str(N),';R_13_stimuli_superhigh',num2str(N),';R_13_stimuli_low',num2str(N),'; R_13_stimuli_mid',num2str(N),']; ']);

end
%%
TrainingAccuracy=[];
Testing_accuracy=[];
for time=1:times;
NO=randperm(files);
% NO=[1 2 3 4];
    eval(['Training_left=[stimuli_left',num2str(NO(1)),',stimuli_left',num2str(NO(2)),'];']);
    eval(['Training_right=[stimuli_right',num2str(NO(1)),',stimuli_right',num2str(NO(2)),'];']);
    Training_left=Training_left';
    Training_right=Training_right';    

    eval(['Testing_left=[stimuli_left',num2str(NO(3)),',stimuli_left',num2str(NO(4)),'];']);
    eval(['Testing_right=[stimuli_right',num2str(NO(3)),',stimuli_right',num2str(NO(4)),'];']);
    Testing_left=Testing_left';
    Testing_right=Testing_right';    

m_left=mean(Training_left(:,:));  %%%%��ƽ��
m_right=mean(Training_right(:,:));

M=zeros(size(Testing_left'*Testing_left));
N=zeros(size(Testing_left'*Testing_left));
for i=1:length(Training_left)
    M=(Training_left(i,:)-m_left)'*(Training_left(i,:)-m_left)+M; %%%%% ��������ɢ��
end
for i=1:length(Training_right)
    N=(Training_right(i,:)-m_right)'*(Training_right(i,:)-m_right)+N;
end

Sw=M+N;   %%%%�����ɢ��
w=inv(Sw)*(m_left-m_right)';  %%%%��ͶӰ����-----ϵ��

y_Training_left=Training_left*w;%
y_Training_right=Training_right*w;

y_Testing_left=Testing_left*w;%
y_Testing_right=Testing_right*w;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ROC ����ֵ
y=[y_Training_left
   y_Training_right];

n=100;
m=(max(y)-min(y))/n; %%��ֵ����
left_Train=zeros(1,101);right_Train=zeros(1,101);%ѵ������

for j=1:n+1;
    for i=1:length(y_Training_left)
        if y_Training_left(i)>(j-1)*m+min(y);
            left_Train(j)=left_Train(j)+1;
        end
    end
    for i=1:length(y_Training_right)
        if y_Training_right(i)<=(j-1)*m+min(y);
            right_Train(j)=right_Train(j)+1;
        end
    end
  trainingaccuracy(j)=(left_Train(j)+right_Train(j))/(length(y));   %%%accuracy ��ͼ����ֵ
end

 for j=1:n+1;
     if trainingaccuracy(j)==max(trainingaccuracy);
         threshold=j;
     end
 end    
Training_accuracy=max(trainingaccuracy);


TrainingAccuracy(time)=Training_accuracy;


threshold_y=(threshold-1)*m+min(y);



%%%%%%%%%%%%%%%%%%%%%%%%%%%testing
left_Test=0; right_Test=0;
    for i=1:length(y_Testing_left)
        if y_Testing_left(i)>threshold_y;
            left_Test=left_Test+1;
%             left_Testresult(i)=1;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ÿһ��������ʵ����
%         else y(i)=0;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ÿһ��������ʵ����
        end
    end
    for i=1:length(y_Testing_right)
        if y_Testing_right(i)<=threshold_y;
             right_Test=right_Test+1;
%              right_Testresult(i)=0;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ÿһ��������ʵ����
%         else right_Testresult(i)=1;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ÿһ��������ʵ����
        end
    end

Testing_accuracy(time)=(left_Test+ right_Test)/(length(y_Testing_right)+length(y_Testing_left));

end
TrainingAccuracy_mean=mean(TrainingAccuracy);

TestingAccuracy_mean=mean(Testing_accuracy);

Results(1,1)=TrainingAccuracy_mean;Results(1,2)=TestingAccuracy_mean;
Results(2:16,1)=mean(TrainAccuracy,2);Results(2:16,2)=mean(TestAccuracy,2);
save Results.mat Results;
% testingAccuracy_mean(nnn-1,mmm)=mean(Testing_accuracy);
% 
%     end
% end

