clc
clear all
%Create raw DNI database by combining excel documents from the old and new
%database
%Old DNI databse 
dni_raw1 = xlsread('DNI_data_raw_olddb.xlsx');
dni1 = dni_raw1(:,2);
%Change the date format from excel format to matlab
adj = datenum(1900, 1, 1) - 2;
dni_timestamp1 = dni_raw1(:,1) +adj;
dni_timestamp1 = datenum_round_off(dni_timestamp1, 'minute');
dni_timestamp_vec1 = datevec(dni_timestamp1);
%New DNI databse 
dni_raw2 = xlsread('DNI_data_raw_newdb.xlsx');
dni2 = dni_raw2(:,2);
dni_timestamp2 = dni_raw2(:,1) +adj;
dni_timestamp2 = datenum_round_off(dni_timestamp2, 'minute');
dni_timestamp_vec2 = datevec(dni_timestamp2);
%if two timestamps exist, where one contains a -1 value and the other
%contains a measured value, select the measured value
i=1;
while i<=length(dni_timestamp_vec1)
if dni_timestamp_vec1(i,1) == 2015 && dni1(i,1) == -1 
        matrix_date = find((dni_timestamp_vec1(:,1) == dni_timestamp_vec1(i,1)) & (dni_timestamp_vec1(:,2) == dni_timestamp_vec1(i,2)) & (dni_timestamp_vec1(:,3) == dni_timestamp_vec1(i,3)) & (dni_timestamp_vec1(:,4) == dni_timestamp_vec1(i,4)) &(dni_timestamp_vec1(:,5) == dni_timestamp_vec1(i,5)));
        if length(matrix_date) >1;
            m = max( dni1(matrix_date));
            dni1(i,1) = m ;
        else
            dni1(i,1) = -1 ;
        end
end
i=i+1;
end
%Correct daylight savings 
i=1;
while i<=length(dni_timestamp_vec1)
    if dni_timestamp_vec1(i,1) == 2013
    if dni_timestamp_vec1(i,2) >=4 && dni_timestamp_vec1(i,2)<=10
        dni_timestamp_vec1(i,4) = dni_timestamp_vec1(i,4)-1;
    elseif  dni_timestamp_vec1(i,2) ==3 && dni_timestamp_vec1(i,3) >=10
        dni_timestamp_vec1(i,4) = dni_timestamp_vec1(i,4)-1;
    elseif dni_timestamp_vec1(i,2) ==11 &&  dni_timestamp_vec1(i,3) <=2
        dni_timestamp_vec1(i,4) = dni_timestamp_vec1(i,4)-1;
    else 
    end
elseif dni_timestamp_vec1(i,1) == 2014 
    if dni_timestamp_vec1(i,2) >=4 && dni_timestamp_vec1(i,2) <=10
 dni_timestamp_vec1(i,4) = dni_timestamp_vec1(i,4)-1;
    elseif dni_timestamp_vec1(i,2) ==3 && dni_timestamp_vec1(i,3) >=9
 dni_timestamp_vec1(i,4) = dni_timestamp_vec1(i,4)-1;
    elseif dni_timestamp_vec1(i,2) ==11 && dni_timestamp_vec1(i,3) <=1
 dni_timestamp_vec1(i,4) = dni_timestamp_vec1(i,4)-1;
    else
    end
elseif dni_timestamp_vec1(i,1) == 2015 
    if dni_timestamp_vec1(i,2) >=4 &&dni_timestamp_vec1(i,2)<=8
 dni_timestamp_vec1(i,4) = dni_timestamp_vec1(i,4)-1;
    else
    end
    else
    end
i=i+1;
end
clear('dni_timestamp1');
dni_timestamp1 = datenum(dni_timestamp_vec1);
%Combine the old and new DNI database
dni(:,1) = dni1(:,1);
matrix_length1 = length(dni);
%Add new DNI database from switchover date August 18th 2015
date_start_newdb = min(find(dni_timestamp_vec2(:,1) ==2015 & dni_timestamp_vec2(:,2) ==8 &dni_timestamp_vec2(:,3) ==18));
matrix_length2 = length(dni2([date_start_newdb:length(dni2)],1));
dni([matrix_length1+1:(matrix_length1+(matrix_length2))],1) = dni2([date_start_newdb:length(dni2)],1);
dni_timestamp(:,1) = dni_timestamp1(:,1);
dni_timestamp([matrix_length1+1:(matrix_length1+(matrix_length2))],1) = dni_timestamp2([date_start_newdb:length(dni2)],1);
dni_timestamp_vec(:,1:6) = dni_timestamp_vec1(:,1:6);
dni_timestamp_vec([matrix_length1+1:(matrix_length1+(matrix_length2))],1:6) = dni_timestamp_vec2([date_start_newdb:length(dni2)],1:6);

