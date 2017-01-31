function stick = location2Stick(l, part)
model_len=[160, 95,95,65,65,60];
if part == 1 || part == 6
    x1 = l(1) - model_len(part)*l(4)*sin(l(3))/2;
    x2 = l(1) + model_len(part)*l(4)*sin(l(3))/2;
    y1 = l(2) + model_len(part)*l(4)*cos(l(3))/2;
    y2 = l(2) - model_len(part)*l(4)*cos(l(3))/2;
else
    x1 = l(1) + model_len(part)*l(4)*cos(l(3))/2;
    x2 = l(1) - model_len(part)*l(4)*cos(l(3))/2;
    y1 = l(2) + model_len(part)*l(4)*sin(l(3))/2;
    y2 = l(2) - model_len(part)*l(4)*sin(l(3))/2;
end

stick = [x1, y1, x2, y2];