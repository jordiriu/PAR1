classdef USEDCOLSNUM
    properties
        Num
        Id
    end
    methods  (Static)
        function obj = USEDCOLSNUM(num)
            obj.Num = num;
            obj.Id = ['USEDCOLSNUM' num2str(num)];
        end
    end
end
           