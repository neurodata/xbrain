%%%%%%%%%%%%%%%%%%%%%%
function Nmap = OMP_ProbMap(Prob,ptr,presid,startsz,dilatesz,kmax)
%Prob0 = Prob; 

Prob = Prob.*(Prob>ptr);

box_radius = ceil(max(startsz)/2) + 1;
Dict = create_synth_dict(startsz,box_radius);
Ddilate = create_synth_dict(startsz+dilatesz,box_radius);
Lbox = round(length(Dict)^(1/3));

Nmap = zeros(size(Prob));
newid = 1;
newtest = Prob;
for ktot = 1:kmax
    tic,
    val = zeros(size(Dict,2),1);
    id = zeros(size(Dict,2),1);
    
    for j = 1:size(Dict,2)
       convout = convn_fft(newtest,reshape(Dict(:,j),Lbox,Lbox,Lbox));
       [val(j),id(j)] = max(convout(:)); % positive coefficients only
    end
    
    % find position in image with max correlation
    [~,which_atom] = max(val); 
    which_loc = id(which_atom); 
  
    X2 = compute3dvec(Dict(:,which_atom),which_loc,Lbox,size(newtest));
    xid = find(X2); 
    Nmap(xid) = newid;
    
    X3 = compute3dvec(Ddilate,which_loc,Lbox,size(newtest));
    
    newid = newid+1;
    newtest = newtest.*(X3==0);
    ptest = val./sum(Dict);
    
    if ptest<presid
        return
    end
    display(['Iter = ', int2str(ktot),', Corr = ', num2str(ptest,3)])
    toc,
end

end
    
    
   


