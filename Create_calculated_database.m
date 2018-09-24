%Load Irradiance table
clc
clear all
load('Irradiance_dataset_codepart2');
IrradianceDataset.timestamp = Irradiance_dataset.timestamp(1:577350,1:5);
IrradianceDataset.timestamp(length(IrradianceDataset.timestamp),6) = 0;
IrradianceDataset.GHI = Irradiance_dataset.GHI(1:577350,1);
IrradianceDataset.DNI = Irradiance_dataset.DNI(1:577350,1);
IrradianceDataset.DNI_validation = Irradiance_dataset.DNI_validation(1:577350,1);
IrradianceDataset.DHI = Irradiance_dataset.DHI(1:577350,1);
IrradianceDataset.SZA= Irradiance_dataset.SZA(1:577350,1);
IrradianceDataset.temperature= Irradiance_dataset.temperature(1:577350,1);

%Find calculated values when measured values not available
i=1; count=1;count2=1;
while i<=length(IrradianceDataset.GHI)
    if IrradianceDataset.DNI(i,1)~=-1 && IrradianceDataset.GHI(i,1)~=-1&& IrradianceDataset.GHI(i,1)~=0 && IrradianceDataset.DHI(i,1)==-1
        IrradianceDataset.DHI(i,1) = IrradianceDataset.GHI(i,1) - cos(IrradianceDataset.SZA(i,1))*IrradianceDataset.DNI(i,1);
         IrradianceDataset.DHI_validation(i,1) = 2;
         count = count+1;
    else
       IrradianceDataset.DHI_validation(i,1) = 1;
    end
  
    if IrradianceDataset.DNI(i,1)~=-1 && IrradianceDataset.DHI(i,1)~=-1 && IrradianceDataset.GHI(i,1)==-1
        IrradianceDataset.GHI(i,1) = IrradianceDataset.DHI(i,1) + cos(IrradianceDataset.SZA(i,1))*IrradianceDataset.DNI(i,1);
         IrradianceDataset.GHI_validation(i,1) = 2;
           count2 = count2+1;
    else
       IrradianceDataset.GHI_validation(i,1) = 1 ;
    end
    
i=i+1;
end

IrradianceDataset.timestamp_datenum = datestr(IrradianceDataset.timestamp(:,1:6),'yyyy-mm-dd HH:MM:SS');
IrradianceDataset.timestamp_datenum = cellstr(IrradianceDataset.timestamp_datenum);
%excel table
IrradianceDataset_excel_timestamp(:,1) = IrradianceDataset.timestamp_datenum;
IrradianceDataset_excel(:,1) = IrradianceDataset.DNI;
IrradianceDataset_excel(:,2) = IrradianceDataset.DNI_validation;
IrradianceDataset_excel(:,3) = IrradianceDataset.GHI;
IrradianceDataset_excel(:,4) = IrradianceDataset.GHI_validation;
IrradianceDataset_excel(:,5) = IrradianceDataset.DHI;
IrradianceDataset_excel(:,6) = IrradianceDataset.DHI_validation;
IrradianceDataset_excel(:,7) = IrradianceDataset.SZA;
IrradianceDataset_excel(:,8) = IrradianceDataset.temperature;

save('Irradiance_dataset_measured&calc');
xlswrite('Irradiance_measandcalc.xlsx',IrradianceDataset_excel);
xlswrite('Irradiance_measandcalc_timestamp.xlsx',IrradianceDataset_excel_timestamp);    