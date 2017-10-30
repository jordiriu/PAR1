classdef HOLDING
    properties
        Block % Block Identifier
        Arm % Defines the arm holding Block
        Id
    end
    methods (Static)
        function obj = HOLDING(block,arm)
            obj.Block = block;
            obj.Arm = arm;
            obj.Id = ['HOLDING(' block.Name ',' arm '),'];
        end
        function operator = ADD(block,arm,Environment,StateVec,n,maxcolumnsnum)
            k = size(Environment,2); %Environment Vector Fila
            operator = {};
            if  (strcmp(arm,'Left') == 1) 
                arm2= 'Right';
                            
                if(n<maxcolumnsnum && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ONTABLE(block).Id))==0 && block.Weight == 1)
                    operator = [operator {PICKUP(block,arm,n+1)}];
                end
                if(sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(block,arm2).Id))==0 && sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && block.Weight == 1)
                    operator = [operator {SWAP(arm2,block)}];
                end
                
                for i = 1:k
                    BottomBlock = Environment(i);
                    if (strcmp(Environment(i).Name,block.Name)==0 && block.Weight == 1 && sum(strcmp(StateVec.Id,CLEAR(BottomBlock).Id))==1 && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ON(block,BottomBlock).Id))==0)
                        operator = [operator {UNSTACK(block,BottomBlock,arm)}];
                    end
                end
            else
                arm2 = 'Left';
                 if(n<maxcolumnsnum && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ONTABLE(block).Id))==0)
                    operator = [operator {PICKUP(block,arm,n+1)}];
                end
                if(sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(block,arm2).Id))==0 && sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && block.Weight == 1)
                    operator = [operator {SWAP(arm2,block)}];
                end
                
                for i = 1:k
                    BottomBlock = Environment(i);
                    if (strcmp(Environment(i).Name,block.Name)==0 && block.Weight <= BottomBlock.Weight && sum(strcmp(StateVec.Id,CLEAR(BottomBlock).Id))==1 && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ON(block,BottomBlock).Id))==0)
                        operator = [operator {UNSTACK(block,BottomBlock,arm)}];
                    end
                end
            end

            
        end
        function boolCheck = CHECK(holding,Environment,StateVec)
            boolCheck = 0;
            if (sum(strcmp(StateVec.Id,CLEAR(holding.Block).Id))==0)
                boolCheck = 1;
            end
            if (strcmp(holding.Arm, 'Left') == 1 && holding.Block.Weight > 1)
                boolCheck = 1;
            end
            if (sum(strcmp(StateVec.Id,EMPTYARM(holding.Arm).Id))==1)
                boolCheck = 1;
            end
            for i = 1: size(Environment,2)
                if (sum(strcmp(StateVec.Id,ON(Environment(i),holding.Block).Id))==1 || sum(strcmp(StateVec.Id,ON(holding.Block,Environment(i)).Id))==1)
                    boolCheck = 1;
                    break;
                end
                if (strcmp(Environment(i).Name,holding.Block.Name)==0 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),holding.Arm).Id))==1)
                    boolCheck = 1;
                end
            end
        end
    end
end
