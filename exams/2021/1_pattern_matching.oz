
declare proc {Insert Key Value TreeIn ?TreeOut}
    case TreeIn
    of nil then
    //if TreeIn == nil then
        TreeOut = tree(Key Value nil nil)
    //else
    [] tree(K1 V1 T1 T2) then
        //local tree(K1 V1 T1 T2) = TreeIn in
        if Key == K1 then
            TreeOut = tree(Key Value T1 T2)
        elseif Key < K1 then T in
            TreeOut = tree(K1 V1 T T2)
            {Insert Key Value T1 T}
        else T in
            TreeOut = tree(K1 V1 T1 T)
            {Insert Key Value T2 T}
        end
    end
end
