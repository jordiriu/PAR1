classdef STATE
    properties
        Predicates
        Id
        OrdId
    end
    methods (Static)
        function obj = STATE(Pred)
            %Pred is a cell that contains all current predicate classes of the
            %state. 
            obj.Predicates = Pred;
            obj.Id = {};
            n = size(Pred,2);
            for i = 1:n
                obj.Id =[obj.Id {Pred{i}.Id}];
            end
            cell = sort(obj.Id);
            obj.OrdId = [cell{:}];
        end
    end
end