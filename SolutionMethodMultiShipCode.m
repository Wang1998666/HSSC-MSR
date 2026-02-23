% %%% annual trip number, PortCall
% AnnualWorkingTime=300;
% RatioSailBerth=[0.8;0.6;0.8];
% UnitTransfer=3.600000;%%1kwh=3.6MJ
% NavigationFactor=1+0.20;%%Factors affecting sailing fuel consumption: weather, non-uniform sailing speed, and driving behavior (increase rate)
% BerthingShippingRate=0.1;%%Berthing fuel rate is assumed to be ?% of sailing fuel rate under the same power

% %% Silk Road transport fleet organization analysis
% %% container
% SilkRoadContainerRecords=readtable('SilkRoadContainer.xlsx','sheet','Records');
% a1=SilkRoadContainerRecords.startPortNameCn;
% a2=SilkRoadContainerRecords.endPortNameCn;
% b1=[];b2=[];
% for i=1:length(a1)
%     for j=1:size(PortInf,1)
%         if strcmp(a1{i,1},PortInf{j,1})
%             b1(i,1)=j;
%         end
%         if strcmp(a2{i,1},PortInf{j,1})
%             b2(i,1)=j;
%         end
%     end
% end
% ContainerRecods=[SilkRoadContainerRecords.dwt,b1,b2,year(datetime(SilkRoadContainerRecords.legStartPostime))];%% DWT,port1,port2,year
% %% Container ship classification standard
% %% <10000; 10000-20000; 20000-30000; 30000-40000; 40000-60000; 60000-80000; >80000;
% ContainerShipClass=[0;10000;20000;30000;40000;60000;80000;Inf];
% 
% %% Annual freight share by ship type
% ContainerShipDWTDistributionOD={};
% k=0;
% for y=1:1
%     for i=1:size(PortInf,1)
%         for j=1:size(PortInf,1)
%             if i~=j
%                 k=k+1;
%                 L=find(ContainerRecods(:,2)==i & ContainerRecods(:,3)==j);
%                 dwt0=ContainerRecods(L,1);
%                 if ~isempty(dwt0)
%                     A=[];
%                     for s=2:length(ContainerShipClass)
%                         L0=find(dwt0>=ContainerShipClass(s-1) & dwt0<ContainerShipClass(s));
%                         if ~isempty(L0)
%                             A(s-1,1)=sum(dwt0(L0))/sum(dwt0);
%                         else
%                             A(s-1,1)=0;
%                         end
%                     end
%                     ContainerShipDWTDistributionOD{k,1}=[i,j];
%                     ContainerShipDWTDistributionOD{k,2}=A;
%                     if max(A)>0
%                         ARealtive=A/max(A);
%                     end
%                     ContainerShipDWTDistributionOD{k,3}=ARealtive;
%                 else
%                     ContainerShipDWTDistributionOD{k,1}=[i,j];
%                     ContainerShipDWTDistributionOD{k,2}=[];
%                     ContainerShipDWTDistributionOD{k,3}=[];
%                 end
%             end
%         end
%     end
% end

% %% Spatial distribution of ship sizes
% figure(1)
% ContainerShipClassNum=length(ContainerShipClass)-1;
% thetabar=[0:1:7]*2*pi/ContainerShipClassNum;
% mycolor={'y','r','g','b','k','c','m'};
% hold on
% for k=1:size(ContainerShipDWTDistributionOD,1)
%     a=ContainerShipDWTDistributionOD{k,3};
%     i=ContainerShipDWTDistributionOD{k,1}(1);
%     j=ContainerShipDWTDistributionOD{k,1}(2);
%     if ~isempty(a)
%         for s=1:ContainerShipClassNum
%             theta=linspace(thetabar(s),thetabar(s+1),10);
%             rho=a(s);
%             X=[2*(i-1)+1,2*(i-1)+1+rho*cos(theta),2*(i-1)+1];
%             Y=[2*(j-1)+1,2*(j-1)+1+rho*sin(theta),2*(j-1)+1];
%             patch(X,Y,mycolor{s},'FaceAlpha',0.3);
%         end
%     end
%     plot([2*(i-1),2*(i-1)+2],[2*(j-1),2*(j-1)],'k--','LineWidth',1)
%     plot([2*(i-1),2*(i-1)+2],[2*(j-1)+2,2*(j-1)+2],'k--','LineWidth',1)
%     plot([2*(i-1),2*(i-1)],[2*(j-1),2*(j-1)+2],'k--','LineWidth',1)
%     plot([2*(i-1)+2,2*(i-1)+2],[2*(j-1),2*(j-1)+2],'k--','LineWidth',1)
%     plot(2*(i-1)+1,2*(j-1)+1,'k.','LineStyle','none')
% end
% 
% xtick=2*([1:16]-1)+1;
% for i=1:length(xtick)
%     xtickname{i,1}=PortInf{i,5};
% end
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18);
% 
% ytick=2*([1:16]-1)+1;
% for i=1:length(ytick)
%     ytickname{i,1}=PortInf{i,5};
% end
% set(gca,'ytick',ytick)
% set(gca,'YTickLabel',ytickname,'FontName','Times new roman','FontSize',18);
% 
% xlim([0,32])
% ylim([0,32])
% box on
% hold off

