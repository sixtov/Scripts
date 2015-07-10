function seg = findSegmentsFromLogical(larray)
    K = length(larray);
    seg = [];
%     hold off
%     plot(larray)
%     hold all
%     ylim([-2 2]);
%     xlim([-100 length(larray)+100]);

    if (larray(1) == 1)
        fd = 1;
    else
        fd = 0;
    end
    darray = [fd; diff(larray)];
%     plot(darray,':.')
    sidx = find(darray ==  1);
    eidx = find(darray == -1);
    N = length(sidx);
    M = length(eidx);
    if (N ~= M)
        if (M > N) % eidx > sidx
            if (eidx(1) < sidx(1))
                if (eidx(1) == 1)
                    eidx = eidx(2:end);
                else
                    sidx = [1; sidx];
                end
            else
                eidx = eidx(1:end-1);
            end
        else        % sidx > eidx
            if (sidx(1) > eidx(1))
                sidx = sidx(2:end);
            else
                if (sidx(end) == K)
                    sidx = sidx(1:end-1);
                else
                    eidx = [eidx; K];
                end
            end
        end
    end
    sl = eidx-sidx;
    idx = find(sl);
    seg = [sidx(idx) eidx(idx)];
return


