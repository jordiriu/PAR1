classdef LIGHTBLOCK
    properties
        Block %BlockIdentifier
        Id
    end
    methods (Static)
        function obj = LIGHTBLOCK(block)
            obj.Block = block;
            obj.Id = ['LIGHTBLOCK' block.Name]; %Crear metode per lightblock
        end
    end
end