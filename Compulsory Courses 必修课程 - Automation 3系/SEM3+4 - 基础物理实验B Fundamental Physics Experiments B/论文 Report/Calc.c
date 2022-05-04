// 函数计算.cpp : 定义控制台应用程序的入口点。 

#include "stdafx.h" 
#include <stdio.h> 
#include <math.h> 
#include<stdlib.h> 

int main() 
{ 
    while (1) 
    { 
        double y1t2, y2t2, y2t3, y3t3, y1ti, y2ti, y3ti, a1, a2, a3, b1, b2, b3, c2, d2, e2, ti, t2, t3, m, Si, Sii = 0; 
        int i; 
        t2 = 180, t3 = 264; 
        a1 = -0.004266833, b1 = 35.65684; 
        a2 = -0.00000067039, b2 = 0.000622412, c2 = -0.212554301, d2 = 31.42526005, e2 = -1661.012445; 
        a3 = 0.002747096, b3 = 16.1588376; 
        
        i = 0; 
        m = 0.00001; 
        ti = 180; 
        y1t2 = ((a1 / 2.0)*pow(t2, 2) + b1*t2); 
        y2t2 = ((a2 / 5.0)*pow(t2, 5) + (b2 / 4.0)*pow(t2, 4) + (c2 / 3.0)*pow(t2, 3) + (d2 / 2.0)*pow(t2, 2) + e2*t2); 
        y2t3 = ((a2 / 5.0)*pow(t3, 5) + (b2 / 4.0)*pow(t3, 4) + (c2 / 3.0)*pow(t3, 3) + (d2 / 2.0)*pow(t3, 2) + e2*t3); 
        y3t3 = ((a3 / 2.0)*pow(t3, 2) + b3*t3);
        y1ti = ((a1 / 2.0)*pow(ti, 2) + b1*ti); 
        y2ti = ((a2 / 5.0)*pow(ti, 5) + (b2 / 4.0)*pow(ti, 4) + (c2 / 3.0)*pow(ti, 3) + (d2 / 2.0)*pow(ti, 2) + e2*ti); 
        y3ti = ((a3 / 2.0)*pow(ti, 2) + b3*ti); 
        Si = y2t3 - y3t3 - y2ti + y3ti; 
        Sii = Si; 
        
        do
        {
            i = i + 1; 
            ti = ti + m; 
            y1ti = ((a1 / 2.0)*pow(ti, 2) + b1*ti); 
            y2ti = ((a2 / 5.0)*pow(ti, 5) + (b2 / 4.0)*pow(ti, 4) + (c2 / 3.0)*pow(ti, 3) + (d2 / 2.0)*pow(ti, 2) + e2*ti); 
            y3ti = ((a3 / 2.0)*pow(ti, 2) + b3*ti); 
            Si = Sii; 
            Sii = y2t3 - y3t3 - y2ti + y3ti - y1ti + y2ti + y1t2 - y2t2; 
            
            printf("%lf %lf %lf %lf\n", y1ti, y2ti, y3ti, y2t2); 
            printf("S%d=%lf S%d+1=%lf\n", i-1, Si, i-1, Sii); 
        } while (Sii > 0); 

        printf("最终得到 t=%lf\n", ti); 
        break; 
    }
    
    system("pause"); 
    return 0; 
}