% %% bulk
% SilkRoadBulkRecords=readtable('SilkRoadBulk.xlsx','sheet','Records');
% a1=SilkRoadBulkRecords.startPortNameCn;
% a2=SilkRoadBulkRecords.endPortNameCn;
% b1=[];b2=[];
% for i=1:length(a1)
%     for j=1:size(PortInf,1)
%         if strcmp(a1{i,1},PortInf{j,1})
%             b1(i,1)=j;
%         end
%         if strcmp(a2{i,1},PortInf{j,1})
%             b2(i,1)=j;
%         end
%     end
% end
% %% Bulk ship classification standard
% %% <10000; 10000-20000; 20000-30000; 30000-40000; 40000-60000; 60000-80000; >80000;
% BulkShipClass=[0;10000;20000;30000;40000;60000;80000;Inf];
% BulkRecods=[SilkRoadBulkRecords.dwt,b1,b2,year(datetime(SilkRoadBulkRecords.legStartPostime))];%% DWT,port1,port2,year
% %% Annual freight share by ship type
% BulkShipDWTDistributionOD={};
% k=0;
% for y=1:1
%     for i=1:size(PortInf,1)
%         for j=1:size(PortInf,1)
%             if i~=j
%                 k=k+1;
%                 L=find(BulkRecods(:,2)==i & BulkRecods(:,3)==j);
%                 dwt0=BulkRecods(L,1);
%                 if ~isempty(dwt0)
%                     A=[];
%                     for s=2:length(BulkShipClass)
%                         L0=find(dwt0>=BulkShipClass(s-1) & dwt0<BulkShipClass(s));
%                         if ~isempty(L0)
%                             A(s-1,1)=sum(dwt0(L0))/sum(dwt0);
%                         else
%                             A(s-1,1)=0;
%                         end
%                     end
%                     BulkShipDWTDistributionOD{k,1}=[i,j];
%                     BulkShipDWTDistributionOD{k,2}=A;
%                     if max(A)>0
%                         ARealtive=A/max(A);
%                     end
%                     BulkShipDWTDistributionOD{k,3}=ARealtive;
%                 else
%                     BulkShipDWTDistributionOD{k,1}=[i,j];
%                     BulkShipDWTDistributionOD{k,2}=[];
%                     BulkShipDWTDistributionOD{k,3}=[];
%                 end
%             end
%         end
%     end
% end
% 
% %% Spatial distribution of ship sizes
% figure(2)
% BulkShipClassNum=length(BulkShipClass)-1;
% thetabar=[0:1:7]*2*pi/BulkShipClassNum;
% mycolor={'y','r','g','b','k','c','m'};
% hold on
% for k=1:size(BulkShipDWTDistributionOD,1)
%     a=BulkShipDWTDistributionOD{k,3};
%     i=BulkShipDWTDistributionOD{k,1}(1);
%     j=BulkShipDWTDistributionOD{k,1}(2);
%     if ~isempty(a)
%         for s=1:BulkShipClassNum
%             theta=linspace(thetabar(s),thetabar(s+1),10);
%             rho=a(s);
%             X=[2*(i-1)+1,2*(i-1)+1+rho*cos(theta),2*(i-1)+1];
%             Y=[2*(j-1)+1,2*(j-1)+1+rho*sin(theta),2*(j-1)+1];
%             patch(X,Y,mycolor{s},'FaceAlpha',0.3);
%         end
%     end
%     plot([2*(i-1),2*(i-1)+2],[2*(j-1),2*(j-1)],'k--','LineWidth',1)
%     plot([2*(i-1),2*(i-1)+2],[2*(j-1)+2,2*(j-1)+2],'k--','LineWidth',1)
%     plot([2*(i-1),2*(i-1)],[2*(j-1),2*(j-1)+2],'k--','LineWidth',1)
%     plot([2*(i-1)+2,2*(i-1)+2],[2*(j-1),2*(j-1)+2],'k--','LineWidth',1)
%     plot(2*(i-1)+1,2*(j-1)+1,'k.','LineStyle','none')
% end
% 
% xtick=2*([1:16]-1)+1;
% for i=1:length(xtick)
%     xtickname{i,1}=PortInf{i,5};
% end
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18);
% 
% ytick=2*([1:16]-1)+1;
% for i=1:length(ytick)
%     ytickname{i,1}=PortInf{i,5};
% end
% set(gca,'ytick',ytick)
% set(gca,'YTickLabel',ytickname,'FontName','Times new roman','FontSize',18);
% 
% xlim([0,32])
% ylim([0,32])
% box on
% hold off
% 
% %% Liquid
% SilkRoadLiquidRecords=readtable('SilkRoadLiquid.xlsx','sheet','Records');
% a1=SilkRoadLiquidRecords.startPortNameCn;
% a2=SilkRoadLiquidRecords.endPortNameCn;
% b1=[];b2=[];
% for i=1:length(a1)
%     for j=1:size(PortInf,1)
%         if strcmp(a1{i,1},PortInf{j,1})
%             b1(i,1)=j;
%         end
%         if strcmp(a2{i,1},PortInf{j,1})
%             b2(i,1)=j;
%         end
%     end
% end
% LiquidRecods=[SilkRoadLiquidRecords.dwt,b1,b2,year(datetime(SilkRoadLiquidRecords.legStartPostime))];%% DWT,port1,port2,year
% %% Liquid ship classification standard
% %% <5000; 5000-10000; 10000-15000; 15000-20000; 20000-30000; 30000-40000; 40000-50000; >50000;
% LiquidShipClass=[0;5000;10000;15000;20000;30000;40000;50000;Inf];
% 
% %% Annual freight share by ship type
% LiquidShipDWTDistributionOD={};
% k=0;
% for y=1:1
%     for i=1:size(PortInf,1)
%         for j=1:size(PortInf,1)
%             if i~=j
%                 k=k+1;
%                 L=find(LiquidRecods(:,2)==i & LiquidRecods(:,3)==j);
%                 dwt0=LiquidRecods(L,1);
%                 if ~isempty(dwt0)
%                     A=[];
%                     for s=2:length(LiquidShipClass)
%                         L0=find(dwt0>=LiquidShipClass(s-1) & dwt0<LiquidShipClass(s));
%                         if ~isempty(L0)
%                             A(s-1,1)=sum(dwt0(L0))/sum(dwt0);
%                         else
%                             A(s-1,1)=0;
%                         end
%                     end
%                     LiquidShipDWTDistributionOD{k,1}=[i,j];
%                     LiquidShipDWTDistributionOD{k,2}=A;
%                     if max(A)>0
%                         ARealtive=A/max(A);
%                     end
%                     LiquidShipDWTDistributionOD{k,3}=ARealtive;
%                 else
%                     LiquidShipDWTDistributionOD{k,1}=[i,j];
%                     LiquidShipDWTDistributionOD{k,2}=[];
%                     LiquidShipDWTDistributionOD{k,3}=[];
%                 end
%             end
%         end
%     end
% end
% 
% %% Spatial distribution of ship sizes
% figure(3)
% LiquidShipClassNum=length(LiquidShipClass)-1;
% thetabar=[0:1:8]*2*pi/LiquidShipClassNum;
% mycolor={'y','r','g','b','k','c','m','w'};
% hold on
% for k=1:size(LiquidShipDWTDistributionOD,1)
%     a=LiquidShipDWTDistributionOD{k,3};
%     i=LiquidShipDWTDistributionOD{k,1}(1);
%     j=LiquidShipDWTDistributionOD{k,1}(2);
%     if ~isempty(a)
%         for s=1:LiquidShipClassNum
%             theta=linspace(thetabar(s),thetabar(s+1),10);
%             rho=a(s);
%             X=[2*(i-1)+1,2*(i-1)+1+rho*cos(theta),2*(i-1)+1];
%             Y=[2*(j-1)+1,2*(j-1)+1+rho*sin(theta),2*(j-1)+1];
%             patch(X,Y,mycolor{s},'FaceAlpha',0.3);
%         end
%     end
%     plot([2*(i-1),2*(i-1)+2],[2*(j-1),2*(j-1)],'k--','LineWidth',1)
%     plot([2*(i-1),2*(i-1)+2],[2*(j-1)+2,2*(j-1)+2],'k--','LineWidth',1)
%     plot([2*(i-1),2*(i-1)],[2*(j-1),2*(j-1)+2],'k--','LineWidth',1)
%     plot([2*(i-1)+2,2*(i-1)+2],[2*(j-1),2*(j-1)+2],'k--','LineWidth',1)
%     plot(2*(i-1)+1,2*(j-1)+1,'k.','LineStyle','none')
% end
% 
% xtick=2*([1:16]-1)+1;
% for i=1:length(xtick)
%     xtickname{i,1}=PortInf{i,5};
% end
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18);
% 
% ytick=2*([1:16]-1)+1;
% for i=1:length(ytick)
%     ytickname{i,1}=PortInf{i,5};
% end
% set(gca,'ytick',ytick)
% set(gca,'YTickLabel',ytickname,'FontName','Times new roman','FontSize',18);
% 
% xlim([0,32])
% ylim([0,32])
% box on
% hold off

% FuelConsumptionRecords=readtable('SilkRoadStandardShips.xlsx','sheet','FuelConsumption');
% %% (1) Linear regression analysis of ship fuel consumption rate: ton/day
% a=FuelConsumptionRecords.MMSI;
% ShipMMSI=ShipInf(:,1);
% for i=1:length(ShipMMSI)
%     L=find(a==ShipMMSI(i));
%     b=[FuelConsumptionRecords.FullLoad(L),FuelConsumptionRecords.Speed(L),FuelConsumptionRecords.FuelDaily(L)];
%     Laden=b(b(:,1)==1,2:3);
%     Ballast=b(b(:,1)==0,2:3);
%     v0=Laden(:,1);
%     F0=Laden(:,2);
%     x=log(v0)-log(ShipInf(i,5));
%     y=log(F0);
%     p = polyfit(x,y,1);
%     ShipInf(i,8)=p(1);
%     ShipInf(i,9)=exp(p(2))/((ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1));
%     v0=Ballast(:,1);
%     F0=Ballast(:,2);
%     x=log(v0)-log(ShipInf(i,5));
%     y=log(F0);
%     p = polyfit(x,y,1);
%     ShipInf(i,10)=p(1);
%     ShipInf(i,11)=exp(p(2))/((ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1));
% end

% %% (2) Annual ship fuel consumption (ton), emissions (ton), and hydrogen consumption (ton), by ship
% %% Sailing stage: annual sailing time (hour) * fuel rate (using average speed and main/auxiliary engine power, ton/day), with laden/ballast combinations, ton
% %% Berthing stage: annual berthing time * auxiliary engine power * electric-to-thermal unit conversion / fuel heating efficiency, ton
% %% GLH consumption: fuel consumption * ratio of fuel heating efficiencies, ton
% %% Emissions: fuel consumption * emission factor, ton
% %% container ships 1~7
% for i=1:7
%     FLaden=ShipInf(i,9)*(ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1)*(ShipInf(i,6)/ShipInf(i,5))^ShipInf(i,8);
%     FBallast=ShipInf(i,11)*(ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1)*(ShipInf(i,6)/ShipInf(i,5))^ShipInf(i,10);
%     ShipInf(i,12)=RatioSailBerth(1)*AnnualWorkingTime*(LoadingFactor(1)*FLaden+(1-LoadingFactor(1))*FBallast)*NavigationFactor;%%Oil Concumption on Legs
%     ShipInf(i,13)=EmissionFactorOil*ShipInf(i,12);%% Emission on Legs
%     ShipInf(i,14)=ShipInf(i,12)*EnergyTransferFactor(1)/EnergyTransferFactor(2);%%GLH Concumption on Legs
%     ShipInf(i,15)=(ShipInf(i,11)*BerthingShippingRate)*(1-RatioSailBerth(1))*AnnualWorkingTime*ShipInf(i,4)*UnitTransfer/EnergyTransferFactor(1);%% Oil Concumption  on Ports
%     ShipInf(i,16)=EmissionFactorOil*ShipInf(i,15);%% Emission on Ports
%     ShipInf(i,17)=ShipInf(i,15)*EnergyTransferFactor(1)/EnergyTransferFactor(2);%%GLH Concumption on Ports
%     ShipInf(i,18)=ShipInf(i,14)+ShipInf(i,17);%%GLH Concumption by ship
% end
% %% Bulk ships 8~14
% for i=8:14
%     FLaden=ShipInf(i,9)*(ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1)*(ShipInf(i,6)/ShipInf(i,5))^ShipInf(i,8);
%     FBallast=ShipInf(i,11)*(ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1)*(ShipInf(i,6)/ShipInf(i,5))^ShipInf(i,10);
%     ShipInf(i,12)=RatioSailBerth(2)*AnnualWorkingTime*(LoadingFactor(2)*FLaden+(1-LoadingFactor(2))*FBallast)*NavigationFactor;%%Oil Concumption on Legs
%     ShipInf(i,13)=EmissionFactorOil*ShipInf(i,12);%% Emission on Legs
%     ShipInf(i,14)=ShipInf(i,12)*EnergyTransferFactor(1)/EnergyTransferFactor(2);%%GLH Concumption on Legs
%     ShipInf(i,15)=(ShipInf(i,11)*BerthingShippingRate)*(1-RatioSailBerth(2))*AnnualWorkingTime*ShipInf(i,4)*UnitTransfer/EnergyTransferFactor(1);%% Oil Concumption  on Ports
%     ShipInf(i,16)=EmissionFactorOil*ShipInf(i,15);%% Emission on Ports
%     ShipInf(i,17)=ShipInf(i,15)*EnergyTransferFactor(1)/EnergyTransferFactor(2);%%GLH Concumption on Ports
%     ShipInf(i,18)=ShipInf(i,14)+ShipInf(i,17);%%GLH Concumption by ship
% end
% %% Liquid ships 15~22
% for i=15:22
%     FLaden=ShipInf(i,9)*(ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1)*(ShipInf(i,6)/ShipInf(i,5))^ShipInf(i,8);
%     FBallast=ShipInf(i,11)*(ShipInf(i,3)+ShipInf(i,4))*UnitTransfer/EnergyTransferFactor(1)*(ShipInf(i,6)/ShipInf(i,5))^ShipInf(i,10);
%     ShipInf(i,12)=RatioSailBerth(3)*AnnualWorkingTime*(LoadingFactor(3)*FLaden+(1-LoadingFactor(3))*FBallast)*NavigationFactor;%%Oil Concumption on Legs
%     ShipInf(i,13)=EmissionFactorOil*ShipInf(i,12);%% Emission on Legs
%     ShipInf(i,14)=ShipInf(i,12)*EnergyTransferFactor(1)/EnergyTransferFactor(2);%%GLH Concumption on Legs
%     ShipInf(i,15)=(ShipInf(i,11)*BerthingShippingRate)*(1-RatioSailBerth(3))*AnnualWorkingTime*ShipInf(i,4)*UnitTransfer/EnergyTransferFactor(1);%% Oil Concumption  on Ports
%     ShipInf(i,16)=EmissionFactorOil*ShipInf(i,15);%% Emission on Ports
%     ShipInf(i,17)=ShipInf(i,15)*EnergyTransferFactor(1)/EnergyTransferFactor(2);%%GLH Concumption on Ports
%     ShipInf(i,18)=ShipInf(i,14)+ShipInf(i,17);%%GLH Concumption by ship
% end

