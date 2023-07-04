clc;clear;
data=readmatrix("medical_data.xlsx",Sheet="data_2019");
total_area=1664900;%平方千米
total_popula_2019=2523.22;%万人
total_popula_2020=2585;
clinc_2019=15645;
clinc_2020=15631;
clinc=[clinc_2019,clinc_2020];
docter_2019=122907;	
docter_2020=127049;
docter=[docter_2019,docter_2020];
nurse_2019=158818;
nurse_2020=163177;
nurse=[nurse_2019,nurse_2020];
pop_prec_2019=data(:,2)/total_popula_2019;
pop_prec_2020=data(:,2)/total_popula_2020;
area_pre=data(:,3)/total_area;
all_healthy=[clinc,docter,nurse];
%% 2019年按人口的泰尔指数

k=[1 3 5 7];
m=1;
for j=4:6
    healthy_prec=data(:,j)/all_healthy(m);
    Theil_L=0;
    T_n=0;
    T_J=0;
    for i=1:14
        temp_1=pop_prec_2019(i)*log10(pop_prec_2019(i)/healthy_prec(i));
        Theil_L=Theil_L+temp_1;
        
        temp_2=pop_prec_2019(i)*Theil_L;
        T_J=T_J+temp_2;

        temp_3=pop_prec_2019(i)*log10(pop_prec_2019(i)/Theil_L);
        T_n=T_n+temp_3;
    end
    T_n
    T_J
end
    
%% 2019年按面积的泰尔指数
for j=4:7
    healthy_prec=data(:,j)/clinc(1);
    Theil_L=0;
    T_n=0;
    T_J=0;
    for i=1:14
        temp_1=pop_prec(i)*log10(pop_prec(i)/healthy_prec(i));
        Theil_L=Theil_L+temp_1;
        
        temp_2=pop_prec(i)*Theil_L;
        T_J=T_J+temp_2;

        temp_3=pop_prec(i)*log10(pop_prec(i)/Theil_L);
        T_n=T_n+temp_3;
    end
    T_n
    T_J
end
