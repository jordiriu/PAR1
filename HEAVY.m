classdef HEAVY
    properties 
        Heavy
        Light
        Id
    end
    methods (Static)
        function obj = HEAVY(h,l)
            obj.Heavy = h;
            obj.Light = l;
            obj.Id = ['HEAVY' h.Name l.Name];
        end
    end
end