% %% (3) Regional annual voyage frequency, port calls, and fleet size
% %% containers
% %% Convert country-to-country transport demand into port-to-port transport demand
% ShipmentContainer=zeros(size(PortInf,1),size(PortInf,1));
% for i=1:size(CountryInf,1)
%     for j=1:size(CountryInf,1)
%         if i~=j
%             a=CountryInf{i,3};   
%             b=CountryInf{j,3};
%             q=ShipmentContainer0(i,j);%%Transport demand from country i to country j
%             for k1=1:size(a,1)
%                 for k2=1:size(b,1)
%                     ShipmentContainer(a(k1,1),b(k2,1))=q*a(k1,2)*b(k2,2);%%Transport demand from country i (port k1) to country j (port k2)
%                 end
%             end
%         end
%     end
% end
% %% Transport allocation ratios for different ship types
% %% Allocate transport to ship classes by ShipDWTDistributionODContainer; if empty or all zeros, assign to Class-3 ships (largest-share default)
% shipmentbyshipclass={};
% B1=zeros(size(PortInf,1),size(PortInf,1));B2=zeros(size(B1));B3=zeros(size(B1));B4=zeros(size(B1));B5=zeros(size(B1));B6=zeros(size(B1));B7=zeros(size(B1));
% for k=1:size(ShipDWTDistributionODContainer,1)
%     a=ShipDWTDistributionODContainer{k,1};
%     A=ShipDWTDistributionODContainer{k,3};
%     if isempty(A) | sum(A)==0
%         A=[0;0;1;0;0;0;0];
%     end
%     B1(a(1),a(2))=A(1);
%     B2(a(1),a(2))=A(2);
%     B3(a(1),a(2))=A(3);
%     B4(a(1),a(2))=A(4);
%     B5(a(1),a(2))=A(5);
%     B6(a(1),a(2))=A(6);
%     B7(a(1),a(2))=A(7);
% end
% shipmentbyshipclass{1,1}=B1;
% shipmentbyshipclass{2,1}=B2;
% shipmentbyshipclass{3,1}=B3;
% shipmentbyshipclass{4,1}=B4;
% shipmentbyshipclass{5,1}=B5;
% shipmentbyshipclass{6,1}=B6;
% shipmentbyshipclass{7,1}=B7;
% for i=1:7
%     TripNum{i,1}=ceil((ShipmentContainer.*shipmentbyshipclass{i,1})./(LoadingFactor(1)*ShipInf(i,2)));%%Annual voyages on legs
%     PortCallOutNum{i,1}=sum(TripNum{i,1},1);%%Annual outbound port calls
%     PortCallInNum{i,1}=(sum(TripNum{i,1},2))';%%Annual inbound port calls
%     PortCallNum{i,1}=PortCallOutNum{i,1}+PortCallInNum{i,1};%%Annual total port calls
%     ShipInf(i,19)=ceil(sum(sum(TripNum{i,1}.*DistanceLeg/ShipInf(i,6)))/(RatioSailBerth(1)*AnnualWorkingTime*24));%%Fleet size = total sailing hours / annual sailing hours per ship
% end

% % %% Bulk
% % %% Convert country-to-country transport demand into port-to-port transport demand
% % ShipmentCoal=zeros(size(PortInf,1),size(PortInf,1));
% % for i=1:size(CountryInf,1)
% %     for j=1:size(CountryInf,1)
% %         if i~=j
% %             a=CountryInf{i,3};
% %             b=CountryInf{j,3};
% %             q=ShipmentCoal0(i,j);%%Transport demand from country i to country j
% %             for k1=1:size(a,1)
% %                 for k2=1:size(b,1)
% %                     ShipmentCoal(a(k1,1),b(k2,1))=q*a(k1,2)*b(k2,2);%%Transport demand from country i (port k1) to country j (port k2)
% %                 end
% %             end
% %         end
% %     end
% % end
% % ShipmentIronOre=zeros(size(PortInf,1),size(PortInf,1));
% % for i=1:size(CountryInf,1)
% %     for j=1:size(CountryInf,1)
% %         if i~=j
% %             a=CountryInf{i,3};
% %             b=CountryInf{j,3};
% %             q=ShipmentIronOre0(i,j);%%Transport demand from country i to country j
% %             for k1=1:size(a,1)
% %                 for k2=1:size(b,1)
% %                     ShipmentIronOre(a(k1,1),b(k2,1))=q*a(k1,2)*b(k2,2);%%Transport demand from country i (port k1) to country j (port k2)
% %                 end
% %             end
% %         end
% %     end
% % end
% %% Allocate transport to ship classes by ShipDWTDistributionODContainer; if empty or all zeros, assign to Class-2 ships (largest-share default)
% shipmentbyshipclass={};
% B1=zeros(size(PortInf,1),size(PortInf,1));B2=zeros(size(B1));B3=zeros(size(B1));B4=zeros(size(B1));B5=zeros(size(B1));B6=zeros(size(B1));B7=zeros(size(B1));
% for k=1:size(ShipDWTDistributionODBulk,1)
%     a=ShipDWTDistributionODBulk{k,1};
%     A=ShipDWTDistributionODBulk{k,3};
%     if isempty(A) | sum(A)==0
%         A=[0;0;1;0;0;0;0];
%     end
%     B1(a(1),a(2))=A(1);
%     B2(a(1),a(2))=A(2);
%     B3(a(1),a(2))=A(3);
%     B4(a(1),a(2))=A(4);
%     B5(a(1),a(2))=A(5);
%     B6(a(1),a(2))=A(6);
%     B7(a(1),a(2))=A(7);
% end
% shipmentbyshipclass{1,1}=B1;
% shipmentbyshipclass{2,1}=B2;
% shipmentbyshipclass{3,1}=B3;
% shipmentbyshipclass{4,1}=B4;
% shipmentbyshipclass{5,1}=B5;
% shipmentbyshipclass{6,1}=B6;
% shipmentbyshipclass{7,1}=B7;
% for i=8:14
%     TripNum{i,1}=ceil((ShipmentCoal.*shipmentbyshipclass{i-7,1})./(LoadingFactor(2)*ShipInf(i,2)))+ceil((ShipmentIronOre.*shipmentbyshipclass{i-7,1})./(LoadingFactor(3)*ShipInf(i,2)));%%Annual voyages on legs
%     PortCallOutNum{i,1}=sum(TripNum{i,1},1);%%Annual outbound port calls
%     PortCallInNum{i,1}=(sum(TripNum{i,1},2))';%%Annual inbound port calls
%     PortCallNum{i,1}=PortCallOutNum{i,1}+PortCallInNum{i,1};%%Annual total port calls
%     ShipInf(i,19)=ceil(sum(sum(TripNum{i,1}.*DistanceLeg/ShipInf(i,6)))/(RatioSailBerth(2)*AnnualWorkingTime*24));%%Fleet size = total sailing hours / annual sailing hours per ship
% end

