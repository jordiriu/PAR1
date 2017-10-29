classdef ONTABLE
    properties 
        Block % Block Identifier.
        Id
    end
    methods (Static)
        function obj = ONTABLE(block)
            obj.Block = block;
            obj.Id = ['ONTABLE(' block.Name '),'];
        end
        function operator = ADD(block,StateVec,n,maxcolumnsnum)
            operator = {};
            if (sum(strcmp(StateVec.Id,EMPTYARM('Right').Id))==1 && sum(strcmp(StateVec.Id,HOLDING(block,'Right').Id))==0)
                operator = [operator {LEAVE(block,'Right',n-1,maxcolumnsnum)}];
            end
            if (sum(strcmp(StateVec.Id,EMPTYARM('Left').Id))==1 && sum(strcmp(StateVec.Id,HOLDING(block,'Left').Id))==0 && block.Weight == 1)
                operator = [operator {LEAVE(block,'Left',n-1,maxcolumnsnum)}];
            end 
        end
        function boolCheck = CHECK(ontable,Environment,StateVec)
            boolCheck = 0;
            if (sum(strcmp(StateVec.Id,HOLDING(ontable.Block,'Left').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(ontable.Block,'Right').Id))==1)
                boolCheck = 1;
            end
            for i = 1:size(Environment,2)
                if(sum(strcmp(StateVec.Id,ON(ontable.Block,Environment(i)).Id))==1)
                    boolCheck = 1;
                    break;
                end
            end    
        end
    end
end