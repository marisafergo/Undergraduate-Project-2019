function [fileout] = excludefdip(filein,n,column,fileoutname)
% This function extracts rows with fdip > n from a given file
% and writes the filtered rows into a new file
% NOTE: filein and fileout are strings; column contains the fdip values

data = dlmread(filein);
data_new = data(data(:,column) > n,:); % isolating files with fdip > n
fileout = fileoutname;
dlmwrite(fileout,data_new,'delimiter',' ','precision','%.8f');

end

