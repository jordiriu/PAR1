classdef EMPTYARM
    properties 
        Arm %Defines which arm is empty.
        Id
    end
    methods (Static)
        function obj = EMPTYARM(arm)
            obj.Arm = arm;
            obj.Id = ['EMPTYARM(' arm '),'];
        end
        function operator = ADD(arm,Environment,StateVec,n,maxcolumnsnum)
            k = size(Environment,2); %Environment Vector Fila
            operator = {};
            if  (strcmp(arm,'Left')==1) 
                arm2= 'Right';
            else
                arm2 = 'Left';
            end
            if (strcmp(arm,'Right')==1)
                for i = 1:k
                    if(sum(strcmp(StateVec.Id,ONTABLE(Environment(i)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0)
                        operator = [operator {LEAVE(Environment(i),arm,n-1,maxcolumnsnum)}];
                    end
                    for j = 1:k
                        if (j~=i && sum(strcmp(StateVec.Id,ON(Environment(i),Environment(j)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,CLEAR(Environment(j)).Id))==0)
                            operator = [operator {STACK(Environment(i),Environment(j),arm)}];
                        end
                    end
                    if (sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm2).Id)==1) &&  sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && Environment(i).Weight == 1)
                        operator = [operator {SWAP(arm,Environment(i))}];
                    end
                end
            end
            if (strcmp(arm,'Left')==1)
                for i = 1:k
                    if(sum(strcmp(StateVec.Id,ONTABLE(Environment(i)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 && Environment(i).Weight == 1)
                        operator = [operator {LEAVE(Environment(i),arm,n-1,maxcolumnsnum)}];
                    end
                    for j = 1:k
                        if (j~=i && sum(strcmp(StateVec.Id,ON(Environment(i),Environment(j)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,CLEAR(Environment(j)).Id))==0 && Environment(i).Weight == 1)
                            operator = [operator {STACK(Environment(i),Environment(j),arm)}];
                        end
                    end
                    if (sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm2).Id)==1) &&  sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && Environment(i).Weight == 1)
                        operator = [operator {SWAP(arm,Environment(i))}];
                    end
                end
            end
        end
        
        function boolCheck = CHECK(emptyarm,Environment,StateVec)
            boolCheck = 0;
            for i = 1:size(Environment,2)
                if (sum(strcmp(StateVec.Id,HOLDING(Environment(i),emptyarm.Arm).Id))== 1)
                    boolCheck = 1;
                    break;
                end
            end
        end
    end
end