%Create database measured
clc
clear all
load('Irradiance_dataset_codepart2');
IrradianceDataset.timestamp = Irradiance_dataset.timestamp(1:577350,1:5);
IrradianceDataset.GHI = Irradiance_dataset.GHI(1:577350,1);
IrradianceDataset.DNI = Irradiance_dataset.DNI(1:577350,1);
IrradianceDataset.DNI_validation = Irradiance_dataset.DNI_validation(1:577350,1);
IrradianceDataset.DHI = Irradiance_dataset.DHI(1:577350,1);
IrradianceDataset.SZA= Irradiance_dataset.SZA(1:577350,1);

IrradianceDataset.timestamp(1:length(IrradianceDataset.timestamp),6) =0;
IrradianceDataset.timestamp_datenum = datestr(IrradianceDataset.timestamp(:,1:6),'yyyy-mm-dd HH:MM:SS');
IrradianceDataset.timestamp_datenum = cellstr(IrradianceDataset.timestamp_datenum);

%excel table
IrradianceDataset_excel_timestamp(:,1) = IrradianceDataset.timestamp_datenum;
IrradianceDataset_excel(:,1) = IrradianceDataset.DNI;
IrradianceDataset_excel(:,2) = IrradianceDataset.DNI_validation;
IrradianceDataset_excel(:,3) = IrradianceDataset.GHI;
IrradianceDataset_excel(:,4) = IrradianceDataset.DHI;
IrradianceDataset_excel(:,5) = IrradianceDataset.SZA;


save('Irradiance_measured','IrradianceDataset');
xlswrite('Irradiance_measured.xlsx',IrradianceDataset_excel);
xlswrite('Irradiance_measured_timestamp.xlsx',IrradianceDataset_excel_timestamp);