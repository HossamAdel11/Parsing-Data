clc;
clear;
 tone = input ( 'Enter RTTTL Tone :','s');
 i=1;
 %% Part 1 (ignoring the name of tone) 
 while (tone (i)~= ':')
  i=i+1;  
 end
 %% Part 2
 d=0;
 o=0;
 i=i+1;
 %%Obtaining default value of d&o
  while (tone (i)~= 'b')
     if (tone (i)== 'd')
         i=i+2;
         d=tone (i);
     elseif (tone (i)== 'o')
         i=i+2;
         o=tone (i);
         i=i+1;
     end
      i=i+1;
 end  
%%Obtaining default value of b
i=i+2;
LenOfBeat=0;
 while (tone (i)~= ':')
   LenOfBeat=LenOfBeat+1;
   i=i+1;
 end
b=zeros (1,LenOfBeat);
i=i-LenOfBeat;
k=1;
 while (tone (i)~= ':')
   b(k)=tone (i);
   i=i+1;
   k=k+1;
 end
%%converting the ascii value into decimal value
for z= 1:length (d)
        dd(z)=d(z)-48;  
       
end

for z= 1:length (o)
        oo(z)=o(z)-48;  
       
end

for z= 1:length (b)
        bb(z)=b(z)-48; 
       
end
%%convert the array bb which has default value of beats per minute to one
%%number and save it in variable OneBeat

OneBeat=0;
k=1;
while (LenOfBeat~=0)
  OneBeat=OneBeat+bb(k)*10^(LenOfBeat-1);
  k=k+1;
  LenOfBeat=LenOfBeat-1;
end 
OneBeat=(60/OneBeat);
%% Part 3
k=1;
skip=1; %% there is a duration in the note
NameOfNote = 'pcdefgab';  
Octave = '012345678';
flag=0;
i=i+1; %%skip the 2nd ':'
BeginOfPart3 =i;
%% loop to know number of notes
NumOfNotes=1;
for j=BeginOfPart3:length(tone)
    if ( tone(j) == ',' )
        NumOfNotes = NumOfNotes+1;
    end
end  
time = zeros (1,NumOfNotes);
%%determine the duration from each note & save it in "time"
while ( i < length(tone) )
skip=1;
%%checking whether tone(i) begin of note or not 
    if ( tone (i) == ',' )
        k=k+1;
        flag=0;
       
    else
%%to know there is a duration or not
j=8;
while (j ~= 0);
    if ( tone (i)== NameOfNote (j) )
        skip =2; 
    end
    j=j-1;
end 

  
 switch (skip)
    case 1     
             if (tone (i) == '2' )
               time(k) = OneBeat*2;
               flag=1;
             elseif (tone(i) == '4')
               time(k)=OneBeat;
               flag=1;
             elseif (tone (i) == '8')
               time(k)=OneBeat/2;
               flag=1;
             elseif (tone(i) == '3')
               time(k)=OneBeat;
               flag=1;
               i=i+1; %% to skip '2'
             elseif (tone(i) == '1')
                   if  (tone(i+1) == '6')
                      time(k)=OneBeat/4;
                      flag=1; 
                  else
                  time(k)=OneBeat*4;
                  flag=1;
                   end 
             end
    case 2 
        if (flag == 0)
         time(k) = (4*OneBeat)/dd ;
        end
         skip=1;
         flag=1;
    otherwise 
          display ('there is an error in the duration zone');
end
    end
   i=i+1;
end

 UseDefaultOct = 0;
 v=BeginOfPart3;
 NumOfNotes = k;
 %create arrays in length equal to number of notes
 for h=1:NumOfNotes
     freq(h)= 'c';  
     oct (h)= 'a';  
     char (oct);
     char (freq);
 end
 cont =1;
 k=1;
 
 %% find names of notes and save them in array freq
  while ( v <= length (tone) )    
  cont =0; %% means increment v conuter and repeat the loop
  UseDefaultOct = 1 ;
  j=8;
while (j ~= 0);
    if ( tone (v)== NameOfNote (j) )
        cont =1; 
    end
    j=j-1;
end
 %%tone(i) begin of note or not 
   if ( tone (v) == ',' )      
        k=k+1;   
   elseif (cont == 1 )  %%the last two conditions must be one of them valid to begin searching
      
       if (tone(v) == 'd')
             if ( length(tone)<=v)
                 freq (k) = 'd';
             else
           if (tone(v+1) == '#')
                  freq (k) ='q';  %%where q means d#
                  v=v+1; %%to skip 'b'in the string tone 
               else
                  freq (k) = 'd';
           end
             end
        elseif (tone(v) == 'p')
              freq (k) ='p';
        elseif (tone(v) == 'a')
            if ( length(tone)<=v)
                freq (k) ='a';
            else
             if (tone(v+1) == '#')
                  freq (k) ='m'; %%where m means a#
                  v=v+1;
             else
                 freq (k) ='a'; 
             end
            end
        elseif (tone(v) == 'c')
            if ( length(tone)<=v)
                freq (k) = 'c';
            else
              if (tone(v+1) == '#')
                  freq (k) ='w';
                  v=v+1; %%to skip '#'in the string tone 
              else
                  freq (k) = 'c';
              end 
            end
      elseif(tone(v) == 'e')
                  freq (k) = 'e';
      elseif (tone(v) == 'f')
          if ( length(tone)<=v)
              freq (k) ='f';
          else
               if (tone(v+1) == '#')
                  freq (k) ='u'; %%u=f#
                  v=v+1; %%to skip '#'in the string tone 
               else
                  freq (k) ='f';

               end 
          end
      elseif (tone(v) == 'g')
          if ( length(tone)<=v)
              freq (k) ='g';
          else
               if (tone(v+1) == '#')
                  freq (k) ='n'; %%n=g#
                  v=v+1; %%to skip '#' in the string tone 
               else
                  freq (k) ='g';
               end
          end
      elseif (tone(v) == 'b')
                  freq (k) ='b';  
      end
