classdef UNSTACK
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
        function obj = UNSTACK(top,bot,arm)
                obj.Id = ['UNSTACK(' top.Name ',' bot.Name ',' arm ')'];
                obj.Top = top;
                obj.Bot = bot;
                obj.Arm = arm;
                if (strcmp(arm,'Left')==1)
                    obj.Add = {HOLDING(top,arm) CLEAR(bot)};
                    obj.Del = {EMPTYARM(arm) ON(top,bot)};
                    obj.Prec = {EMPTYARM(arm) ON(top,bot) CLEAR(top)};% LIGHTBLOCK(top)};
                else
                    obj.Add = {HOLDING(top,arm) CLEAR(bot)};
                    obj.Del = {EMPTYARM(arm) ON(top,bot)};
                    obj.Prec = {EMPTYARM(arm) ON(top,bot) CLEAR(top)};
                end
        end
    end
end