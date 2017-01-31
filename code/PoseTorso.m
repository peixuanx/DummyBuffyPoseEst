function [coor L] = PoseTorso(maxx, maxy, seq)
% dummy routine generating stickman (it always generate the same one just scaled and shifted according to the bounding box)
% Input 
%   img - input image
%   det_bb - detection bouding box [minx miny maxx maxy]
%
% Output
%   coor - stickman coordinates coor(:,n) = [x1 y1 x2 y2]' in the following order: 
%          torso, left upper arm, right upper arm, left lower arm, right lower arm, head

part = 1;
%1=torso, 2=left upper arm, 3=right upper arm, 4=left lower arm, 5=right lower arm, 6= head

Bx = linspace(1, maxx, 50);
By = linspace(1, maxy, 50);
Bs = linspace(-1, 1, 10);
Bt = linspace(-pi/2, pi/2, 20);

Lx = length(Bx);
Ly = length(By);
Ls = length(Bs);
Lt = length(Bt);

cost = [];
for i = 1:Lx
    L = [Bx(i) By(Ly/2) Bt(Lt/2) Bs(Ls/2)];
    cost = [cost match_energy_cost(L,part,seq)];
end
[~, Ix] = min(cost);
x = Bx(Ix);

cost = [];
for i = 1:Ly
    L = [x By(i) Bt(Lt/2) Bs(Ls/2)];
    cost = [cost match_energy_cost(L,part,seq)];
end
[~, Iy] = min(cost);
y = By(Iy);

cost = [];
for i = 1:Lt
    L = [x y Bt(i) Bs(Ls/2)];
    cost = [cost match_energy_cost(L,part,seq)];
end
[~, It] = min(cost);
theta = Bt(It);

cost = [];
for i = 1:Ls
    L = [x y theta Bs(i)];
    cost = [cost match_energy_cost(L,part,seq)];
end
[~, Is] = min(cost);
scale = Bs(Is);

if part==1 | part ==6
    if theta<0
        theta=theta+pi/2;
    else
        theta=theta-pi/2;
    end
end

L = [x y theta scale];
model_len=[160, 95, 95, 65, 65, 60];
x1 = (model_len(part)*scale / sqrt(tan(theta)^2+1) + 2*x)/2;
x2 = (-model_len(part)*scale / sqrt(tan(theta)^2+1) + 2*x)/2;
y1 = (tan(theta)*(x1-x2) + 2*y)/2;
y2 = (-tan(theta)*(x1-x2) + 2*y)/2;

coor = [x1 y1 x2 y2];