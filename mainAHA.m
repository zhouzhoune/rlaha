
clc;
clear;
Tmax=1000;
nPop=30;
RUN_NO=20; % 每个实验跑多少次取平均值
Fun_id=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
%% 根据cec的取值，来选择不同的测试函数集  
fhd=str2func('cec20_func'); 
cec=3;
if cec==1 %% CEC-2014
    fhd=str2func('cec14_func');
    benchmarksType='cec14_func';  
elseif cec==2 %% CEC-2017   一半跑到临近最优
    fhd=str2func('cec17_func');
    benchmarksType='cec17_func';
elseif cec==3 %% CEC-2020  基本跑到最优值
    fhd=str2func('cec20_func');
    benchmarksType='cec20_func';
elseif cec==4 %% CEC-2022
    fhd=str2func('cec22_func');
    benchmarksType='cec22_func';
end
%%

for i=[1:10]                                                       % 表示第几个函数
tic
  for j=1:RUN_NO                                                            % 控制函数的运行次数，然后取平均值
  if cec==2 && i==2                                                        % 对函数执行进行控制，
       continue;
  elseif cec==3 && i>10
       return
  elseif cec==4 && i>12
       return
  
  end
  fobj=Fun_id(i); 
  [lb,ub,dim]=Get_Functions_detailsCEC(fobj);                         % 从Get_Functions_detailsCEC中获取维度信息                                                         % 此时fobj表示1-30
 [BestX,BestF,HisBestFit,VisitTable]=AHA(Tmax,nPop,fobj,lb,ub,dim,fhd);
  fitness(i,j)=BestF;
  end
  min(fitness(i,:))
  std(fitness(i,:))
  max(fitness(i,:))
 toc
 fprintf(['benchmark   \t',num2str(cec),'\t','Function_ID\t',num2str(i),'\tAverage Fitness:',num2str(mean(fitness(i,:)),20),'\n']);

end












