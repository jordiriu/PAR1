classdef ON
    properties 
        Top% Top block.
        Bot% Bottom block.
        Id
    end
    methods (Static)
        function obj = ON(top,bot)
            obj.Top = top;
            obj.Bot = bot;
            obj.Id = ['ON(' top.Name ',' bot.Name '),'];
        end
        function operator = ADD(top,bot,StateVec)
            operator = {};
            if(sum(strcmp(StateVec.Id,EMPTYARM('Right').Id))==1 && sum(strcmp(StateVec.Id,CLEAR(bot).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(top,'Right').Id))==0)
                operator = [operator {STACK(top,bot,'Right')}];
            end
            if (sum(strcmp(StateVec.Id,EMPTYARM('Left').Id))==1 && sum(strcmp(StateVec.Id,CLEAR(bot).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(top,'Left').Id))==0 && top.Weight == 1)
                operator = [operator {STACK(top,bot,'Left')}];
            end
            
        end
        function boolCheck = CHECK(on,Environment,StateVec)
            boolCheck = 0;
            if (sum(strcmp(StateVec.Id,ONTABLE(on.Top).Id))==1)
                boolCheck = 1;
            end
            if (sum(strcmp(StateVec.Id,CLEAR(on.Bot).Id))== 1)
                boolCheck = 1;
            end
            if (on.Top.Weight > on.Bot.Weight)
                boolCheck = 1;
            end
            if(sum(strcmp(StateVec.Id,HOLDING(on.Top,'Left').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(on.Top,'Right').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(on.Bot,'Left').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(on.Bot,'Right').Id))==1)
                boolCheck = 1;
            end
            for i = 1:size(Environment,2)
                NewBlock = Environment(i);
                if (sum(strcmp(StateVec.Id,ON(NewBlock,on.Bot).Id))== 1 && strcmp(NewBlock.Name,on.Top.Name)== 0)
                    boolCheck = 1;
                    break;
                end
                if (sum(strcmp(StateVec.Id,ON(on.Top,NewBlock).Id))== 1 && strcmp(NewBlock.Name,on.Bot.Name)== 0)
                    boolCheck = 1;
                    break;
                end
                 
            end
        end
    end
end