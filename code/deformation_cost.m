function cost = deformation_cost(L1, L2, w)
    L1(4) = log(L1(4)); %log(scale)
    L2(4) = log(L2(4)); %log(scale)
    cost = abs(L1-L2)*w';
end