clear 
clc
close all
SearchAgents_no=30; 
Max_iteration=500; % Maximum number of iterations   
Function_name=1; %15�趨���Ժ�����1-29.���д���11��Ҫά�ȴ���10���ο�cec2017�ĵ�ָ����ά��   
dim=100; %ά���趨��ά�ȿɹ�ѡ��Χ[2,10,20,30,50,100]������Function_name>=11�����ά������Ϊ10.   
lb=-100;   
ub=100;   
fobj = @(x) cec20_func(x',Function_name);   
Max_test=30;   
 
for i=1:Max_test   
    disp(['��',num2str(i),'��ʵ�鿪ʼ']); 
    [Destination_position(i,:),Destination_fitness(i),Convergence_curve(i,:),VisitTable]=OPAHA(Max_iteration,SearchAgents_no,fobj,lb,ub,dim); 
    [Destination_position2(i,:),Destination_fitness5(i),HisBestFit(i,:),~]=AHA(lb,ub,dim,Max_iteration,SearchAgents_no,fobj);  
%     [Convergence(i,:),Score_best(i),X_best(i,:)]= E_WOA(SearchAgents_no,Max_iteration,dim,lb,ub,fobj);
%     [Xfood(i,:), fval(i),gbest_t(i,:),~,~, ~] = ESO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
%     [Alpha_score(i),Alpha_pos(i,:),Convergence_curve_GWO(i,:)]=IGWO(dim,SearchAgents_no,Max_iteration,lb,ub,fobj);
%     [Best_x1(i,:),Best_F1(i),Most_position1(i,:)]=FXXXAHA1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
%     [Best_x2(i,:),Best_F2(i),Most_position2(i,:)]=FXXXAHA1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
%     [Best_x3(i,:),Best_F3(i),Most_position3(i,:)]=FXXXAHA1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    VisitTable_all{i} = VisitTable;  % ����ǰ�� visitTable ���� cell ����   
end   
% %����Ա�   
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

disp(['����', num2str(Function_name), 'ʵ�鿪ʼ']);
disp('-------------------------------------------------')
display(['OPAHA 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Destination_fitness))]);
display(['OPAHA 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Destination_fitness))]);
display(['OPAHA 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Destination_fitness))]);
display(['OPAHA 30��ʵ���׼�std�� : ', num2str(std(Destination_fitness))]);

% disp('-------------------------------------------------')
% display(['AHA1 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Best_F1))]);
% display(['AHA1 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Best_F1))]);
% display(['AHA1 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Best_F1))]);
% display(['AHA1 30��ʵ���׼�std�� : ', num2str(std(Best_F1))]);

% disp('-------------------------------------------------')
% display(['AHA2 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Best_F2))]);
% display(['AHA2 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Best_F2))]);
% display(['AHA2 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Best_F2))]);
% display(['AHA2 30��ʵ���׼�std�� : ', num2str(std(Best_F2))]);

% disp('-------------------------------------------------')
% display(['AHA3 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Best_F3))]);
% display(['AHA3 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Best_F3))]);
% display(['AHA3 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Best_F3))]);
% display(['AHA3 30��ʵ���׼�std�� : ', num2str(std(Best_F3))]);
% disp('-------------------------------------------------')
% display(['MTDE 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Best_score2))]);
% display(['MTDE 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Best_score2))]);
% display(['MTDE 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Best_score2))]);
% display(['MTDE 30��ʵ���׼�std�� : ', num2str(std(Best_score2))]);
% 
% disp('-------------------------------------------------')
% display(['EPSCAHA 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Destination_fitness2))]);
% display(['EPSCAHA 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Destination_fitness2))]);
% display(['EPSCAHA 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Destination_fitness2))]);
% display(['EPSCAHA 30��ʵ���׼�std�� : ', num2str(std(Destination_fitness2))]);
% 
% disp('-------------------------------------------------')
% display(['IGWO 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Alpha_score))]);
% display(['IGWO 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Alpha_score))]);
% display(['IGWO 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Alpha_score))]);
% display(['IGWO 30��ʵ���׼�std�� : ', num2str(std(Alpha_score))]);
% 
% % disp('-------------------------------------------------')
% % display(['CFOA 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Best_score))]);
% % display(['CFOA 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Best_score))]);
% % display(['CFOA 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Best_score))]);
% % display(['CFOA 30��ʵ���׼�std�� : ', num2str(std(Best_score))]);
% 
% % disp('-------------------------------------------------')
% % display(['SFOA 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(best_fitness))]);
% % display(['SFOA 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(best_fitness))]);
% % display(['SFOA 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(best_fitness))]);
% % display(['SFOA 30��ʵ���׼�std�� : ', num2str(std(best_fitness))]);
% 
disp('-------------------------------------------------')
display(['AHA 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Destination_fitness5))]);
display(['AHA 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Destination_fitness5))]);
display(['AHA 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Destination_fitness5))]);
display(['AHA 30��ʵ���׼�std�� : ', num2str(std(Destination_fitness5))]);
% 
% disp('-------------------------------------------------')
% display(['EWOA 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Score_best))]);
% display(['EWOA 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Score_best))]);
% display(['EWOA 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Score_best))]);
% display(['EWOA 30��ʵ���׼�std�� : ', num2str(std(Score_best))]);
% 
% disp('-------------------------------------------------')
% display(['ESO 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(fval))]);
% display(['ESO 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(fval))]);
% display(['ESO 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(fval))]);
% display(['ESO 30��ʵ���׼�std�� : ', num2str(std(fval))]);
% 
% disp('-------------------------------------------------')
% display(['IGWO 30��ʵ��������Ӧ��ֵ(Best) : ', num2str(min(Alpha_score))]);
% display(['IGWO 30��ʵ�����Ž��Ӧ��ƽ����Ӧ��ֵ(mean) : ', num2str(mean(Alpha_score))]);
% display(['IGWO 30��ʵ�������Ӧ��ֵ(wrost) : ', num2str(max(Alpha_score))]);
% display(['IGWO 30��ʵ���׼�std�� : ', num2str(std(Alpha_score))]);


  
%% �������ݹ�����ͼʹ��  
% boxplot_data = [Destination_fitness', Score_best', fval', Alpha_score'];  
% ÿ���㷨����Ӧ����Ϊһ�У�ȷ��������Ӧ�����ݵ�ά��ƥ��  

% ��������ͼ  
% figure(2);  
% boxplot(boxplot_data, 'Labels', {'OPAHA', 'EWOA', 'ESO', 'IGWO'});  
% title(sprintf('����ͼ����Ӧ��ֵ�ֲ� F{%d}', Function_name));  % ���±��� 
% ylabel('��Ӧ��ֵ');  
% grid on;  