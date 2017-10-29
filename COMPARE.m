function [add,del,prec] = COMPARE(pred,AddList,DelList,PrecList)
            add = 0;
            del = 0;
            prec = 0;
            for k = 1:size(AddList,2);
                if (strcmp(pred,AddList{k}.Id))
                    add = 1;
                    break;
                end
            end
            for k = 1:size(DelList,2)
                if strcmp(pred,DelList{k}.Id)
                    del = 1;
                    break;
                end
            end
            for k = 1:size(PrecList,2)
                if strcmp(pred,PrecList{k}.Id)
                    prec = 1;
                    break;
                end
            end
return;            
end