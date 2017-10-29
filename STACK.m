classdef STACK
    properties
        Top
        Bot
        Arm
        Add
        Del
        Prec
        Id
    end
    methods (Static)
        function obj = STACK(top,bot,arm)
                obj.Id = ['STACK(' top.Name ',' bot.Name ',' arm ')'];
                obj.Top = top;
                obj.Bot = bot;
                obj.Arm = arm;
                obj.Add = {ON(top,bot) EMPTYARM(arm)};
                obj.Del = {CLEAR(bot) HOLDING(top,arm)};
                obj.Prec = {CLEAR(bot) HOLDING(top,arm)};% HEAVY(bot,top)};

        end
    end
end