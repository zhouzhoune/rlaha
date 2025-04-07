
function [BestX,BestF,HisBestFit]=RLAHA(Tmax,nPop,fobj,lb,ub,dim) 

    PopPos=zeros(nPop,dim);              
    PopFit=zeros(1,nPop);                
   
    for i=1:size(PopPos,1)
        PopPos(i,:)=rand(1,dim).*(ub-lb)+lb;        
%         PopFit(i)=BenFunctions(PopPos(i,:),FunIndex,Dim);
        PopFit(i)=fobj(PopPos(i,:));  
    end

    BestF=inf;
    BestX=[];
    worseF= -Inf; 

    QTable=zeros(3, 2);                                                     
    alpha=0.3;
    gamma=0.8;

    for i=1:nPop
        if PopFit(i)<=BestF
            BestF=PopFit(i);
            BestX=PopPos(i,:);
        elseif PopFit(i)>=worseF
            worseF=PopFit(i);
        end
    end
  

    HisBestFit=zeros(1,Tmax);   
    VisitTable=zeros(nPop) ; 
    VisitTable(logical(eye(nPop)))=NaN;    
   
    for It=1:Tmax
        DirectVector=zeros(nPop,dim);

        for i=1:nPop
            r=rand;
            if r<1/3     
                RandDim=randperm(dim);
                if dim>=3
                    RandNum=ceil(rand*(dim-2)+1);
                else
                    RandNum=ceil(rand*(dim-1)+1);
                end
                DirectVector(i,RandDim(1:RandNum))=1;
            else
                if r>2/3  
                    DirectVector(i,:)=1;
                else  
                    RandNum=ceil(rand*dim);
                    DirectVector(i,RandNum)=1;
                end
            end
         figure_profit=fobj(PopPos(i,:));                      
         state=get_state(BestF,worseF,figure_profit);                     
         eplsilon=(Tmax*nPop-(It*nPop+i))/Tmax*nPop;               
         e=rand;
         if e<eplsilon  
             action = randi(size(QTable, 2));                           
         else
              [~, max_indices] = find(QTable(state, :) == max(QTable(state, :))); 
              if length(max_indices)==1 
                  action=max_indices;    
              else
                  action = randi(size(QTable, 2));  
              end
         end
            if action==1   
                [MaxUnvisitedTime,TargetFoodIndex]=max(VisitTable(i,:)); 
                MUT_Index=find(VisitTable(i,:)==MaxUnvisitedTime);  
                if length(MUT_Index)>1
                    [~,Ind]= min(PopFit(MUT_Index));  
                    TargetFoodIndex=MUT_Index(Ind);  
                end
                old_popfit=fobj(PopPos(i,:));                 
                newPopPos=PopPos(TargetFoodIndex,:)+randn*DirectVector(i,:).*...
                    (PopPos(i,:)-PopPos(TargetFoodIndex,:));
                newPopPos=SpaceBound(newPopPos,ub,lb);                  
                newPopFit =fobj(newPopPos); 
                new_state_1=get_state(BestF,worseF,newPopFit); 
                reward_1=old_popfit-newPopFit;               
                if newPopFit<BestF
                    BestF=newPopFit;
                    BestX=newPopPos;                    
                end               
                if newPopFit<PopFit(i)                                      
                    PopFit(i)=newPopFit;
                    PopPos(i,:)=newPopPos;
                    VisitTable(i,:)=VisitTable(i,:)+1;  
                    VisitTable(i,TargetFoodIndex)=0;   
                    VisitTable(:,i)=max(VisitTable,[],2)+1;  
                    VisitTable(i,i)=NaN;
                else
                    VisitTable(i,:)=VisitTable(i,:)+1;  
                    VisitTable(i,TargetFoodIndex)=0;
                end
            else   
                newPopPos= PopPos(i,:)+randn*DirectVector(i,:).*PopPos(i,:);
                newPopPos=SpaceBound(newPopPos,ub,lb);                    
                old_popfit=fobj(PopPos(i,:));
                newPopFit =fobj(newPopPos);   
                reward_2=old_popfit-newPopFit;
                new_state_2=get_state(BestF,worseF,newPopFit);
                if newPopFit<BestF   
                    BestF=newPopFit;
                    BestX=newPopPos;
                end
                if newPopFit<PopFit(i)                    
                    PopFit(i)=newPopFit;
                    PopPos(i,:)=newPopPos;
                    VisitTable(i,:)=VisitTable(i,:)+1;
                    VisitTable(:,i)=max(VisitTable,[],2)+1;
                    VisitTable(i,i)=NaN;
                else
                    VisitTable(i,:)=VisitTable(i,:)+1;
                end
            end
            if action==1
                reward=reward_1;
                new_state=new_state_1;
            else
                reward=reward_2;
                new_state=new_state_2;
            end
            [~, max_index] = find(QTable(new_state, :) == max(QTable(new_state, :))); 
            if length(max_index)==1
                max_Q_value=QTable(new_state, max_index);
            else
                max_Q_value=randi(size(QTable, 2));
            end
            QTable(state,action)=QTable(state,action)+alpha*(reward+gamma*max_Q_value-QTable(state,action)); 
            
     
            yuan_PopPos=PopPos(i,:);
            a2=1-2*((It+Tmax)/Tmax);   
            l=a2*rand+2;
            jianbian=50*((Tmax-It)/Tmax);
            lao_popfit=fobj(PopPos(i,:));
            for j=1:size(PopPos,2)                                               
                PopPos(i,j)=BestX(1,j)+jianbian*sin(7*l)*(BestX(1,j)-PopPos(i,j));  
            end
            
            for j=1:size(PopPos,2)
                  if  PopPos(i,j)>ub(j)
                      PopPos(i,j)=lb(j)+rand*(ub(j)-lb(j));
              elseif  PopPos(i,j)<lb(j)
                  PopPos(i,j)=lb(j)+rand*(ub(j)-lb(j));
                  end
            end
            xin_popfit=fobj(PopPos(i,:));
            if xin_popfit>=lao_popfit
                PopPos(i,:)=yuan_PopPos;
                
            else
                PopFit(i)=fobj(PopPos(i,:));
                if PopFit(i)<BestF
                    BestF=PopFit(i);
                    BestX=PopPos(i,:);
                end     
            end
            
            rand_m=0.5;
            JK=randperm(nPop);                                              
            h=a2*rand+2;  % 从1，-1
            jianbian=50*((Tmax-It)/Tmax);
            yuan_PopPos_2=PopPos(i,:);
            lao_popfit_2=fobj(PopPos(i,:));
            O_PopPos=zeros(1,dim);
            if PopFit(JK(1))<PopFit(i)
                h1=PopPos(JK(1),:)-PopPos(i,:);
            else
                h1=PopPos(i,:)-PopPos(JK(1),:);
            end
            if PopFit(JK(2))<PopFit(JK(3))
                h2=PopPos(JK(2),:)-PopPos(JK(3),:);
            else
                h2=PopPos(JK(3),:)-PopPos(JK(2),:);
            end
            b1=randn;
            b2=randn;
            for j=1:size(PopPos,2)
                O_PopPos(1,j)=PopPos(i,j)+(exp(h))*abs(b1)*h1(j)+(1-exp(l))*abs(b2)*h2(j); 
                if(rand<rand_m)
                    PopPos(i,j)=O_PopPos(1,j);
                end
            end
            %%  防止出界
            for j=1:size(PopPos,2)
                  if  PopPos(i,j)>ub(j)
                      PopPos(i,j)=lb(j)+rand*(ub(j)-lb(j));
              elseif  PopPos(i,j)<lb(j)
                      PopPos(i,j)=lb(j)+rand*(ub(j)-lb(j));
                  end
            end
            xin_popfit_2=fobj(PopPos(i,:));
            if xin_popfit_2>lao_popfit_2
                PopPos(i,:)=yuan_PopPos_2;
               
            else
                PopFit(i)=fobj(PopPos(i,:));
                if  PopFit(i)<BestF
                    PopPos(i,:)=BestX;
                end                
            end
        end        
        