%%%GHI
%Create raw GHI database by combining excel documents from the old and new
%database
%Old GHI databse 
ghi_raw1 = xlsread('GHI_data_raw_olddb.xlsx');
ghi1 = ghi_raw1(:,2);
%Change the date format from excel format to matlab
ghi_timestamp1 = ghi_raw1(:,1) +adj;
ghi_timestamp1 = datenum_round_off(ghi_timestamp1, 'minute');
ghi_timestamp_vec1 = datevec(ghi_timestamp1);
%New GHI database
ghi_raw2 = xlsread('GHI_data_raw_newdb.xlsx');
ghi2 = ghi_raw2(:,2);
ghi_timestamp2 = ghi_raw2(:,1) +adj;
ghi_timestamp2 = datenum_round_off(ghi_timestamp2, 'minute');
ghi_timestamp_vec2 = datevec(ghi_timestamp2);
%if two timestamps exist, where one contains a -1 value and the other
%contains a measured value, select the measured value
i=1;
while i<=length(ghi_timestamp_vec1)
if ghi_timestamp_vec1(i,1) == 2015 && ghi1(i,1) == -1 
        matrix_date = find((ghi_timestamp_vec1(:,1) == ghi_timestamp_vec1(i,1)) & (ghi_timestamp_vec1(:,2) == ghi_timestamp_vec1(i,2)) & (ghi_timestamp_vec1(:,3) == ghi_timestamp_vec1(i,3)) & (ghi_timestamp_vec1(:,4) == ghi_timestamp_vec1(i,4)) &(ghi_timestamp_vec1(:,5) == ghi_timestamp_vec1(i,5)));
        if length(matrix_date) >1;
            ghi1(i,1) = max(ghi1(matrix_date));
        else
            ghi1(i,1) = -1 ;
        end
end
i=i+1;
end
%Correct daylight savings 
i=1;
while i<=length(ghi_timestamp_vec1)
if ghi_timestamp_vec1(i,1) == 2013
    if ghi_timestamp_vec1(i,2) >=4 && ghi_timestamp_vec1(i,2)<=10
        ghi_timestamp_vec1(i,4) = ghi_timestamp_vec1(i,4)-1;
    elseif  ghi_timestamp_vec1(i,2) ==3 && ghi_timestamp_vec1(i,3) >=10
        ghi_timestamp_vec1(i,4) = ghi_timestamp_vec1(i,4)-1;
    elseif ghi_timestamp_vec1(i,2) ==11 &&  ghi_timestamp_vec1(i,3) <=2
        ghi_timestamp_vec1(i,4) = ghi_timestamp_vec1(i,4)-1;
    else 
    end
elseif ghi_timestamp_vec1(i,1) == 2014 
    if ghi_timestamp_vec1(i,2) >=4 && ghi_timestamp_vec1(i,2) <=10
 ghi_timestamp_vec1(i,4) = ghi_timestamp_vec1(i,4)-1;
    elseif ghi_timestamp_vec1(i,2) ==3 && ghi_timestamp_vec1(i,3) >=9
 ghi_timestamp_vec1(i,4) = ghi_timestamp_vec1(i,4)-1;
    elseif ghi_timestamp_vec1(i,2) ==11 && ghi_timestamp_vec1(i,3) <=1
 ghi_timestamp_vec1(i,4) = ghi_timestamp_vec1(i,4)-1;
    else
    end
elseif ghi_timestamp_vec1(i,1) == 2015 
    if ghi_timestamp_vec1(i,2) >=4 &&ghi_timestamp_vec1(i,2)<=8
 ghi_timestamp_vec1(i,4) = ghi_timestamp_vec1(i,4)-1;
    else
    end
