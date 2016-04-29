function [Obs_types, ant_delta,ifound_types,eof] = anheader(file)
%ANHEADER Analyzes the header of a RINEX file and outputs
%	       the list of observation types and antenna offset.
%	       End of file is flagged 1, else 0. Likewise for the types.
%	       Typical call: anheader('pta.96o')

%Kai Borre 09-12-96
%Copyright (c) by Kai Borre
%$Revision: 1.0 $   $Date: 1997/09/23  $

fid = fopen(file,'rt');
eof = 0;%End of file
ifound_types = 0;
Obs_types = [];%�۲�ֵ����
ant_delta = [];%antenna offset

while 1% Gobbling����ã� the header
    line = fgetl(fid);
    
    answer = findstr(line,'END OF HEADER');
    if  ~isempty(answer),
        break;
    end;%~ȡ������
    if (line == -1)
        eof = 1;
        break;
    end;
    
    answer = findstr(line,'ANTENNA: DELTA H/E/N');
    if ~isempty(answer)
        for k = 1:3
            [delta, line] = strtok(line);
            del = str2num(delta);
            ant_delta = [ant_delta del];
        end;
    end;
    
    answer = findstr(line,'# / TYPES OF OBSERV');
    if ~isempty(answer)
        [NObs, line] = strtok(line);
        NoObs = str2num(NObs);
        
        %================�Լ���ӵģ��۲�ֵ���Ͷ���9�����================
        if (NoObs>9)
            for k=1:8
                [ot, line] = strtok(line);
                Obs_types = [Obs_types ot];
            end
            [ot, line] =strtok(line,'#');
            ot=strtrim(ot);
            Obs_types = [Obs_types ot];
            line = fgetl(fid);
            for k=1:(NoObs-9)
                [ot, line] = strtok(line);
                Obs_types = [Obs_types ot];
            end
        else
            for k = 1:NoObs
                [ot, line] = strtok(line);
                Obs_types = [Obs_types ot];
            end;
        end
        %================�Լ���ӵģ��۲�ֵ���Ͷ���9�����================
        
        ifound_types = 1;
    end;
end;
%%%%%%%%% end anheader.m %%%%%%%%%
