
index = find(sensor == 4);

for i = 1:length(index)
    T = index(i);
    targets_4(i) = targets(T);
    Features_4(:,:,i) = Features(:,:,T);
end


fname = ['D:\My files\diploma project\data\data_4.mat'];
save(fname ,'Features_4','targets_4');