else
end
i=i+1;
end
clear('ghi_timestamp1');
ghi_timestamp1 = datenum(ghi_timestamp_vec1);
%Combine two databases
%Remove time period pyranometer not functional
date_remove_start = min(find(ghi_timestamp_vec1(:,1) ==2014 &ghi_timestamp_vec1(:,2) ==6 &ghi_timestamp_vec1(:,3) ==24));
date_remove_end = min(find(ghi_timestamp_vec1(:,1) ==2014 &ghi_timestamp_vec1(:,2) ==10 &ghi_timestamp_vec1(:,3) ==8));
date_start_newdb = min(find(ghi_timestamp_vec2(:,1) ==2015 &ghi_timestamp_vec2(:,2) ==8 &ghi_timestamp_vec2(:,3) ==18));
ghi(:,1) = ghi1([1:date_remove_start,date_remove_end:length(ghi1)],1);
matrix_length1 = length(ghi);
matrix_length2 = length(ghi2([date_start_newdb:length(ghi2)],1));
ghi([matrix_length1+1:(matrix_length1+(matrix_length2))],1) = ghi2([date_start_newdb:length(ghi2)],1);
ghi_timestamp(:,1) = ghi_timestamp1([1:date_remove_start,date_remove_end:length(ghi1)],1);
ghi_timestamp([matrix_length1+1:(matrix_length1+(matrix_length2))],1) = ghi_timestamp2([date_start_newdb:length(ghi2)],1);
ghi_timestamp_vec(:,1:6) = ghi_timestamp_vec1([1:date_remove_start,date_remove_end:length(ghi1)],1:6);
ghi_timestamp_vec([matrix_length1+1:(matrix_length1+(matrix_length2))],1:6) = ghi_timestamp_vec2([date_start_newdb:length(ghi2)],1:6);

%%%DHI
%Create raw DHI database by combining excel documents from the old and new
%database
%Old DHI databse 
dhi_raw1 = xlsread('DHI_data_raw_olddb.xlsx');
dhi1 = dhi_raw1(:,2);
%Convert from excel to matlab date format
dhi_timestamp1 = dhi_raw1(:,1) +adj;
dhi_timestamp1 = datenum_round_off(dhi_timestamp1, 'minute');
dhi_timestamp_vec1 = datevec(dhi_timestamp1);
%New DHI
dhi_raw2 = xlsread('DHI_data_raw_newdb.xlsx');
dhi2 = dhi_raw2(:,2);
%Convert from excel to matlab date format
dhi_timestamp2 = dhi_raw2(:,1) +adj;
dhi_timestamp2 = datenum_round_off(dhi_timestamp2, 'minute');
dhi_timestamp_vec2 = datevec(dhi_timestamp2);
%if two timestamps exist, where one contains a -1 value and the other
%contains a measured value, select the measured value
i=1;
while i<=length(dhi_timestamp_vec1)
if dhi_timestamp_vec1(i,1) == 2015 && dhi1(i,1) == -1 
        matrix_date = find((dhi_timestamp_vec1(:,1) == dhi_timestamp_vec1(i,1)) & (dhi_timestamp_vec1(:,2) == dhi_timestamp_vec1(i,2)) & (dhi_timestamp_vec1(:,3) == dhi_timestamp_vec1(i,3)) & (dhi_timestamp_vec1(:,4) == dhi_timestamp_vec1(i,4)) &(dhi_timestamp_vec1(:,5) == dhi_timestamp_vec1(i,5)));
        if length(matrix_date) >1;
            dhi1(i,1) =  max(dhi1(matrix_date));
        else
            dhi1(i,1) = -1 ;
        end
end
i=i+1;
end
%Correct daylight savings 
i=1;
while i<=length(dhi_timestamp_vec1)
    if dhi_timestamp_vec1(i,1) == 2013
    if dhi_timestamp_vec1(i,2) >=4 && dhi_timestamp_vec1(i,2)<=10
        dhi_timestamp_vec1(i,4) = dhi_timestamp_vec1(i,4)-1;
    elseif  dhi_timestamp_vec1(i,2) ==3 && dhi_timestamp_vec1(i,3) >=10
        dhi_timestamp_vec1(i,4) = dhi_timestamp_vec1(i,4)-1;
    elseif dhi_timestamp_vec1(i,2) ==11 &&  dhi_timestamp_vec1(i,3) <=2
        dhi_timestamp_vec1(i,4) = dhi_timestamp_vec1(i,4)-1;
    else 
    end
