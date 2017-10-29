classdef SWAP 
    properties
        Block
        Arm
        Add
        Del
        Prec
        Id
    end
    methods (Static)
        function obj = SWAP(arm,block)
            obj.Id = ['SWAP(' block.Name ',' arm ')'];
            obj.Arm = arm;
            obj.Block = block;
            if (strcmp(arm,'Left')==1)
                arm2 = 'Right';
                obj.Prec = {EMPTYARM(arm2), HOLDING(block,arm)};
            else
                arm2 = 'Left';
                obj.Prec = {EMPTYARM(arm2), HOLDING(block,arm)};%, LIGHTBLOCK(block)};
            end
            obj.Add = {HOLDING(block,arm2) EMPTYARM(arm)};
            obj.Del = {HOLDING(block,arm) EMPTYARM(arm2)};
        end
    end
end
            