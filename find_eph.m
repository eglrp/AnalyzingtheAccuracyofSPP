function icol = find_eph(Eph,sv,time)
%FIND_EPH  Finds the proper column in ephemeris array

%Kai Borre and C.C. Goad 11-26-96
%Copyright (c) by Kai Borre
%$Revision: 1.2 $  $Date: 2004/02/09  $

icol = 0;%������������λ�ڵڼ��еı��
isat = find(Eph(1,:) == sv);%�ڵڼ���
n = size(isat,2);%isat����������n
if n == 0%n=0����һ�ж�û�У�����û�ҵ�
   return
end;
icol = isat(1);
dtmin = Eph(21,icol)-time;

%{
�����ⲿ��û����
%}
for t = isat%������ʲô����
   dt = Eph(21,t)-time;
   if dt < 0
      if abs(dt) < abs(dtmin)
         icol = t;
         dtmin = dt;
      end
   end
end
%%%%%%%%%%%%  find_eph.m  %%%%%%%%%%%%%%%%%
