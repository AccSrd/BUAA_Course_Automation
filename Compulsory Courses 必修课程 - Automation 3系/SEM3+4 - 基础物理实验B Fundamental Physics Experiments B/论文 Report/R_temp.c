// 电阻温度.cpp : 定义控制台应用程序的入口点。 

#include"stdafx.h" 
#include <stdio.h> 
#include <math.h> 

int main() 
{ 
    while (1) 
    { 
        double A, B, T, R0, RT, a, b, c, t1, t2, disc, p, q; 
        printf("-----------------------Pt1000 铂电阻--温度换算软件---------------------"); 
        printf("请输入电阻值："); 
        scanf("%lf", &RT); 
        
        A = 3.90802e-3; 
        B = -5.80195e-7; 
        R0 = 1000.0; //代入常数数值 
        a = R0*B; 
        b = R0*A; 
        c = R0 - RT; 
        disc = b*b - 4.0 * a*c; 
        p = -b / (2.0*a); 
        q = sqrt(disc) / (2.0*a); 
        t1 = p + q; 
        t2 = p - q; 
        
        printf("T=%7.4lf\n", t1); 
    }
    return 0; 
}