%%%%%%%%%%%%%%%%%%%%%%
% OMP_ProbMap_deploy(probFile,presid,startballsz,dilatesz, kmax, paintFile, centroidFile)
% Input
%%%
% probFile = string with name of the Ramon Volume containing the probability map 
% [(Nx,Ny,Nz) array of 32 bit numbers which range from (0,1)]
%
% presid = stopping criterion for algorithm (the minimum correlation between
%          probability map + template to declare a detection) [scalar from (0,1)]
%
% startballsz = size of sphere used as initial template [integer]
%
% dilatesz = dilate template by this amount when removing a cell from the
% probability map [integer]
%
% kmax = maximum number of cells (alternate stopping criterion) [integer]
%%%
% Output
%%%
% paintFile = name of output file to write paint output [(Nx, Ny, Nz) array]
% centroidFile = name of output file to write K detected centroids to [(4,K) array]
function OMP_ProbMap_deploy(probFile,presid,startballsz,dilatesz, kmax, paintFile, centroidFile)

% load in Ramon Volume 
load(probFile) % assume stored in cube
Prob = cube.data; % Prob is now a (Nx,Ny,Nz) array of numbers from (0,1)

%% Step 1. Create sphere template inside of bounding box
box_radius = ceil(max(startballsz)/2) + 1; % define radius of bounding box around template
Dict = create_synth_dict(startballsz,box_radius); % create dictionary containing a sphere of diameter startballsz
Lbox = round(length(Dict)^(1/3));

Nmap = zeros(size(Prob));
newid = 1;
newtest = Prob;
Centroids = [];
for ktot = 1:kmax
    
    val = zeros(size(Dict,2),1);
    id = zeros(size(Dict,2),1);
    
    for j = 1:size(Dict,2)
       convout = convn_fft(newtest,reshape(Dict(:,j),Lbox,Lbox,Lbox));
       [val(j),id(j)] = max(convout(:)); % positive coefficients only
    end
    
    % find position in image with max correlation
    if val == 0 % corner case
        break
    end
    [~,which_atom] = max(val); 
    which_loc = id(which_atom); 
  
    X2 = compute3dvec(Dict(:,which_atom),which_loc,Lbox,size(newtest));
    xid = find(X2); 
    Nmap(xid) = newid;
    
    newid = newid+1;
    newtest = newtest.*(imdilate(X2,strel3d(dilatesz))<=0);
    ptest = val./sum(Dict);
    
    if ptest<presid
        break%return
    end
    
    [rr,cc,zz] = ind2sub(size(newtest),which_loc);
    
    if ~isempty(cube.xyzOffset)
        newC = cube.xyzOffset + [cc, rr, zz] - [1, 1, 1]; %TODO
    else
        newC = [cc, rr, zz];
    end

    Centroids = [Centroids; [newC,ptest]]; 
    display(['Iter remaining = ', int2str(kmax-ktot), ...
             ' Correlation = ', num2str(ptest,3)])
         
end

save(centroidFile,'Centroids')
cube.setCutout(Nmap);
sprintf(paintFile)
save(paintFile,'cube','-v7.3')
