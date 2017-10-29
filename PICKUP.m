classdef PICKUP
    properties
        Block
        Arm
        Add
        Del
        Prec
        Id
    end
    methods (Static)
        function obj = PICKUP(block,arm,n)
                obj.Block = block;
                obj.Arm = arm;
                obj.Id = ['PICKUP(' block.Name ',' arm ')'];
                if (strcmp(arm,'LEFT'))
                    obj.Add = {HOLDING(block,arm) USEDCOLSNUM(n-1)};
                    obj.Del = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};
                    obj.Prec = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};% LIGHTBLOCK(block) 
                else
                    obj.Add = {HOLDING(block,arm) USEDCOLSNUM(n-1)};
                    obj.Del = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};
                    obj.Prec = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};
                end
        end
    end
end