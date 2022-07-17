function [NODE,ELEM,PARAMS] = create_data_structures(x,T,f1,f2)

PARAMS = struct('nlink', 2, 'ndof', 1, 'Xmin', min(x), 'Xmax', max(x));

NODE(length(x)) = struct('X', [], 'u_is_fixed', [], 'u', []);
for inod=1:length(x)
    NODE(inod).X = x(inod);

    NODE(inod).u = 0; NODE(inod).u_is_fixed = 0;
end

ELEM((length(x)-1)) = struct('nodes', [], 'length', [], 'E', [], ...
    'gradN', [], 'N', [], 'jcob', [], 'body_force', []);
for ielem=1:length(ELEM)
    ELEM(ielem).T = T;
    ELEM(ielem).nodes = [ielem, ielem+1];
    ELEM(ielem).center = mean([NODE(ELEM(ielem).nodes(2)).X, NODE(ELEM(ielem).nodes(1)).X]);
    
    if(ELEM(ielem).center>mean([PARAMS.Xmin, PARAMS.Xmax]))
        ELEM(ielem).body_force = f2;
    else
        ELEM(ielem).body_force = f1;
    end

    ELEM(ielem).length = NODE(ELEM(ielem).nodes(2)).X - NODE(ELEM(ielem).nodes(1)).X;
    ELEM(ielem).n_gp = 2;
    [ELEM(ielem).N,ELEM(ielem).jcob] = get_N(x(ELEM(ielem).nodes));
    ELEM(ielem).gradN = (1/ELEM(ielem).length)*[-1 1];
end

end