% %% Liquid
% %% Convert country-to-country transport demand into port-to-port transport demand
% ShipmentCrudeOil=zeros(size(PortInf,1),size(PortInf,1));
% for i=1:size(CountryInf,1)
%     for j=1:size(CountryInf,1)
%         if i~=j
%             a=CountryInf{i,3};
%             b=CountryInf{j,3};
%             q=ShipmentCrudeOil0(i,j);%%Transport demand from country i to country j
%             for k1=1:size(a,1)
%                 for k2=1:size(b,1)
%                     ShipmentCrudeOil(a(k1,1),b(k2,1))=q*a(k1,2)*b(k2,2);%%Transport demand from country i (port k1) to country j (port k2)
%                 end
%             end
%         end
%     end
% end
% ShipmentLNG=zeros(size(PortInf,1),size(PortInf,1));
% for i=1:size(CountryInf,1)
%     for j=1:size(CountryInf,1)
%         if i~=j
%             a=CountryInf{i,3};
%             b=CountryInf{j,3};
%             q=ShipmentLNG0(i,j);%%Transport demand from country i to country j
%             for k1=1:size(a,1)
%                 for k2=1:size(b,1)
%                     ShipmentLNG(a(k1,1),b(k2,1))=q*a(k1,2)*b(k2,2);%%Transport demand from country i (port k1) to country j (port k2)
%                 end
%             end
%         end
%     end
% end
% ShipmentLPG=zeros(size(PortInf,1),size(PortInf,1));
% for i=1:size(CountryInf,1)
%     for j=1:size(CountryInf,1)
%         if i~=j
%             a=CountryInf{i,3};
%             b=CountryInf{j,3};
%             q=ShipmentLPG0(i,j);%%Transport demand from country i to country j
%             for k1=1:size(a,1)
%                 for k2=1:size(b,1)
%                     ShipmentLPG(a(k1,1),b(k2,1))=q*a(k1,2)*b(k2,2);%%Transport demand from country i (port k1) to country j (port k2)
%                 end
%             end
%         end
%     end
% end
% %% Allocate transport to ship classes by ShipDWTDistributionODContainer; if empty or all zeros, assign to Class-4 ships (largest-share default)
% shipmentbyshipclass={};
% B1=zeros(size(PortInf,1),size(PortInf,1));B2=zeros(size(B1));B3=zeros(size(B1));B4=zeros(size(B1));B5=zeros(size(B1));B6=zeros(size(B1));B7=zeros(size(B1));B8=zeros(size(B1));
% for k=1:size(ShipDWTDistributionODLiquid,1)
%     a=ShipDWTDistributionODLiquid{k,1};
%     A=ShipDWTDistributionODLiquid{k,3};
%     if isempty(A) | sum(A)==0
%         A=[0;0;0;1;0;0;0;0];
%     end
%     B1(a(1),a(2))=A(1);
%     B2(a(1),a(2))=A(2);
%     B3(a(1),a(2))=A(3);
%     B4(a(1),a(2))=A(4);
%     B5(a(1),a(2))=A(5);
%     B6(a(1),a(2))=A(6);
%     B7(a(1),a(2))=A(7);
%     B8(a(1),a(2))=A(8);
% end
% shipmentbyshipclass{1,1}=B1;
% shipmentbyshipclass{2,1}=B2;
% shipmentbyshipclass{3,1}=B3;
% shipmentbyshipclass{4,1}=B4;
% shipmentbyshipclass{5,1}=B5;
% shipmentbyshipclass{6,1}=B6;
% shipmentbyshipclass{7,1}=B7;
% shipmentbyshipclass{8,1}=B7;
% for i=15:22
%     TripNum{i,1}=ceil((ShipmentCrudeOil.*shipmentbyshipclass{i-14,1})./(LoadingFactor(2)*ShipInf(i,2)))+ceil((ShipmentLNG.*shipmentbyshipclass{i-14,1})./(LoadingFactor(3)*ShipInf(i,2)))++ceil((ShipmentLPG.*shipmentbyshipclass{i-14,1})./(LoadingFactor(3)*ShipInf(i,2)));%%Annual voyages on legs
%     PortCallOutNum{i,1}=sum(TripNum{i,1},1);%%Annual outbound port calls
%     PortCallInNum{i,1}=(sum(TripNum{i,1},2))';%%Annual inbound port calls
%     PortCallNum{i,1}=PortCallOutNum{i,1}+PortCallInNum{i,1};%%Annual total port calls
%     ShipInf(i,19)=ceil(sum(sum(TripNum{i,1}.*DistanceLeg/ShipInf(i,6)))/(RatioSailBerth(2)*AnnualWorkingTime*24));%%Fleet size = total sailing hours / annual sailing hours per ship
% end
% 
% %% (4) Regional annual total emissions and GLH allocation by port, ton
% for i=1:size(ShipInf,1)
%     ShipInf(i,20)=ShipInf(i,13)*ShipInf(i,19);%%fleet emission on legs
%     ShipInf(i,21)=ShipInf(i,16).*ShipInf(i,19);%%fleet emission on ports
%     MileageShipping{i,1}=TripNum{i,1}.*DistanceLeg;%% Annual ship turnover (distance * voyages, assuming equal payload), (16*16)*22 cells
%     EmissionAllocationLeg{i,1}=ShipInf(i,20)*MileageShipping{i,1}/sum(sum(MileageShipping{i,1}));%%Annual leg emissions (16*16)*22cells
%     EmissionAllocationPort{i,1}=ShipInf(i,21)*PortCallNum{i,1}/(sum(PortCallNum{i,1}));%%Annual port emissions (16*1)*22cells
%     GLHAllocationPort{i,1}=ShipInf(i,18)*ShipInf(i,19)*PortCallNum{i,1}/(sum(PortCallNum{i,1}));%%Annual port GLH allocation (16*1)*22cells
% end
% 
% %% (5) Regional annual fuel cost and annual GLH cost (mUSD)
% for i=1:size(ShipInf,1)
%     ShipInf(i,22)=PriceOilGLH(1)*(ShipInf(i,12)+ShipInf(i,15))*ShipInf(i,19)*1e-6;%%Annual fuel cost
%     ShipInf(i,23)=PriceOilGLH(2)*ShipInf(i,18)*ShipInf(i,19)*1e-6;%%Annual GLH cost
% end
% 
% %% (6) Regional ship retrofitting cost (mUSD)
% for i=1:size(ShipInf,1)
%     ShipInf(i,24)=ShipInf(i,7)*ShipInf(i,19);%%Ship retrofitting cost
% end
% 
% %% (7) Port GLH infrastructure investment cost, solved via integer programming
% %% containers & Bulk & Liquid
% %% Annual hydrogen demand by port, demand rate: ton/day
% a=0;
% for i=1:size(ShipInf,1)
%     a=a+GLHAllocationPort{i,1};
% end
% GLHByPortdayly=a/AnnualWorkingTime;
% %% Bunkering vessel hourly bunkering rate 500 ton/hour, bunkering time per day 20%*24, bunkering rate
% %% 500*24*0.2 ton/day; considering service to other-route vessels, peak factor 1.5
% %% Bunkering vessels ensure normal refueling service
% B=10;%%MUSD vessel
% %% Number of bunkering vessels to meet daily bunkering demand; if demand is random, consider possible congestion (e.g., multiply by factor 1.2)
% for i=1:size(PortInf,1)
%     PeakDemand=GLHByPortdayly(i)*1.5;
%     GLHBunkeringVesselByPort(i,1)=ceil(PeakDemand/(500*24*0.2));
%     GLHBunkeringVesselByPort(i,2)=B*GLHBunkeringVesselByPort(i,1);
% end
% %% Port hydrogen:
% StorageDay=30;%%Replenishment cycle ? days, maximum storage 2*? days
% %% Number of storage tanks
% %% min A1 x1 + A2 x2, s.t. CapacityStorageTank(1)*x1 + CapacityStorageTank(2)*x2 >= Hi
% A1=CapitalCostStorageTank(1)*CapacityStorageTank(1)*1e-6;%%mUSD 20000-ton tanker
% A2=CapitalCostStorageTank(2)*CapacityStorageTank(2)*1e-6;%%mUSD 5000-ton tanker
% GLHMaxStorageByPort=GLHByPortdayly*StorageDay*2;%%Maximum storage inventory
% f=[A1,A2];
% intcon=[1,2];
% A=-[CapacityStorageTank(1),CapacityStorageTank(2)];
% lb=[0,0];
% ub=[Inf,Inf];
% for i=1:size(PortInf,1)
%     b=-GLHMaxStorageByPort(i);
%     x = intlinprog(f,intcon,A,b,[],[],lb,ub);
%     GLHInfrastrutureNumByPort(i,1)=x(1);
%     GLHInfrastrutureNumByPort(i,2)=x(2);
%     GLHInfrastrutureCostByPort(i,1)=f(1)*x(1)+f(2)*x(2);
% end

