clear all;
close all;
clc;
fileID = fopen('test.txt','r');
[maxcolumnsnum,Environment,initialstate,finalstate]=ReadFile(fileID);
fclose(fileID);
k = size(Environment,2);
endflag = 0;
sfinal = STATE(finalstate);
sinitial = STATE(initialstate);
visitedstates = {sfinal};
oldstates = {sfinal};
newstates = {};
oldplanM = {'Final State'};
newplanM = {};
plans = {'Final State'};

while (endflag==0)
    for d = 1:size(oldstates,2)
        sfinal = oldstates{d};
        for w = 1:size(sfinal.Predicates,2)
            if(strcmp(class(sfinal.Predicates{w}),'USEDCOLSNUM')==1)
                n = sfinal.Predicates{w}.Num;
            end
        end
        predsize = size(sfinal.Predicates,2);
        opused = {};
        oldplan = oldplanM{d};

        for j = 1:predsize
            pred = sfinal.Predicates{j};
            oppred = {};
            switch class(pred)
                
                case 'CLEAR'
                    %disp('CLEAR')
                    operators = pred.ADD(pred,Environment,sfinal);
                case 'ON'
                    %disp('ON')
                    operators = pred.ADD(pred.Top,pred.Bot,sfinal);
                case 'ONTABLE'
                    %disp('ONTABLE')
                    operators = pred.ADD(pred.Block,sfinal,n,maxcolumnsnum);
                case 'EMPTYARM'
                    %disp('EA')
                    operators = pred.ADD(pred.Arm,Environment,sfinal,n,maxcolumnsnum);
                case 'HOLDING'
                    operators = pred.ADD(pred.Block,pred.Arm,Environment,sfinal,n,maxcolumnsnum);
                case 'HEAVY'
                    operators = {};
                case 'USEDCOLSNUM'
                    operators = {};
                case 'LIGHTBLOCK'
                    operators = {};
            end
            
            for i = 1:size(operators,2)
                if (size(opused,2)>0)
                    for h = 1:size(opused,2)
                        if (strcmp(operators{i}.Id,opused)== 0)
                            opused = [opused {operators{i}.Id}];
                            oppred = [oppred operators(i)];
                        end
                    end
                else
                    opused = [opused {operators{i}.Id}];
                    oppred = [oppred operators(i)];
                end
                
            end
            for i = 1:size(oppred,2) %Provem operador per operador si hi ha incongroències.
                operator = oppred{i};
                newpredicates={};
                flag = 0;
                regfun = {};
                for q  = 1:size(sfinal.Predicates,2)
                    predcandidate = sfinal.Id{q};
                    [addbool,delbool,precbool] = COMPARE(predcandidate,operator.Add,operator.Del,operator.Prec);
                    if (addbool == 1)
                        continue;
                    elseif (delbool ==1)
                        flag = 1;
                        break;
                    elseif (precbool == 0)
                        regfun = [regfun {sfinal.Predicates{q}}];
                    end
                end
                
                if (flag == 0)
                    regfun = [regfun operator.Prec];
                    trialState = STATE(regfun);
                    for z = 1:size(regfun,2)
                        if (strcmp(class(regfun{z}),'LIGHTBLOCK') == 0  && strcmp(class(regfun{z}),'HEAVY') == 0 && strcmp(class(regfun{z}),'USEDCOLSNUM') == 0)
                            flag = regfun{z}.CHECK(regfun{z},Environment,trialState);
                            if (flag == 1)
                                break;
                            end
                        end
                        if(strcmp(class(regfun{z}),'USEDCOLSNUM') == 1)
                            if(regfun{z}.Num>maxcolumnsnum)
                                flag == 1;
                                break;
                            end
                        end
                    end
                end
                
                if (flag == 0)
                    acceptbool = 1;
                    
                    for v = 1:size(visitedstates,2)
                        if (strcmp(visitedstates{v}.OrdId,trialState.OrdId)==1)
                            acceptbool = 0;
                            break;
                        end
                    end
                    if (acceptbool == 1)
                        if (strcmp(sinitial.OrdId,trialState.OrdId)==1)
                            endflag = size(visitedstates,2)+1;
                        end
                        newstates = [newstates {trialState}];
                        visitedstates = [visitedstates {trialState}];
                        newplan = [oldplan {operator.Id}];
                        newplanM = [newplanM {newplan}];
                        plans = [plans {newplan}];
                    end
                end
                
            end
        end
    end
    oldstates = newstates;
    newstates = {};
    oldplanM = newplanM;
    newplanM = {};
end