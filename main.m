clear 
clc
close all
SearchAgents_no=30; 
Max_iteration=500; % Maximum number of iterations   
Function_name=1; %15设定测试函数，1-29.其中大于11的要维度大于10，参考cec2017文档指定的维度   
dim=100; %维度设定，维度可供选择范围[2,10,20,30,50,100]，其中Function_name>=11的最低维度设置为10.   
lb=-100;   
ub=100;   
fobj = @(x) cec20_func(x',Function_name);   
Max_test=30;   
 
for i=1:Max_test   
    disp(['第',num2str(i),'次实验开始']); 
    [Destination_position(i,:),Destination_fitness(i),Convergence_curve(i,:),VisitTable]=OPAHA(Max_iteration,SearchAgents_no,fobj,lb,ub,dim); 
    [Destination_position2(i,:),Destination_fitness5(i),HisBestFit(i,:),~]=AHA(lb,ub,dim,Max_iteration,SearchAgents_no,fobj);  
%     [Convergence(i,:),Score_best(i),X_best(i,:)]= E_WOA(SearchAgents_no,Max_iteration,dim,lb,ub,fobj);
%     [Xfood(i,:), fval(i),gbest_t(i,:),~,~, ~] = ESO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
%     [Alpha_score(i),Alpha_pos(i,:),Convergence_curve_GWO(i,:)]=IGWO(dim,SearchAgents_no,Max_iteration,lb,ub,fobj);
%     [Best_x1(i,:),Best_F1(i),Most_position1(i,:)]=FXXXAHA1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
%     [Best_x2(i,:),Best_F2(i),Most_position2(i,:)]=FXXXAHA1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
%     [Best_x3(i,:),Best_F3(i),Most_position3(i,:)]=FXXXAHA1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    VisitTable_all{i} = VisitTable;  % 将当前的 visitTable 存入 cell 数组   
end   
% %结果对比   
figure(1)   
   
semilogy(mean(Convergence_curve),'color','[0, 0, 1]','linewidth',2.0,'Marker','+','MarkerIndices',1:50:length(mean(Convergence_curve)))
hold on
semilogy(mean(HisBestFit),'color','[0, 1, 1]','linewidth',2.0,'Marker','x','MarkerIndices',1:50:length(mean(HisBestFit)))
% hold on
% semilogy(mean(Most_position2),'color','[1, 0, 1]','linewidth',2.0,'Marker','x','MarkerIndices',1:50:length(mean(Most_position2)))
% hold on
% semilogy(mean(Most_position3),'color','[1, 1, 0]','linewidth',2.0,'Marker','x','MarkerIndices',1:50:length(mean(Most_position3)))
% semilogy(mean(HisBestFit),'color','[0, 1, 1]','linewidth',2.0,'Marker','x','MarkerIndices',1:50:length(mean(HisBestFit)))
% hold on
% semilogy(mean(Convergence),'color','[0, 1, 0]','linewidth',2.0,'Marker','x','MarkerIndices',1:50:length(mean(Convergence)))
% hold on
% semilogy(mean(gbest_t),'color','[1, 0, 0]','linewidth',2.0,'Marker','x','MarkerIndices',1:50:length(mean(gbest_t)))
% hold on
% semilogy(mean(Convergence_curve_GWO),'color','[1, 1, 0]','linewidth',2.0,'Marker','x','MarkerIndices',1:50:length(mean(Convergence_curve_GWO)))
hold on

title(sprintf('Convergence curve of F{%d}', Function_name));  
xlabel('Iteration');
ylabel('Fitness');
axis tight 
grid off 
box on 
legend('OPAHA','AHA')

disp(['函数', num2str(Function_name), '实验开始']);
disp('-------------------------------------------------')
display(['OPAHA 30次实验最优适应度值(Best) : ', num2str(min(Destination_fitness))]);
display(['OPAHA 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Destination_fitness))]);
display(['OPAHA 30次实验最差适应度值(wrost) : ', num2str(max(Destination_fitness))]);
display(['OPAHA 30次实验标准差（std） : ', num2str(std(Destination_fitness))]);

% disp('-------------------------------------------------')
% display(['AHA1 30次实验最优适应度值(Best) : ', num2str(min(Best_F1))]);
% display(['AHA1 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Best_F1))]);
% display(['AHA1 30次实验最差适应度值(wrost) : ', num2str(max(Best_F1))]);
% display(['AHA1 30次实验标准差（std） : ', num2str(std(Best_F1))]);

% disp('-------------------------------------------------')
% display(['AHA2 30次实验最优适应度值(Best) : ', num2str(min(Best_F2))]);
% display(['AHA2 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Best_F2))]);
% display(['AHA2 30次实验最差适应度值(wrost) : ', num2str(max(Best_F2))]);
% display(['AHA2 30次实验标准差（std） : ', num2str(std(Best_F2))]);

% disp('-------------------------------------------------')
% display(['AHA3 30次实验最优适应度值(Best) : ', num2str(min(Best_F3))]);
% display(['AHA3 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Best_F3))]);
% display(['AHA3 30次实验最差适应度值(wrost) : ', num2str(max(Best_F3))]);
% display(['AHA3 30次实验标准差（std） : ', num2str(std(Best_F3))]);
% disp('-------------------------------------------------')
% display(['MTDE 30次实验最优适应度值(Best) : ', num2str(min(Best_score2))]);
% display(['MTDE 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Best_score2))]);
% display(['MTDE 30次实验最差适应度值(wrost) : ', num2str(max(Best_score2))]);
% display(['MTDE 30次实验标准差（std） : ', num2str(std(Best_score2))]);
% 
% disp('-------------------------------------------------')
% display(['EPSCAHA 30次实验最优适应度值(Best) : ', num2str(min(Destination_fitness2))]);
% display(['EPSCAHA 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Destination_fitness2))]);
% display(['EPSCAHA 30次实验最差适应度值(wrost) : ', num2str(max(Destination_fitness2))]);
% display(['EPSCAHA 30次实验标准差（std） : ', num2str(std(Destination_fitness2))]);
% 
% disp('-------------------------------------------------')
% display(['IGWO 30次实验最优适应度值(Best) : ', num2str(min(Alpha_score))]);
% display(['IGWO 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Alpha_score))]);
% display(['IGWO 30次实验最差适应度值(wrost) : ', num2str(max(Alpha_score))]);
% display(['IGWO 30次实验标准差（std） : ', num2str(std(Alpha_score))]);
% 
% % disp('-------------------------------------------------')
% % display(['CFOA 30次实验最优适应度值(Best) : ', num2str(min(Best_score))]);
% % display(['CFOA 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Best_score))]);
% % display(['CFOA 30次实验最差适应度值(wrost) : ', num2str(max(Best_score))]);
% % display(['CFOA 30次实验标准差（std） : ', num2str(std(Best_score))]);
% 
% % disp('-------------------------------------------------')
% % display(['SFOA 30次实验最优适应度值(Best) : ', num2str(min(best_fitness))]);
% % display(['SFOA 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(best_fitness))]);
% % display(['SFOA 30次实验最差适应度值(wrost) : ', num2str(max(best_fitness))]);
% % display(['SFOA 30次实验标准差（std） : ', num2str(std(best_fitness))]);
% 
disp('-------------------------------------------------')
display(['AHA 30次实验最优适应度值(Best) : ', num2str(min(Destination_fitness5))]);
display(['AHA 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Destination_fitness5))]);
display(['AHA 30次实验最差适应度值(wrost) : ', num2str(max(Destination_fitness5))]);
display(['AHA 30次实验标准差（std） : ', num2str(std(Destination_fitness5))]);
% 
% disp('-------------------------------------------------')
% display(['EWOA 30次实验最优适应度值(Best) : ', num2str(min(Score_best))]);
% display(['EWOA 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Score_best))]);
% display(['EWOA 30次实验最差适应度值(wrost) : ', num2str(max(Score_best))]);
% display(['EWOA 30次实验标准差（std） : ', num2str(std(Score_best))]);
% 
% disp('-------------------------------------------------')
% display(['ESO 30次实验最优适应度值(Best) : ', num2str(min(fval))]);
% display(['ESO 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(fval))]);
% display(['ESO 30次实验最差适应度值(wrost) : ', num2str(max(fval))]);
% display(['ESO 30次实验标准差（std） : ', num2str(std(fval))]);
% 
% disp('-------------------------------------------------')
% display(['IGWO 30次实验最优适应度值(Best) : ', num2str(min(Alpha_score))]);
% display(['IGWO 30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(Alpha_score))]);
% display(['IGWO 30次实验最差适应度值(wrost) : ', num2str(max(Alpha_score))]);
% display(['IGWO 30次实验标准差（std） : ', num2str(std(Alpha_score))]);


  
%% 整理数据供箱线图使用  
% boxplot_data = [Destination_fitness', Score_best', fval', Alpha_score'];  
% 每个算法的适应度作为一列，确保所有适应度数据的维度匹配  

% 生成箱线图  
% figure(2);  
% boxplot(boxplot_data, 'Labels', {'OPAHA', 'EWOA', 'ESO', 'IGWO'});  
% title(sprintf('箱线图：适应度值分布 F{%d}', Function_name));  % 更新标题 
% ylabel('适应度值');  
% grid on;  