function [coor L] = Pose(Ltorso, part, seq)

if part == 6
    w = [0.5 0.5 100 100];
else 
    w = [0.5 0.5 100 100];
end


model_len=[160, 95, 95, 65, 65, 60];
xt = Ltorso(1);
yt = Ltorso(2);
st = Ltorso(4);

Bx = linspace(xt-model_len(1)*st,     xt+model_len(1)*st, 50);
By = linspace(yt-model_len(1)*st*1.5, yt+model_len(1)*st*0.5, 50);
Bs = linspace(-1, 1, 10);
Bt = linspace(-pi/2, pi/2, 20);

Lx = length(Bx);
Ly = length(By);
Ls = length(Bs);
Lt = length(Bt);

cost = [];
for i = 1:Lx
    L = [Bx(i) By(Ly/2) Bt(Lt/2) Bs(Ls/2)];
    cost = [cost match_energy_cost(L,part,seq)+deformation_cost(Ltorso, L, w)];
end
[~, Ix] = min(cost);
x = Bx(Ix);

cost = [];
for i = 1:Ly
    L = [x By(i) Bt(Lt/2) Bs(Ls/2)];
    cost = [cost match_energy_cost(L,part,seq)+deformation_cost(Ltorso, L, w)];
end
[~, Iy] = min(cost);
y = By(Iy);

cost = [];
for i = 1:Lt
    L = [x y Bt(i) Bs(Ls/2)];
    cost = [cost match_energy_cost(L,part,seq)+deformation_cost(Ltorso, L, w)];
end
[~, It] = min(cost);
theta = Bt(It);

cost = [];
for i = 1:Ls
    L = [x y theta Bs(i)];
    cost = [cost match_energy_cost(L,part,seq)+deformation_cost(Ltorso, L, w)];
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
x1 = (model_len(part)*scale / sqrt(tan(theta)^2+1) + 2*x)/2;
x2 = (-model_len(part)*scale / sqrt(tan(theta)^2+1) + 2*x)/2;
y1 = (tan(theta)*(x1-x2) + 2*y)/2;
y2 = (-tan(theta)*(x1-x2) + 2*y)/2;

coor = [x1 y1 x2 y2];
