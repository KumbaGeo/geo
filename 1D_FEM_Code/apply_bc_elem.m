function[ke,fe] = apply_bc_elem(ndof,nlink,elem,ke,fe,NODE)

for inod=1:nlink
    %rg = ndof*(elem.nodes(inod)-1) + 1;
    gi = elem.nodes(inod);
    re = ndof*(inod-1)+1;
    for idof=1:ndof
        %glob_row_ind = rg + (idof-1);
        loc_row_ind = re + (idof-1);
        if (NODE(gi).u_is_fixed(idof) == 1)
        %if (ifixu(glob_row_ind) == 1)
            for elmdof=1:(nlink*ndof)
                fe(elmdof) = fe(elmdof) - ke(elmdof,loc_row_ind)*NODE(gi).u(idof);
            end
            ke(loc_row_ind,1:(nlink*ndof)) = zeros(1,(nlink*ndof));
            ke(1:(nlink*ndof),loc_row_ind) = zeros(1,(nlink*ndof));
            ke(loc_row_ind,loc_row_ind) = 1.0;
            fe(loc_row_ind) = NODE(gi).u(idof);
        end
    end
end