elseif dhi_timestamp_vec1(i,1) == 2014 
    if dhi_timestamp_vec1(i,2) >=4 && dhi_timestamp_vec1(i,2) <=10
 dhi_timestamp_vec1(i,4) = dhi_timestamp_vec1(i,4)-1;
    elseif dhi_timestamp_vec1(i,2) ==3 && dhi_timestamp_vec1(i,3) >=9
 dhi_timestamp_vec1(i,4) = dhi_timestamp_vec1(i,4)-1;
    elseif dhi_timestamp_vec1(i,2) ==11 && dhi_timestamp_vec1(i,3) <=1
 dhi_timestamp_vec1(i,4) = dhi_timestamp_vec1(i,4)-1;
    else
    end
elseif dhi_timestamp_vec1(i,1) == 2015 
    if dhi_timestamp_vec1(i,2) >=4 &&dhi_timestamp_vec1(i,2)<=8
 dhi_timestamp_vec1(i,4) = dhi_timestamp_vec1(i,4)-1;
    else
    end
    else
    end
i=i+1;
end
clear('dhi_timestamp1');
dhi_timestamp1 = datenum(dhi_timestamp_vec1);
%Combine old and new databases
dhi(:,1) = dhi1(:,1);
matrix_length1 = length(dhi);
date_start_newdb = min(find(dhi_timestamp_vec2(:,1) ==2015 & dhi_timestamp_vec2(:,2) ==8 &dhi_timestamp_vec2(:,3) ==18));
matrix_length2 = length(dhi2([date_start_newdb:length(dhi2)],1));
dhi([matrix_length1+1:(matrix_length1+(matrix_length2))],1) = dhi2([date_start_newdb:length(dhi2)],1);
dhi_timestamp(:,1) = dhi_timestamp1(:,1);
dhi_timestamp([matrix_length1+1:(matrix_length1+(matrix_length2))],1) = dhi_timestamp2([date_start_newdb:length(dhi2)],1);
dhi_timestamp_vec(:,1:6) = dhi_timestamp_vec1(:,1:6);
dhi_timestamp_vec([matrix_length1+1:(matrix_length1+(matrix_length2))],1:6) = dhi_timestamp_vec2([date_start_newdb:length(dhi2)],1:6);
%Convert matlab time to sunlab official format
dni_timestamp_vec(1:length(dni_timestamp_vec),6) =0;
dni_timestamp_excel = datestr(dni_timestamp_vec(:,1:6),'yyyy-mm-dd HH:MM:SS');
dni_timestamp_excel = cellstr(dni_timestamp_excel);
ghi_timestamp_vec(1:length(ghi_timestamp_vec),6) =0;
ghi_timestamp_excel = datestr(ghi_timestamp_vec(:,1:6),'yyyy-mm-dd HH:MM:SS');
ghi_timestamp_excel = cellstr(ghi_timestamp_excel);
dhi_timestamp_vec(1:length(dhi_timestamp_vec),6) =0;
dhi_timestamp_excel = datestr(dhi_timestamp_vec(:,1:6),'yyyy-mm-dd HH:MM:SS');
dhi_timestamp_excel = cellstr(dhi_timestamp_excel);
%write to excel
dni_excel(:,1) = dni(:,1);
xlswrite('dni_raw_add2sql1_timestamp.xlsx',dni_timestamp_excel(1:1000000,1))
xlswrite('dni_raw_add2sql2_timestamp.xlsx',dni_timestamp_excel(1000001:(length(dni)),1))
xlswrite('dni_raw_add2sql1.xlsx',dni_excel(1:1000000,1))
xlswrite('dni_raw_add2sql2.xlsx',dni_excel(1000001:(length(dni)),1))
ghi_excel(:,1) = ghi(:,1);
xlswrite('ghi_raw_add2sql_timestamp.xlsx',ghi_timestamp_excel)
xlswrite('ghi_raw_add2sql.xlsx',ghi_excel)
dhi_excel(:,1) = dhi(:,1);
xlswrite('dhi_raw_add2sql_timestamp.xlsx',dhi_timestamp_excel)
xlswrite('dhi_raw_add2sql.xlsx',dhi_excel)
%Save variables to .mat files
save('load_ghidhi','ghi','ghi_timestamp','ghi_timestamp_vec','dhi','dhi_timestamp','dhi_timestamp_vec');