% %% Visualization results
% %% 1. Ship fuel consumption, GLH, and emissions (bar chart, per ship)
% BarGroup=1;
% Barw=0.24*BarGroup;
% BarIn=0.02*BarGroup;
% BarOut=0.26*BarGroup;
% subplot(2,1,1)
% hold on
% for i=1:size(ShipInf,1)
%     X=[BarGroup*(i-1)+BarOut,BarGroup*(i-1)+BarOut+Barw,BarGroup*(i-1)+BarOut+Barw,BarGroup*(i-1)+BarOut,BarGroup*(i-1)+BarOut];
%     Y=[0,0,ShipInf(i,12),ShipInf(i,12),0];
%     patch(X,Y,'r','FaceAlpha',1);    
% 
%     X=[BarGroup*(i-1)+BarOut+BarIn+Barw,BarGroup*(i-1)+BarOut+BarIn+2*Barw,BarGroup*(i-1)+BarOut+BarIn+2*Barw,BarGroup*(i-1)+BarOut+BarIn+Barw,BarGroup*(i-1)+BarOut+BarIn+Barw];
%     Y=[0,0,ShipInf(i,14),ShipInf(i,14),0];
%     patch(X,Y,'b','FaceAlpha',1);   
% 
%     X=[BarGroup*(i-1)+BarOut+2*BarIn+2*Barw,BarGroup*(i-1)+BarOut+2*BarIn+3*Barw,BarGroup*(i-1)+BarOut+2*BarIn+3*Barw,BarGroup*(i-1)+BarOut+2*BarIn+2*Barw,BarGroup*(i-1)+BarOut+2*BarIn+2*Barw];
%     Y=[0,0,ShipInf(i,13),ShipInf(i,13),0];
%     patch(X,Y,'k','FaceAlpha',1);   
% end
% set(gca,'XTickLabel',[],'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% xlim([0 BarGroup*size(ShipInf,1)])
% box on
% hold off
% 
% subplot(2,1,2)
% hold on
% for i=1:size(ShipInf,1)
%     X=[BarGroup*(i-1)+BarOut,BarGroup*(i-1)+BarOut+Barw,BarGroup*(i-1)+BarOut+Barw,BarGroup*(i-1)+BarOut,BarGroup*(i-1)+BarOut];
%     Y=[0,0,ShipInf(i,15),ShipInf(i,15),0];
%     patch(X,Y,'r','FaceAlpha',1);
% 
%     X=[BarGroup*(i-1)+BarOut+BarIn+Barw,BarGroup*(i-1)+BarOut+BarIn+2*Barw,BarGroup*(i-1)+BarOut+BarIn+2*Barw,BarGroup*(i-1)+BarOut+BarIn+Barw,BarGroup*(i-1)+BarOut+BarIn+Barw];
%     Y=[0,0,ShipInf(i,17),ShipInf(i,17),0];
%     patch(X,Y,'b','FaceAlpha',1);
% 
%     X=[BarGroup*(i-1)+BarOut+2*BarIn+2*Barw,BarGroup*(i-1)+BarOut+2*BarIn+3*Barw,BarGroup*(i-1)+BarOut+2*BarIn+3*Barw,BarGroup*(i-1)+BarOut+2*BarIn+2*Barw,BarGroup*(i-1)+BarOut+2*BarIn+2*Barw];
%     Y=[0,0,ShipInf(i,16),ShipInf(i,16),0];
%     patch(X,Y,'k','FaceAlpha',1);   
% 
%     if i<=7 & i>=1
%         xtickname{i,1}=['C' num2str(i)];
%     end
%     if i<=14 & i>=8
%         xtickname{i,1}=['B' num2str(i-7)];
%     end
%     if i<=22 & i>=15
%         xtickname{i,1}=['L' num2str(i-14)];
%     end
%     xtick(i,1)=BarGroup*(i-1)+BarOut+Barw+BarIn/2;
% end
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% xlim([0 BarGroup*size(ShipInf,1)])
% box on
% hold off

% %% 2. Fleet composition (pie chart)
% figure(1)
% subplot(1,3,1)
% Mycolor=[0 255 0;0 255 255;255 255 0;160 32 240;255 0 0;97 88 158;215 97 0;255 0 255]/255;
% colormap(Mycolor)
% p=pie(ShipInf(1:7,19),'%.f%%');
% legend(xtickname(1:7))
% legend('Orientation','horizontal')
% sum(ShipInf(1:7,19))
% subplot(1,3,2)
% p=pie(ShipInf(8:14,19),'%.f%%');
% legend(xtickname(8:14))
% legend('Orientation','horizontal')
% sum(ShipInf(8:14,19))
% subplot(1,3,3)
% p=pie(ShipInf(15:22,19),'%.f%%');
% legend(xtickname(15:22))
% legend('Orientation','horizontal')
% sum(ShipInf(15:22,19))


% %% 3. Silk Road annual leg voyages, port calls, turnover distribution, and fleet size
% %% Voyage distribution by OD and cargo type; selected OD pairs shown by violin plot
% k=0;
% for i=1:size(PortInf,1)
%     for j=1:size(PortInf,1)
%         if i~=j
%             k=k+1;
%             PortPairsTripNum(k,1)=i;
%             PortPairsTripNum(k,2)=j;
%             for m=1:length(TripNum)
%                 PortPairsTripNum(k,m+2)=TripNum{m}(i,j);
%             end
%         end
%     end
% end
% PortPairsTripNum0=PortPairsTripNum(:,3:24);
% TripNumMax=max(max(PortPairsTripNum0));
% PortPairsTripNum1=PortPairsTripNum0/TripNumMax;
% GroupW=1;
% hold on
% Y=([1:size(ShipInf,1)])';
% TargetPortpair=[6,16;16,6;5,6;6,5;5,16;16,5;12,16;7,6;7,16;16,1;6,7;16,7];
% xtickname={};
% xtick=[];
% portpairindex=[];
% for k=1:size(TargetPortpair,1)
%     l=find(PortPairsTripNum(:,1)==TargetPortpair(k,1) & PortPairsTripNum(:,2)==TargetPortpair(k,2));
%     portpairindex(k,1)=l;
%     for i=1:length(Y)
%         XL(i,1)=GroupW*(k-1)+GroupW/2-PortPairsTripNum1(l,Y(i))/2;
%         XR(i,1)=GroupW*(k-1)+GroupW/2+PortPairsTripNum1(l,Y(i))/2;
%     end
%     TripNumViolinPolygonCX=[XL(1:7);flip(XR(1:7))];
%     TripNumViolinPolygonCY=[Y(1:7);flip(Y(1:7))];
%     patch(TripNumViolinPolygonCX,TripNumViolinPolygonCY,'b','FaceAlpha',1);
%     TripNumViolinPolygonBX=[XL(8:14);flip(XR(8:14))];
%     TripNumViolinPolygonBY=[Y(8:14);flip(Y(8:14))];
%     patch(TripNumViolinPolygonBX,TripNumViolinPolygonBY,'g','FaceAlpha',1);
%     TripNumViolinPolygonLX=[XL(15:22);flip(XR(15:22))];
%     TripNumViolinPolygonLY=[Y(15:22);flip(Y(15:22))];
%     patch(TripNumViolinPolygonLX,TripNumViolinPolygonLY,'r','FaceAlpha',1);
%     xtickname{k,1}=[PortInf{PortPairsTripNum(l,1),5},'->',PortInf{PortPairsTripNum(l,2),5}];
%     xtick(k,1)=GroupW*(k-1)+GroupW/2;
% end
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',12,'LineWidth',1.5);
% ytickname=ShipIndex;
% ytick=Y;
% set(gca,'ytick',ytick)
% set(gca,'YTickLabel',ytickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% ylim([0 size(ShipInf,1)])
% xlim([0,GroupW*size(TargetPortpair,1)])
% box on
% hold off
% A=PortPairsTripNum0(portpairindex,:);

% %% Voyage distribution by OD and cargo type; all port pairs, cumulative voyages
% TripNumConainer=zeros(size(PortInf,1),size(PortInf,1));
% TripNumBulk=zeros(size(PortInf,1),size(PortInf,1));
% TripNumLiquid=zeros(size(PortInf,1),size(PortInf,1));
% for k=1:7
%     TripNumConainer=TripNumConainer+TripNum{k};
% end
% for k=8:14
%     TripNumBulk=TripNumBulk+TripNum{k};
% end
% for k=15:22
%     TripNumLiquid=TripNumLiquid+TripNum{k};
% end
% 
% Cylinder_r=0.3;%% 
% [X0,Y0,Z0]=cylinder(Cylinder_r);%% Generate a standard cylinder with bottom radius: 2*21 grid points, base center (0,0,0), height 1
% TripNummax=[max(max(TripNumConainer)),max(max(TripNumBulk)),max(max(TripNumLiquid))];
% TripNumMax=max(TripNummax);
% Cylinder_h=100;
% figure(1)
% hold on
% for i=1:size(PortInf,1)   
%     for j=1:size(PortInf,1)  
%         if i~=j
%             a=TripNumConainer(i,j);
%             b=TripNumBulk(i,j);
%             c=TripNumLiquid(i,j);
%             ha=a/TripNumMax*Cylinder_h;
%             hb=b/TripNumMax*Cylinder_h;
%             hc=c/TripNumMax*Cylinder_h;
% 
%             %% container
%             X=[];Y=[];Z=[];
%             X=X0+3*(i-1)+0.9;
%             Y=Y0+3*(j-1)+1.5;
%             Z(1,:)=Z0(1,:);
%             Z(2,:)=Z0(1,:)+ha;
%             surf(X,Y,Z,'FaceColor',[0,0,1],'EdgeColor',[0,0,1]);
%             [r,the]=meshgrid(linspace(0,0.3,100),linspace(0,2*pi,100));
%             [x,y]=pol2cart(the,r); 
%             surf(x+3*(i-1)+0.9,y+3*(j-1)+1.5,ha*r.^0,'FaceColor',[0,0,1],'EdgeColor',[0,0,1]);    
% 
%             %% Bulk
%             X=[];Y=[];Z=[];
%             X=X0+3*(i-1)+1.5;
%             Y=Y0+3*(j-1)+1.5;
%             Z(1,:)=Z0(1,:);
%             Z(2,:)=Z0(1,:)+hb;
%             surf(X,Y,Z,'FaceColor',[153,204,0]/255,'EdgeColor',[153,204,0]/255);
%             [r,the]=meshgrid(linspace(0,0.3,100),linspace(0,2*pi,100));
%             [x,y]=pol2cart(the,r); 
%             surf(x+3*(i-1)+1.5,y+3*(j-1)+1.5,hb*r.^0,'FaceColor',[153,204,0]/255,'EdgeColor',[153,204,0]/255);    
% 
%             %% Liquid
%             X=[];Y=[];Z=[];
%             X=X0+3*(i-1)+2.1;
%             Y=Y0+3*(j-1)+1.5;
%             Z(1,:)=Z0(1,:);
%             Z(2,:)=Z0(1,:)+hc;
%             surf(X,Y,Z,'FaceColor',[227,0,57]/255,'EdgeColor',[227,0,57]/255);
%             [r,the]=meshgrid(linspace(0,0.3,100),linspace(0,2*pi,100));
%             [x,y]=pol2cart(the,r); 
%             surf(x+3*(i-1)+2.1,y+3*(j-1)+1.5,hc*r.^0,'FaceColor',[227,0,57]/255,'EdgeColor',[227,0,57]/255);    
%         end
%     end
% 
%     xtick=3*([1:16]-1)+1.5;
%     for i=1:length(xtick)
%         xtickname{i,1}=PortInf{i,5};
%     end
%     set(gca,'xtick',xtick)
%     set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
%     % set(gca,'xtickLabelrotation',60)
% 
%     ytick=3*([1:16]-1)+1.5;
%     for i=1:length(ytick)
%         ytickname{i,1}=PortInf{i,5};
%     end
%     set(gca,'ytick',ytick)
%     set(gca,'YTickLabel',ytickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% 
%     ztick=[0:10:100];
%     for i=1:length(ztick)
%         ztickname{i,1}=num2str(round(TripNumMax*ztick(i)/100,0));
%     end
%     set(gca,'ztick',ztick)
%     set(gca,'ZTickLabel',ztickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
%     grid on
%     view(-10,60)
% 
% end
% hold off

% % %% Port call distribution by cargo type and ship class (bar, excel)
% Mycolor=[0 255 0;0 255 255;255 255 0;160 32 240;255 0 0;97 88 158;215 97 0;255 0 255]/255;
% colormap(Mycolor)
% xtick=[1:size(PortInf,1)];
% figure(1)
% subplot(3,1,1)
% PortCallContainer=[];
% for k=1:7
%     PortCallContainer=[PortCallContainer (PortCallNum{k})'];
% end
% bar(PortCallContainer,'stacked')
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',[],'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% legend(ShipIndex(1:7))
% box on
% 
% subplot(3,1,2)
% PortCallBulk=[];
% for k=8:14
%     PortCallBulk=[PortCallBulk (PortCallNum{k})'];
% end
% bar(PortCallBulk,'stacked')
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',[],'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% legend(ShipIndex(8:14))
% box on
% 
% subplot(3,1,3)
% PortCallLiquid=[];
% for k=15:22
%     PortCallLiquid=[PortCallLiquid (PortCallNum{k})'];
% end
% bar(PortCallLiquid,'stacked')
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% legend(ShipIndex(15:22))
% box on

% %% 3. Silk Road annual total emissions, total GLH demand, and allocation
% %% Leg-emission heatmap and port-emission pie chart
% %% Port emissions: container, bulk, liquid
% %% Circle area indicates total port emissions; container/bulk/liquid shares are represented by sectors
% AnnualEmissionAllocationContainerPort=zeros(1,size(PortInf,1));
% for k=1:7
%     AnnualEmissionAllocationContainerPort=AnnualEmissionAllocationContainerPort+EmissionAllocationPort{k};
% end
% AnnualEmissionAllocationBulkPort=zeros(1,size(PortInf,1));
% for k=8:14
%     AnnualEmissionAllocationBulkPort=AnnualEmissionAllocationBulkPort+EmissionAllocationPort{k};
% end
% AnnualEmissionAllocationLiquidPort=zeros(1,size(PortInf,1));
% for k=15:22
%     AnnualEmissionAllocationLiquidPort=AnnualEmissionAllocationLiquidPort+EmissionAllocationPort{k};
% end
% EmissionSumPort=AnnualEmissionAllocationContainerPort+AnnualEmissionAllocationBulkPort+AnnualEmissionAllocationLiquidPort;
% EmissionSumMax=max(EmissionSumPort);
% Rmax=10;%% Maximum radius
% PortEmission=struct();
% k=0;
% for i=1:size(PortInf,1)     
%     thetaContainer=linspace(0,AnnualEmissionAllocationContainerPort(1,i)/EmissionSumPort(1,i)*2*pi,20);
%     thetaBulk=linspace(AnnualEmissionAllocationContainerPort(1,i)/EmissionSumPort(1,i)*2*pi,(AnnualEmissionAllocationContainerPort(1,i)+AnnualEmissionAllocationBulkPort(1,i))/EmissionSumPort(1,i)*2*pi,20);
%     thetaLiquid=linspace((AnnualEmissionAllocationContainerPort(1,i)+AnnualEmissionAllocationBulkPort(1,i))/EmissionSumPort(1,i)*2*pi,2*pi,20);
%     %% container
%     k=k+1;
%     XC=PortInf{i,2}+Rmax*EmissionSumPort(1,i)/EmissionSumMax*sin(thetaContainer);
%     YC=PortInf{i,3}+Rmax*EmissionSumPort(1,i)/EmissionSumMax*cos(thetaContainer);
%     PortEmission(k,1).Geometry='Polygon';
%     PortEmission(k,1).BoundingBox=[min(XC),min(YC);max(XC),max(YC)];
%     PortEmission(k,1).X=[PortInf{i,2},XC,PortInf{i,2},nan];
%     PortEmission(k,1).Y=[PortInf{i,3},YC,PortInf{i,3},nan];
%     PortEmission(k,1).PortN=PortInf{i,5};
% 
%     %% Bulk
%     k=k+1;
%     XB=PortInf{i,2}+Rmax*EmissionSumPort(1,i)/EmissionSumMax*sin(thetaBulk);
%     YB=PortInf{i,3}+Rmax*EmissionSumPort(1,i)/EmissionSumMax*cos(thetaBulk);
%     PortEmission(k,1).Geometry='Polygon';
%     PortEmission(k,1).BoundingBox=[min(XB),min(YB);max(XB),max(YB)];
%     PortEmission(k,1).X=[PortInf{i,2},XB,PortInf{i,2},nan];
%     PortEmission(k,1).Y=[PortInf{i,3},YB,PortInf{i,3},nan];
%     PortEmission(k,1).PortN=PortInf{i,5};
% 
%     %% Liquid
%     k=k+1;
%     XL=PortInf{i,2}+Rmax*EmissionSumPort(1,i)/EmissionSumMax*sin(thetaLiquid);
%     YL=PortInf{i,3}+Rmax*EmissionSumPort(1,i)/EmissionSumMax*cos(thetaLiquid);
%     PortEmission(k,1).Geometry='Polygon';
%     PortEmission(k,1).BoundingBox=[min(XL),min(YL);max(XL),max(YL)];
%     PortEmission(k,1).X=[PortInf{i,2},XL,PortInf{i,2},nan];
%     PortEmission(k,1).Y=[PortInf{i,3},YL,PortInf{i,3},nan];
%     PortEmission(k,1).PortN=PortInf{i,5};
% end
% shapewrite(PortEmission(1:3:48),'AllShapeFiles\EmissionContainerPort.shp');
% shapewrite(PortEmission(2:3:48),'AllShapeFiles\EmissionBulkPort.shp');
% shapewrite(PortEmission(3:3:48),'AllShapeFiles\EmissionLiquidPort.shp');
% 
% %% Leg emissions are represented by line width
% AnnualEmissionAllocationContainerLeg=zeros(size(PortInf,1),size(PortInf,1));
% for k=1:7
%     AnnualEmissionAllocationContainerLeg=AnnualEmissionAllocationContainerLeg+EmissionAllocationLeg{k};
% end
% AnnualEmissionAllocationBulkLeg=zeros(size(PortInf,1),size(PortInf,1));
% for k=8:14
%     AnnualEmissionAllocationBulkLeg=AnnualEmissionAllocationBulkLeg+EmissionAllocationLeg{k};
% end
% AnnualEmissionAllocationLiquidLeg=zeros(size(PortInf,1),size(PortInf,1));
% for k=15:22
%     AnnualEmissionAllocationLiquidLeg=AnnualEmissionAllocationLiquidLeg+EmissionAllocationLeg{k};
% end
% LegEmission=struct();
% EmissionLegSum=AnnualEmissionAllocationContainerLeg+AnnualEmissionAllocationBulkLeg+AnnualEmissionAllocationLiquidLeg;
% EmissionLegSumMax=max(max(EmissionLegSum));
% LineWidthMax=4;
% k=0;
% for i=1:size(PortInf,1) 
%     for j=1:size(PortInf,1) 
%         if i~=j
%             k=k+1;
%             l=find((SilkRoadPortPairs(:,1)==i & SilkRoadPortPairs(:,2)==j) | (SilkRoadPortPairs(:,1)==j & SilkRoadPortPairs(:,2)==i));
%             LegEmission(k,1).Geometry='Line';
%             LegEmission(k,1).X=SilkRoadTrajactory(l).X;
%             LegEmission(k,1).Y=SilkRoadTrajactory(l).Y;
%             LegEmission(k,1).Width=EmissionLegSum(i,j)/max(EmissionLegSumMax)*LineWidthMax;
%             LegEmission(k,1).EmissionQuantity=EmissionLegSum(i,j);
%         end
%     end
% end
% shapewrite(LegEmission,'AllShapeFiles\EmissionLegs.shp');  

%% Source analysis of leg emissions
%% Contour plot
% hold on
% contour(round(AnnualEmissionAllocationContainerLeg*1e-6,1),100,'Color','b','ShowText','off','LabelFormat','%0.1f','Fill','on','FaceAlpha',1,'LineStyle','none')
% contour(round(AnnualEmissionAllocationBulkLeg*1e-6,1),100,'Color','r','ShowText','off','LabelFormat','%0.1f','Fill','on','FaceAlpha',0.6,'LineStyle','--')
% contour(round(AnnualEmissionAllocationLiquidLeg*1e-6,1),100,'Color','g','ShowText','off','LabelFormat','%0.1f','Fill','on','FaceAlpha',0.6,'LineStyle','-')
% xtick=[1:16];
% for i=1:length(xtick)
%     xtickname{i,1}=PortInf{i,5};
% end
% set(gca,'xtick',xtick)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% 
% ytick=[1:16];
% for i=1:length(ytick)
%     ytickname{i,1}=PortInf{i,5};
% end
% set(gca,'ytick',ytick)
% set(gca,'YTickLabel',ytickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% box on
% hold off

% %% barh
% EmissionLegByPortPair=[];
% ytick=[];
% yticknameL={};
% yticknameR={};
% k=0;
% for i=1:size(PortInf,1)
%     for j=1:size(PortInf,1)
%         if i~=j
%             k=k+1;
%             EmissionLegByPortPair(k,1)=i;
%             EmissionLegByPortPair(k,2)=j;
%             for m=1:length(EmissionAllocationLeg)
%                 EmissionLegByPortPair(k,m+2)=EmissionAllocationLeg{m}(i,j);
%             end
%         end
%     end
% end
% barwMax=ceil(max(sum(EmissionLegByPortPair(:,3:size(EmissionLegByPortPair,2)),2)));
% groupH=1;
% barH=0.8*groupH;
% barout=0.2*groupH;
% TargetPort=[1,5,6,]
% for k=1:size(EmissionLegByPortPair,1)
%     Y=[groupH*(k-1)+barout,groupH*(k-1)+barout+barH,groupH*(k-1)+barout+barH,groupH*(k-1)+barout,groupH*(k-1)+barout];
%     a=0;
%     for m=1:7
%         X=[a,a,a+EmissionLegByPortPair(k,m+2),a+EmissionLegByPortPair(k,m+2),a];
%         patch(X,Y,'b','FaceAlpha',0.3+0.1*m,'EdgeColor','k','LineWidth',0.5);
%         a=a+EmissionLegByPortPair(k,m+2);
%     end
%     for m=8:14
%         X=[a,a,a+EmissionLegByPortPair(k,m+2),a+EmissionLegByPortPair(k,m+2),a];
%         patch(X,Y,'g','FaceAlpha',0.3+0.1*(m-7),'EdgeColor','k','LineWidth',0.5);
%         a=a+EmissionLegByPortPair(k,m+2);
%     end
%     for m=15:22
%         X=[a,a,a+EmissionLegByPortPair(k,m+2),a+EmissionLegByPortPair(k,m+2),a];
%         patch(X,Y,'r','FaceAlpha',0.2+0.1*(m-14),'EdgeColor','k','LineWidth',0.5);
%         a=a+EmissionLegByPortPair(k,m+2);
%     end
%     yticknameL{k,1}=PortInf{EmissionLegByPortPair(k,1),5};
%     yticknameR{k,1}=PortInf{EmissionLegByPortPair(k,2),5};
%     % text(barwMax,ytick(k,1),yticknameR{k,1},'FontName','Times new roman','FontSize',18)
% end
% 
% set(gca,'ytick',ytick)
% set(gca,'YTickLabel',[],'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% ylim([0,groupH*size(EmissionLegByPortPair,1)])
% grid on
% box on
% hold off

% %% circle fill
% figure(1)
% Rin=1;
% Rout=2;
% TargetPortpair=[226,231,90,80,237,12,72,180,181,81,91,61,185,65,75];%,230,234,96,170,227,235,108,4,135];
% for k=1:length(TargetPortpair)
%     subplot(5,3,k)
%     hold on
%     TargetPortpairName{k,1}=PortInf{EmissionLegByPortPair(TargetPortpair(k),1),5};
%     TargetPortpairName{k,2}=PortInf{EmissionLegByPortPair(TargetPortpair(k),2),5};
%     A=EmissionLegByPortPair(TargetPortpair(k),3:size(EmissionLegByPortPair,2));
%     Aangle=A/sum(A)*2*pi;
%     theta1=0;
%     theta2=0;
%     for i=1:7
%         theta2=theta2+Aangle(i);
%         theta=linspace(theta1,theta2,100);
%         X=[Rin*cos(theta), flip(Rout*cos(theta))];
%         Y=[Rin*sin(theta), flip(Rout*sin(theta))];
%         patch(X,Y,'b','FaceAlpha',0.3+0.1*i,'EdgeColor','k','LineWidth',0.5);
%         theta1=theta2;
%     end
%     for i=8:14
%         theta2=theta2+Aangle(i);
%         theta=linspace(theta1,theta2,100);
%         X=[Rin*cos(theta), flip(Rout*cos(theta))];
%         Y=[Rin*sin(theta), flip(Rout*sin(theta))];
%         patch(X,Y,'g','FaceAlpha',0.3+0.1*(i-7),'EdgeColor','k','LineWidth',0.5);
%         theta1=theta2;
%     end
%     for i=15:22
%         theta2=theta2+Aangle(i);
%         theta=linspace(theta1,theta2,100);
%         X=[Rin*cos(theta), flip(Rout*cos(theta))];
%         Y=[Rin*sin(theta), flip(Rout*sin(theta))];
%         patch(X,Y,'r','FaceAlpha',0.2+0.1*(i-14),'EdgeColor','k','LineWidth',0.5);
%         theta1=theta2;
%     end
%     set(gca,'ytick',[])
%     set(gca,'xtick',[])
%     text(-Rin/2,-Rin/2,[num2str(round(sum(A),0)) ' tons'],'FontName','Times new roman','FontSize',12)
%     text(-Rin/2,+Rin/2,[TargetPortpairName{k,1} '->' TargetPortpairName{k,2}],'FontName','Times new roman','FontSize',12)
%     box on    
%     hold off
% end
%% Port GLH allocation and allocation area chart by port
% AnnualGLHAllocationContainerPort=zeros(1,size(PortInf,1));
% for k=1:7
%     AnnualGLHAllocationContainerPort=AnnualGLHAllocationContainerPort+GLHAllocationPort{k};
% end
% AnnualGLHAllocationBulkPort=zeros(1,size(PortInf,1));
% for k=8:14
%     AnnualGLHAllocationBulkPort=AnnualGLHAllocationBulkPort+GLHAllocationPort{k};
% end
% AnnualGLHAllocationLiquidPort=zeros(1,size(PortInf,1));
% for k=15:22
%     AnnualGLHAllocationLiquidPort=AnnualGLHAllocationLiquidPort+GLHAllocationPort{k};
% end
% GLHPort=[];
% GLHPort=[AnnualGLHAllocationContainerPort;AnnualGLHAllocationBulkPort;AnnualGLHAllocationLiquidPort];
% GLHPortMax=max(max(sum(GLHPort)));
% BarHeight=GLHPortMax;
% rho=0.4;
% GLHBunkeringInfrastrutureNum=GLHInfrastrutureNumByPort;
% GLHBunkeringInfrastrutureNum(:,3)=GLHBunkeringVesselByPort(:,1);
% GLHBunkeringInfrastrutureNumMax=max(sum(GLHBunkeringInfrastrutureNum));
% a=GLHBunkeringInfrastrutureNum/GLHBunkeringInfrastrutureNumMax*BarHeight;
% X=[1:16];
% hold on
% area(X,GLHPort')
% for i=1:length(X)
%     x=[i-0.2,i+0.2,i+0.2,i-0.2,i-0.2];
%     y=[GLHPortMax+rho*BarHeight-a(i,1),GLHPortMax+rho*BarHeight-a(i,1),GLHPortMax+rho*BarHeight,GLHPortMax+rho*BarHeight,GLHPortMax+rho*BarHeight-a(i,1)];
%     patch(x,y,'r','FaceAlpha',1);
% 
%     x=[i-0.2,i+0.2,i+0.2,i-0.2,i-0.2];
%     y=[GLHPortMax+rho*BarHeight-a(i,1)-a(i,2),GLHPortMax+rho*BarHeight-a(i,1)-a(i,2),GLHPortMax+rho*BarHeight-a(i,1),GLHPortMax+rho*BarHeight-a(i,1),GLHPortMax+rho*BarHeight-a(i,1)-a(i,2)];
%     patch(x,y,'b','FaceAlpha',1);
% 
%     x=[i-0.2,i+0.2,i+0.2,i-0.2,i-0.2];
%     y=[GLHPortMax+rho*BarHeight-a(i,1)-a(i,2)-a(i,3),GLHPortMax+rho*BarHeight-a(i,1)-a(i,2)-a(i,3),GLHPortMax+rho*BarHeight-a(i,1)-a(i,2),GLHPortMax+rho*BarHeight-a(i,1)-a(i,2),GLHPortMax+rho*BarHeight-a(i,1)-a(i,2)-a(i,3)];
%     patch(x,y,'g','FaceAlpha',1);
% 
% end
% 
% for i=1:length(X)
%     xtickname{i,1}=PortInf{i,5};
% end
% set(gca,'xtick',X)
% set(gca,'XTickLabel',xtickname,'FontName','Times new roman','FontSize',18,'LineWidth',1.5);
% xlim([1-0.2,16+0.2])
% ytick=[0:2:10]*1e5;
% set(gca,'ytick',ytick)
% ylim([0,GLHPortMax+rho*BarHeight])
% grid on
% box on
% hold off
% 
% %% 4. Evaluation: total system emissions (valued at current China carbon price), total fuel use, GLH consumption, total ship investment, and total infrastructure investment (positive/negative bars)
% BarGroupGap=6;
% BarWidth=BarGroupGap/4;
% BarGapIn=BarWidth*0.2;
% BarGapOut=BarGroupGap*0.5;
% hold on
% %% cost saving: emission reduction
% CarbonPrice=100/6;%%USD/ton
% AnnualCarbonCost=CarbonPrice*(sum(ShipInf(:,20))+sum(ShipInf(:,21)))*1e-6;
% DecarbonizationCost(1,1)=-AnnualCarbonCost;
% X=[0,BarWidth,BarWidth,0,0];
% Y=[0,0,DecarbonizationCost(1,1),DecarbonizationCost(1,1),0];
% patch(X,Y,'k','FaceAlpha',0.7);
% 
% %% cost saving: oil consumption
% DecarbonizationCost(2,1)=-sum(ShipInf(1:7,22));
% X=[BarWidth+BarGapOut,2*BarWidth+BarGapOut,2*BarWidth+BarGapOut,BarWidth+BarGapOut,BarWidth+BarGapOut];
% Y=[0,0,DecarbonizationCost(2,1),DecarbonizationCost(2,1),0];
% patch(X,Y,'k','FaceAlpha',0.7);
% DecarbonizationCost(3,1)=-sum(ShipInf(8:14,22));
% X=[2*BarWidth+BarGapOut+BarGapIn,3*BarWidth+BarGapOut+BarGapIn,3*BarWidth+BarGapOut+BarGapIn,2*BarWidth+BarGapOut+BarGapIn,2*BarWidth+BarGapOut+BarGapIn];
% Y=[0,0,DecarbonizationCost(3,1),DecarbonizationCost(3,1),0];
% patch(X,Y,'k','FaceAlpha',0.7);
% DecarbonizationCost(4,1)=-sum(ShipInf(15:22,22));
% X=[3*BarWidth+BarGapOut+2*BarGapIn,4*BarWidth+BarGapOut+2*BarGapIn,4*BarWidth+BarGapOut+2*BarGapIn,3*BarWidth+BarGapOut+2*BarGapIn,3*BarWidth+BarGapOut+2*BarGapIn];
% Y=[0,0,DecarbonizationCost(4,1),DecarbonizationCost(4,1),0];
% patch(X,Y,'k','FaceAlpha',0.7);
% 
% %% cost: GLH consumption
% DecarbonizationCost(5,1)=sum(ShipInf(1:7,23));
% X=[BarWidth+BarGapOut,2*BarWidth+BarGapOut,2*BarWidth+BarGapOut,BarWidth+BarGapOut,BarWidth+BarGapOut];
% Y=[0,0,DecarbonizationCost(5,1),DecarbonizationCost(5,1),0];
% patch(X,Y,'b','FaceAlpha',0.7);
% DecarbonizationCost(6,1)=sum(ShipInf(8:14,23));
% X=[2*BarWidth+BarGapOut+BarGapIn,3*BarWidth+BarGapOut+BarGapIn,3*BarWidth+BarGapOut+BarGapIn,2*BarWidth+BarGapOut+BarGapIn,2*BarWidth+BarGapOut+BarGapIn];
% Y=[0,0,DecarbonizationCost(6,1),DecarbonizationCost(6,1),0];
% patch(X,Y,'g','FaceAlpha',0.7);
% DecarbonizationCost(7,1)=sum(ShipInf(15:22,23));
% X=[3*BarWidth+BarGapOut+2*BarGapIn,4*BarWidth+BarGapOut+2*BarGapIn,4*BarWidth+BarGapOut+2*BarGapIn,3*BarWidth+BarGapOut+2*BarGapIn,3*BarWidth+BarGapOut+2*BarGapIn];
% Y=[0,0,DecarbonizationCost(7,1),DecarbonizationCost(7,1),0];
% patch(X,Y,'r','FaceAlpha',0.7);
% 
% %% cost: ship retrofitting
% DecarbonizationCost(8,1)=0;
% a=0;
% for i=1:7
%     X=[4*BarWidth+2*BarGapOut+2*BarGapIn,5*BarWidth+2*BarGapOut+2*BarGapIn,5*BarWidth+2*BarGapOut+2*BarGapIn,4*BarWidth+2*BarGapOut+2*BarGapIn,4*BarWidth+2*BarGapOut+2*BarGapIn];
%     a=DecarbonizationCost(8,1);
%     DecarbonizationCost(8,1)=DecarbonizationCost(8,1)+ShipInf(i,24);
%     Y=[a,a,DecarbonizationCost(8,1),DecarbonizationCost(8,1),a];
%     patch(X,Y,'b','FaceAlpha',0.3+0.1*i,'EdgeColor','k','LineWidth',0.5);
% end
% DecarbonizationCost(9,1)=0;
% a=0;
% for i=8:14
%     X=[5*BarWidth+2*BarGapOut+3*BarGapIn,6*BarWidth+2*BarGapOut+3*BarGapIn,6*BarWidth+2*BarGapOut+3*BarGapIn,5*BarWidth+2*BarGapOut+3*BarGapIn,5*BarWidth+2*BarGapOut+3*BarGapIn];
%     a=DecarbonizationCost(9,1);
%     DecarbonizationCost(9,1)=DecarbonizationCost(9,1)+ShipInf(i,24);
%     Y=[a,a,DecarbonizationCost(9,1),DecarbonizationCost(9,1),a];
%     patch(X,Y,'g','FaceAlpha',0.3+0.1*(i-7),'EdgeColor','k','LineWidth',0.5);
% end
% DecarbonizationCost(10,1)=0;
% a=0;
% for i=15:22
%     X=[6*BarWidth+2*BarGapOut+4*BarGapIn,7*BarWidth+2*BarGapOut+4*BarGapIn,7*BarWidth+2*BarGapOut+4*BarGapIn,6*BarWidth+2*BarGapOut+4*BarGapIn,6*BarWidth+2*BarGapOut+4*BarGapIn];
%     a=DecarbonizationCost(10,1);
%     DecarbonizationCost(10,1)=DecarbonizationCost(10,1)+ShipInf(i,24);
%     Y=[a,a,DecarbonizationCost(10,1),DecarbonizationCost(10,1),a];
%     patch(X,Y,'r','FaceAlpha',0.2+0.1*(i-14),'EdgeColor','k','LineWidth',0.5);
% end
% 
% %% cost: port bunkering infrastructure
% DecarbonizationCost(11,1)=sum(GLHBunkeringVesselByPort(:,2));
% X=[7*BarWidth+3*BarGapOut+4*BarGapIn,8*BarWidth+3*BarGapOut+4*BarGapIn,8*BarWidth+3*BarGapOut+4*BarGapIn,7*BarWidth+3*BarGapOut+4*BarGapIn,7*BarWidth+3*BarGapOut+4*BarGapIn];
% Y=[0,0,DecarbonizationCost(11,1),DecarbonizationCost(11,1),0];
% patch(X,Y,'c','FaceAlpha',0.7);
% DecarbonizationCost(12,1)=sum(GLHInfrastrutureCostByPort);
% X=[8*BarWidth+3*BarGapOut+5*BarGapIn,9*BarWidth+3*BarGapOut+5*BarGapIn,9*BarWidth+3*BarGapOut+5*BarGapIn,8*BarWidth+3*BarGapOut+5*BarGapIn,8*BarWidth+3*BarGapOut+5*BarGapIn];
% Y=[0,0,DecarbonizationCost(12,1),DecarbonizationCost(12,1),0];
% patch(X,Y,'c','FaceAlpha',0.7);
% set(gca,'xtick',[])
% set(gca,'FontSize',18,'LineWidth',1.5);
% grid on
% box on
% hold off
% % 
