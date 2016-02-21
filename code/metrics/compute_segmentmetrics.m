function Err = compute_segmentmetrics(Map0, Map1)
% Err = [1-true pos, 1 - true neg] = [False pos, Miss rate]
%Rmap0 = ground truth
%Rmap1 = recovered segmentation

%if nargin<3
    % hamming distance is symmetric - so order doesnt matter
%    distfn = 'hamming';
%end

%L = length(Rmap0(:));
%Err = pdist2(Rmap0(:)',Rmap1(:)',distfn);
%nm1 = pdist2(zeros(1,L),Rmap1(:)',distfn);
%nm2 = pdist2(zeros(1,L),Rmap0(:)',distfn);
%Dist = Err./(nm1*nm2);


%tmp= Rmap1-Rmap0; 
%FPos = 1 - sum(tmp(:)<0)/sum(Rmap1(:)~=0);
%Miss = sum(tmp(:)>0)/sum(Rmap0(:)~=0);


set0tp = find(Map0~=0);
set1p = find(Map1~=0);

TP = length(intersect(set0tp,set1p))./(length(set0tp));

set0tn = find(Map0==0);
set1n = find(Map1==0);
TN = length(intersect(set0tn,set1n))./(length(set0tn));

Err = [1-TP,1-TN];

end