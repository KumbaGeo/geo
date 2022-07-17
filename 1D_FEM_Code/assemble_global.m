function[I,J,V,fext,next] = assemble_global(nlink,ndof,elem,I,J,V,fext,ke,fe,next)

for jnod=1:nlink
    cbk_diag = ndof*(elem.nodes(jnod)-1) + 1;
    ce = ndof*(jnod-1)+1;
    for inod=1:nlink
        rg = ndof*(elem.nodes(inod)-1) + 1;
        re = ndof*(inod-1)+1;
        for idof=1:ndof
            glob_row_ind = rg + (idof-1);
            loc_row_ind = re + (idof-1);
            for jdof=1:ndof
                glob_col_ind = cbk_diag + (jdof-1);
                loc_col_ind = ce + (jdof-1);
                I(next+1) = glob_row_ind; J(next+1) = glob_col_ind;
                V(next+1) = ke(loc_row_ind,loc_col_ind);
                next = next+1;
            end
        end
    end
    %%%%%%%% Assemble global force vector %%%%%%%%%%%%
    fext(cbk_diag:(cbk_diag+ndof-1)) = fext(cbk_diag:(cbk_diag+ndof-1)) + fe(ce:(ce+ndof-1));
end