%%to be able to skip searching on the name and begin finding dots
if((v+1)<= length (tone))
if ( tone(v+1) ~= ',' ) 
      v=v+1; 
end 
end
%%find dot 
  if ( tone(v) == '.')
       time (k)= time(k)*1.5;
     if((v+1)<= length (tone))
     if ( tone(v+1) ~= ',')
       v=v+1; %%to skip the dot
     end
     end
  end
%%determine octave
  for L=1:9
      if ( tone(v) == Octave(L) )
          oct(k)= Octave(L);
          UseDefaultOct = 0;
      end
  end
%%Use Default value of octave Or not 
  if (UseDefaultOct == 1)
     oct(k)= o ;
  end
   end
  v=v+1;
  end 
 %%-------------------------------------------------------------------------------------------------------------
 %% now, we have info about every note in arrays : time , freq and oct .
fs=2e4;
NumOfsteps=zeros(1,NumOfNotes);
indexOfLast=0;
indexOfFrist=1;
sam = zeros(1,1000);
 i=1;
 k=1;
b=0;
a=0;
y=0;
%%determine the value of frequencies
 table = [16.35	17.32	18.35	19.45	20.60	21.83	23.12	24.50	25.96	27.50	29.14	30.87; %%0
         32.70	34.65	36.71	38.89	41.20	43.65	46.25	49.00	51.91	55.00	58.27	61.74; %%1   
         65.41	69.30	73.42	77.78	82.41	87.31	92.50	98.00	103.8	110.0	116.5	123.5; %%2
         130.8	138.6	146.8	155.6	164.8	174.6	185.0	196.0	207.7	220.0	233.1	246.9; %%3
         261.6	277.2	293.7	311.1	329.6	349.2	370.0	392.0	415.3	440.0	466.2	493.9; %%4
         523.3	554.4	587.3	622.3	659.3	698.5	740.0	784.0	830.6	880.0	932.3	987.8; %%5
         1047	1109	1175	1245	1319	1397	1480	1568	1661	1760	1865	1976;  %%6
         2093	2217	2349	2489	2637	2794	2960	3136	3322	3520	3729	3951;  %%7
         4186	4435	4699	4978	5274	5588	5920	6272	6645	7040	7459	7902]; %%8
%%        C       C#      D        D#      E      F       F#       G      G#       A     A#      B
%%        1       2       3         4      5      6       7        8      9        10    11      12
  f=zeros(1,NumOfNotes);
  for k=1:NumOfNotes
      a=oct(k)-47;
    if (a==9)
       a=oo;
    end   
if (freq(k)== 'c')
       f(k)= table (a,1);
elseif (freq(k) == 'w')    %% w=c#
       f(k)= table (a,2);
elseif (freq(k) == 'd')
       f(k)= table ((a),3);
elseif (freq(k)== 'q')     %% q=eb
       f(k)= table (a,4);
elseif (freq(k)== 'e')
       f(k)= table (a,5);
elseif (freq(k)== 'f')
       f(k)= table (a,6);
elseif (freq(k)== 'u')
       f(k)= table (a,7);
elseif (freq(k)== 'g')
       f(k)= table ((a),8);
elseif (freq(k)== 'n')
       f(k)= table (a,9);
elseif (freq(k)== 'a')
       f(k)= table ((a),10);
elseif (freq(k)== 'm')%%where m means a#
       f(k)= table ((a),11);
elseif (freq(k)=='p') %%where p means pause
    f(k)=0;
else
       f(k)= table ((a),12);
end 
  end
%% making a delay by the duration value that we have in array "time" & printing it
while (i <= NumOfNotes ) 
   b = (time(i)+a) ;
   NumOfSamplePerNote =fix((b-(1/fs)-a)/(1/fs))+1;
   indexOfLast=indexOfLast+NumOfSamplePerNote;
   fprintf('indexOfFrist=%d\n',indexOfFrist);
   fprintf('indexOfLast=%d\n',indexOfLast);
   fprintf('for i=%d :first step =%f,last step:%f\n',i,a,b);
   
    for h = a:(1/fs):(b-(1/fs))
      
       y=y+1;
       sam(y)=h*f(i);
      
    end
    a=b;
    indexOfFrist =indexOfLast+1;
   
   i=i+1;
   fprintf('--------------------\n');
end
    
%%Finally play the tone and save it as "RTTTLRingtone.wav"
song=0.5*cos(2*pi*sam(1:y));
sound(song,fs);
audiowrite('RTTTLRingtone.wav',song,fs);
    
      
      