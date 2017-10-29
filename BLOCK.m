classdef BLOCK
    properties
        Name
        Weight
    end
    methods (Static)
        function obj = BLOCK(str)
            obj.Name = str(1);
            obj.Weight = size(str(2:end),2);
        end
    end
end
        