%         if mod(It,2)==0
%                 k=nPop/2;
%                 [~,idx1]=sort(PopPos);
%                 for ip=k:nPop                  
%                     aPopPos(1,:)=rand(1,dim).*(ub-lb)+lb;                
%                     if fobj(aPopPos(1,:))<fobj(PopPos(idx1(k),:))
%                         PopPos(idx1(ip),:)=aPopPos(1,dim);
%                     end
%                 end
%          end

        if mod(It,2*nPop)==0 
            [~, MigrationIndex]=max(PopFit);
            PopPos(MigrationIndex,:) =rand(1,dim).*(ub-lb)+lb;
%             PopFit(MigrationIndex)=BenFunctions(PopPos(MigrationIndex,:),FunIndex,Dim);
             PopFit(MigrationIndex)=fobj(PopPos(MigrationIndex,:)); 
            VisitTable(MigrationIndex,:)=VisitTable(MigrationIndex,:)+1;
            VisitTable(:,MigrationIndex)=max(VisitTable,[],2)+1;
            VisitTable(MigrationIndex,MigrationIndex)=NaN;            
        end
        

        for i=1:nPop
            PopFit(i)=fobj(PopPos(i,:));  
            if PopFit(i)<BestF
                BestF=PopFit(i);
                BestX=PopPos(i,:);
            end
        end

        HisBestFit(It)=BestF;

    end




