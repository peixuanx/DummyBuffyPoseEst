function cost = pairwise_cost( l1, l2, p1, p2 )
if p1 > p2
    tmp = l1;
    l1 = l2;
    l2 = tmp;
    tmp = p1;
    p1 = p2;
    p2 = tmp;
end

cost = 0;
if p1 ~= 1
    cost = 0;
elseif p2 == 2 || p2 == 3 || p2 == 6
    torso = location2Stick(l1, p1);
    stick = location2Stick(l2, p2);
    
    torso1 = [torso(1), torso(2)];
    torso2 = [torso(3), torso(4)];
    point1 = [stick(1), stick(2)];
    point2 = [stick(3), stick(4)];
    
    cost = min( [norm(torso1-point1), norm(torso1-point2), norm(torso2-point1), norm(torso2-point2)] );
end

