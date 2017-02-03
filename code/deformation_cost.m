function cost = deformation_cost(L1, L2, w, p1, p2)
    if p1 > p2
        tmp = L1;
        L1 = L2;
        L2 = tmp;
        tmp = p1;
        p1 = p2;
        p2 = tmp;
    end
    
    s1 = location2Stick(L1, p1);
    s2 = location2Stick(L2, p2);
    
    s11 = [s1(1), s1(2)];
    s12 = [s1(3), s1(4)];
    s21 = [s2(1), s2(2)];
    s22 = [s2(3), s2(4)];
    
    L1(1:2) = s11;
    L2(1:2) = s21;
    
    mindis = norm(s11-s21);
    if mindis > norm(s11-s22)
        mindis = norm(s11-s22);
        L1(1:2) = s11;
        L2(1:2) = s22;
    end
    if mindis > norm(s12-s21)
        mindis = norm(s12-s21);
        L1(1:2) = s12;
        L2(1:2) = s21;
    end
    if mindis > norm(s12-s22)
        L1(1:2) = s12;
        L2(1:2) = s22;
    end
    
    
    if p1 == 1
        if L1(3) > 0
            L1(3) = L1(3) - pi / 2;
        else
            L1(3) = L1(3) + pi / 2;
        end
    end
    if p2 == 6
        if L2(3) > 0
            L2(3) = L2(3) - pi / 2;
        else
            L2(3) = L2(3) + pi / 2;
        end
    end

    L1(4) = log(L1(4)); %log(scale)
    L2(4) = log(L2(4)); %log(scale)
    cost = abs(L1-L2)*w';
end