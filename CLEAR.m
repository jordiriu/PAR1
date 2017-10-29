classdef CLEAR
    properties
        Block %Block Identified
        Id
    end
    methods (Static)
        function obj = CLEAR(Block) % Function that creates a Clear variable.
            if nargin==1
                obj.Block = Block;
                obj.Id = ['CLEAR(' Block.Name '),'];
            else
                error('Invalid Block')
            end
        return
        end
        function operator = ADD(cclear,Environment,StateVec)
            k = size(Environment,2);
            operator = {};
            for i = 1:k
                TopBlock = Environment(i);
                if (TopBlock.Name ~= cclear.Block.Name && TopBlock.Weight <= cclear.Block.Weight &&  sum(strcmp(StateVec.Id,HOLDING(TopBlock,'Right').Id))==1 &&  sum(strcmp(StateVec.Id,EMPTYARM('Right').Id))==0 &&  sum(strcmp(StateVec.Id,ON(TopBlock,cclear.Block).Id))==0) 
                    operator = [operator {UNSTACK(Environment(i),cclear.Block,'Right')}];
                end
                if (TopBlock.Name ~= cclear.Block.Name && TopBlock.Weight == 1 && sum(strcmp(StateVec.Id,HOLDING(TopBlock,'Left').Id))==1 &&  sum(strcmp(StateVec.Id,EMPTYARM('Left').Id))==0 &&  sum(strcmp(StateVec.Id,ON(TopBlock,cclear.Block).Id))==0)
                        operator = [operator {UNSTACK(Environment(i),cclear.Block,'Left')}]; 
                end
            end
        end
        function boolCheck = CHECK(cclear,Environment,StateVec)
            boolCheck = 0;
            for i = 1:size(Environment,2)
                if(sum(strcmp(StateVec.Id,ON(Environment(i),cclear.Block).Id))== 1)
                    boolCheck = 1;
                    break;
                end
            end
        end
    end
end
