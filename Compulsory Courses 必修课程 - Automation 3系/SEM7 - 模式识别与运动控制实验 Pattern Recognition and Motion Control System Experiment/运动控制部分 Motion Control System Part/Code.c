#include<graphics.h> 
#include<conio.h> 
#include<stdio.h> 
#include<math.h> 
#include<string.h> 
#include<dos.h> 
#include<bios.h> 

#define false 0 
#define true 1 
#define plate1_x 50 
#define plate1_y 50 
#define plate2_x 230 
#define plate2_y 50 
#define plate_l 150 
#define plate_h 56 
#define plate_radius 55 
#define scope_left 45 
#define scope_right 384 
#define scope_top 285 
#define scope_bottom 460 
#define ruler_x 45 
#define ruler_y 165 
#define ruler1_x 45 
#define ruler1_y 190 
#define ruler2_x 45 
#define ruler2_y 215 
#define ruler 
#define ruler_cenx 215 
#define ruler_l 340 
#define plate1_cenx 125 
#define plate1_ceny 50 
#define plate2_cenx 305 
#define plate2_ceny 50 

float N1; 

int canRefresh = 0; 
double now_scope_x = scope_left; 
double now_scope_yp = (scope_bottom + scope_top) / 2; 
double now_scope_yv = (scope_bottom + scope_top) / 2; 
double now_scope_ya = (scope_bottom + scope_top) / 2; 
double now_plate1_x = plate1_cenx; 
double now_plate1_y = plate1_ceny; 
double now_plate2_x = plate2_cenx; 
double now_plate2_y = plate2_ceny; 
double last_ruler = ruler_cenx; 
double last_ruler1 = ruler_cenx; 
double last_ruler2 = ruler_cenx; 
double last_ruler3 = ruler_cenx; 
int starts = 0; 

float t_sw = 0; 
int s_sw = 0; 
int s_sw1 = 0; 

void showText(float data, double x, double y); 
void scr_init(); 
void scope_init(double left, double right, double top, double bottom); 
void draw_plate(double cenx, double ceny, double radius, int z);
void draw_ruler(double x, double y, double l); 
void plate_init(); 
void update_data(float p, float vm, float am, float det_time, float v, float a); 
void scr_close(); 

float adc(unsigned int a); 
float adc1(unsigned int a); 
void interrupt(*oldint)(); 
void interrupt newint(); 
void initinterrupt(); 

float K1, K2, K3, K4, K5; 
float Q1 = 0; 
float Q2 = 0; 
float Q3 = 0; 
float Q4 = 0; 
float Q40 = 0; 
float Q; 
float vm = 0; 
float am = 0; 

float max_a = 10; 
float max_v = 10; 
float max_p = 10; 

void main() 
{ 
    float k1 = 0.045625; 
    float k2 = -0.13; 
    float k3 = -0.15; 
    float k4 = 0.42; 
    float k5 = 0.5; 
    char ch; 
    Q40 = adc1(3); 
    Q40 = adc1(3); 
    Q40 = adc1(3); 
    Q40 = adc1(3); 
    scr_init(); 
    K1 = k1; 
    K2 = k2; 
    K3 = k3; 
    K4 = k4; 
    K5 = k5; 
    initinterrupt(); 
    while (1) { 
        if (kbhit) 
            ch = getch(); 
        if (ch == ' ') 
            break; 
        if (ch == 'r')canRefresh = 1; 
    }
    outportb(0x21, inport(0x21) | 0x08); 
    setvect(0xb, oldint); 
    scr_close(); 
}

void dac(float da) 
{ 
    long int y, low, high, newhigh, newlow; 
    y = (da + 1) / 2 * 0xfff0; 
    low = y & 0x00ff; 
    high = (y & 0xff00) / 256; 
    newhigh = (high & 0x000f) * 16 + (high & 0x00f0) / 16; 
    outportb(0x314, newhigh); 
    newlow = (low & 0x00f0) / 16; 
    outportb(0x315, newlow); 
    inportb(0x315);
} 

float adc(unsigned int a) 
{ 
    unsigned int p = 0, q = 0, i = 0; 
    unsigned int r = 0; 
    float ad = 0; 
    char str[30]; 
    outportb(0x31b, 0x18);
    outportb(0x310, a); 
    for (i = 0; i < 4000; i++); 
    outportb(0x311, 0x0); 
    for (i = 0; i < 4000; i++); 
    p = inportb(0x312) % 16; 
    q = inportb(0x313); 
    r = p * 256 + q; 
    printf("port: %d\n", a); 
    printf("%04x\n", r); 
    itoa(r, str, 2); 
    printf("%s\n", str); 
    ad = (float)(r) / 0x800 - 1; 
    printf("%f\n", ad); 
    printf("%f V\n", ad * 10); 
    printf("\n"); 
    return ad; 
}

float adc1(unsigned int a) 
{ 
    unsigned int p = 0, q = 0, i = 0; 
    unsigned int r = 0; 
    float ad = 0; 
    outportb(0x31b, 0x18); 
    outportb(0x310, a); 
    for (i = 0; i < 4000; i++); 
    outportb(0x311, 0x0); 
    for (i = 0; i < 4000; i++); 
    p = inportb(0x312) % 16; 
    q = inportb(0x313); 
    r = p * 256 + q; 
    ad = (float)(r) / 0x800 - 1; 
    return ad; 
}

void interrupt newint() 
{ 
    float E; 
    Q1 = adc1(0); 
    Q1 = adc1(0); 
    Q2 = adc1(1); 
    Q2 = adc1(1); 
    Q3 = adc1(2); 
    Q3 = adc1(2); 
    Q4 = adc1(3) - Q40; 
    Q4 = adc1(3) - Q40; 
    
    if (fabs(Q3) > fabs(vm))vm = Q3; 
    if (fabs(Q4) > fabs(am))am = Q4; 
    if (fabs(am) > 10)am = -9.812; 
    Q = K4 * Q4 + K3 * Q3 + K2 * Q2 + K1 * Q1;
    E = Q * 32; 
    if (E > K5)E = K5; 
    else if (E < -K5)E = -K5; 
    else if (fabs(E) < 0.08)E = 0; 
    else E = E; 
    dac(2.0 * E); 
    update_data(Q2 * 800 / 15.92, vm * 10.987, am * 540 / 3.18, 0.020, Q3 * (10.987), Q4 * 540 / 3.18 * 6); 
    outportb(0x20, 0x20); 
} 

void initinterrupt() 
{ 
    oldint = getvect(0xb); 
    setvect(0xb, newint); 
    disable(); 
    outportb(0x31b, 0xb6); 
    outportb(0x31a, 0x40); 
    outportb(0x31a, 0x9c); 
    outportb(0x21, inportb(0x21) & 0xf7); 
    enable(); 
}

void showText(float data, double x, double y) 
{ 
    int sign, shi, ge, shifen, baifen, qianfen; 
    int index = 0; 
    char dataTextT[100] = { ' ',' ',' ',' ',' ',' ',' ','\0' }; 
    setcolor(BLACK); 
    bar(x, y, x + 55, y + 20); 
    if (fabs(data) >= 100.0)dataTextT[0] = 'I'; 
    else if (fabs(data) <= 0.001)dataTextT[0] = 'N'; 
    else 
    { 
        if (data < 0)sign = 1; 
        else sign = 0; 
        data = fabs(data); 
        shi = (int)(data / 10.0); 
        data -= shi * 10.0;
        ge = (int)(data); 
        data -= ge; shifen = (int)(data * 10.0); 
        data -= shifen / 10.0; 
        baifen = (int)(data * 100.0); 
        data -= baifen / 100.0; 
        qianfen = (int)(data * 1000.0); 
        if (sign == 1)dataTextT[index] = '-'; 
        else dataTextT[index] = ' '; 
        index++; 
        if (shi != 0) 
        { 
            dataTextT[index] = shi + 0x30; 
            index++; 
            dataTextT[index] = ge + 0x30; 
            index++; 
            dataTextT[index] = '.'; 
            index++; 
            dataTextT[index] = shifen + 0x30; 
            index++; 
            dataTextT[index] = baifen + 0x30; 
        }
        else if (ge != 0) 
        { 
            dataTextT[index] = ge + 0x30; 
            index++; 
            dataTextT[index] = '.'; 
            index++; 
            dataTextT[index] = shifen + 0x30; 
            index++; 
            dataTextT[index] = baifen + 0x30; 
            index++; dataTextT[index] = qianfen + 0x30; 
        }
        else 
        { 
            dataTextT[index] = 0x30; 
            index++; 
            dataTextT[index] = '.'; 
            index++; 
            dataTextT[index] = shifen + 0x30; 
            index++; 
            dataTextT[index] = baifen + 0x30; 
            index++; 
            dataTextT[index] = qianfen + 0x30; 
        } 
    }
    setcolor(RED); 
    outtextxy(x, y, dataTextT); 
}

void scr_init()
{ 
    int gd = DETECT, gm, i; 

    initgraph(&gd, &gm, ""); 
    cleardevice(); 
    setbkcolor(WHITE); 
    bar(0, 0, 639, 479); 
    
    scope_init(scope_left, scope_right, scope_top, scope_bottom); 
    plate_init(); 
}

void scope_init(double left, double right, double top, double bottom) 
{   
    //left: 
    //right: 
    //top: 
    //bottom: 
    double width = right - left; 
    double height = bottom - top; 
    double dw = width / 10.0; 
    double dh = height / 10.0; 
    int i = 0; 
    char time[3] = { '0','s','\0' }; 
    char posvoltage[2] = { '0','\0' }; 
    char negvoltage[3] = { '-','1','\0' }; 
    
    setcolor(BLUE); 
    setlinestyle(0, 0, 2); 
    rectangle(left, top, right, bottom); 
    line(left, top + dh * 5, right, top + dh * 5);
    
    setcolor(RED); 
    setlinestyle(1, 0, 1); 
    for (i = 1; i < 10; i++)if (i != 5)line(left, top + dh * i, right, top + dh * i); 
    for (i = 1; i < 10; i++)line(left + dw * i, top, left + dw * i, bottom); 
    
    for (i = 0; i < 10; i++) 
    {
        time[0] = 0x30 + i; 
        outtextxy(2 + (left + dw * i), 2 + (top + dh * 5.0), time); 
    }
    for (i = 0; i < 6; i++) 
    { 
        posvoltage[0] = 0x30 + i; 
        outtextxy(-20 + left, (-dh / 2 + top + dh * (5.0 - i)), posvoltage); 
    }
    for (i = 1; i < 6; i++) 
    { 
        negvoltage[1] = 0x30 + i; 
        outtextxy(-30 + left, (-dh / 2 + top + dh * (5.0 + i)), negvoltage); 
    } 
}

void draw_plate(double x, double y, double radius, int z) 
{ 
    //cenx: 
    //ceny: 
    //radius: 
    double ang = 90; 
    double cenx, ceny1, ceny2; 
    char angleTxt0[2] = { '0','\0' }; 
    char angleTxtn15[4] = { '-','1','5','\0' }; 
    char angleTxt15[3] = { '1','5','\0' };
    char angleTxt6[4] = { '0','.','6','\0' }; 
    char angleTxtn6[5] = { '-','0','.','6','\0' }; 
    cenx = x + plate_l / 2; 
    ceny1 = y + plate_h; 
    ceny2 = y; 
    
    setlinestyle(0, 0, 2); 
    rectangle(x, y, x + plate_l, y + plate_h); 
    
    if (z == 1) 
    { 
        setcolor(BLUE); 
        setlinestyle(0, 0, 2); 
        arc(x + plate_l / 2, y + plate_h, 0, 180, radius); 
        
        for (ang = -90; ang <= 90; ang += 30)line(cenx - radius * 0.9 * sin(ang / 180.0 * 3.14), ceny1 - radius * 0.9 * cos(ang / 180.0 * 3.14), cenx - radius * sin(ang / 180.0 * 3.14), ceny1 - radius * cos(ang / 180.0 * 3.14)); 
        ang = 90; 
        outtextxy(-25 + cenx - radius * sin(ang / 180.0 * 3.14), -10 + ceny1 - radius * cos(ang / 180.0 * 3.14), angleTxtn6);
        ang = -90; 
        outtextxy(5 + cenx - radius * sin(ang / 180.0 * 3.14), -10 + ceny1 - radius * cos(ang / 180.0 * 3.14), angleTxt6); 
    }
    else if (z == 2) 
    { 
        setcolor(BLUE); 
        setlinestyle(0, 0, 2); 
        arc(x + plate_l / 2, y, -180, 0, radius); 
        
        for (ang = -270; ang <= -90; ang += 30)line(cenx - radius * 0.9 * sin(ang / 180.0 * 3.14), ceny2 - radius * 0.9 * cos(ang / 180.0 * 3.14), cenx - radius * sin(ang / 180.0 * 3.14), ceny2 - radius * cos(ang / 180.0 * 3.14)); 
        ang = 0; 
        outtextxy(-5 + cenx - radius * sin(ang / 180.0 * 3.14), -18 + ceny2 + radius * cos(ang / 180.0 * 3.14), angleTxt0);
        ang = 90; 
        outtextxy(-25 + cenx - radius * sin(ang / 180.0 * 3.14), -10 + ceny2 + radius * cos(ang / 180.0 * 3.14), angleTxtn15); 
        ang = -90; 
        outtextxy(5 + cenx - radius * sin(ang / 180.0 * 3.14), -10 + ceny2 + radius * cos(ang / 180.0 * 3.14), angleTxt15); 
    } 
}

void draw_ruler(double x, double y, double l) 
{ 
    double p; setcolor(BLUE); 
    setlinestyle(0, 0, 2); 
    line(x, y, x + l, y); 

    for (p = ruler_cenx; p <= 385; p = p + 34) 
    {
        line(p, y - 5, p, y + 5); 
    }
    for (p = ruler_cenx - 34; p >= 45; p = p - 34) 
    { 
        line(p, y - 5, p, y + 5); 
    } 
}

void plate_init() 
{
    draw_plate(plate1_x,plate1_y,plate_radius,2); 
    draw_plate(plate2_x,plate2_y,plate_radius,2); 

    draw_ruler(ruler_x, ruler_y, ruler_l); 
    draw_ruler(ruler1_x, ruler1_y, ruler_l); 
    draw_ruler(ruler2_x, ruler2_y, ruler_l); 
}

void update_data(float p, float vm, float am, float det_time, float v, float a) 
{ 
    float to_x1, to_y1, to_x2, to_y2, to_x, to_y; 
    float det_scope_x; 
    float now_ruler, now_ruler1, now_ruler2, now_ruler3; 
    int ty = 15; 
    char T1[4] = { 'K','1',':','\0' }; 
    char T2[4] = { 'K','2',':','\0' }; 
    char T3[4] = { 'K','3',':','\0' }; 
    char T4[3] = { 'P',':','\0' }; 
    char T5[4] = { 'V','m',':','\0' }; 
    char T6[4] = { 'a','m',':','\0' }; 
    char T7[3] = { 'T',':','\0' }; 
    char T8[5] = { 't','_','s','w','\0' }; 
    char T9[4] = { 'K','4',':','\0' }; 
    char T10[2] = { 'V','\0' }; 
    char T11[2] = { 'P','\0' }; 
    char T12[2] = { 'a','\0' }; 
    char T13[3] = { 'c','m','\0' }; 
    char T14[4] = { 'm','/','s','\0' }; 
    char T15[4] = { 'd','e','g','\0' }; 
    char T16[2] = { 's','\0' }; 
    char T17[4] = { 'V','m',':','\0' }; 
    char T18[4] = { 'a','m',':','\0' }; 

    if (a > 3)s_sw = 0; 
    if (a <= -3)s_sw = 1; 
    if (s_sw != s_sw1)t_sw = t_sw + 1.0; 
    s_sw1 = s_sw; 
    setlinestyle(0, 0, 1); 
    setcolor(BLUE); 
    
    outtextxy(415, ty, T4); 
    showText(p, 500, ty); 
    outtextxy(570, ty, T13); 
    ty = ty + 40; setcolor(BLUE); 
    
    outtextxy(415, ty, T5); 
    showText(vm, 500, ty); 
    outtextxy(570, ty, T14); 
    ty = ty + 40; 
    setcolor(BLUE); 
    
    outtextxy(415, ty, T6); 
    showText(am, 500, ty); 
    outtextxy(570, ty, T15); 
    ty = ty + 40; 
    setcolor(BLUE); 
    
    outtextxy(415, ty, T7); 
    showText(det_time, 500, ty); 
    outtextxy(570, ty, T16); 
    ty = ty + 40; 
    setcolor(BLUE); 
    
    outtextxy(415, ty, T8); 
    showText(t_sw / 2.0, 500, ty); 
    ty = ty + 40; 
    setcolor(BLUE); 
    
    outtextxy(415, ty, T1); 
    showText(K1, 500, ty); 
    ty = ty + 40; 
    setcolor(BLUE);
    
    outtextxy(415, ty, T2); 
    showText(K2, 500, ty); 
    ty = ty + 40; 
    setcolor(BLUE); 
    
    outtextxy(415, ty, T3); 
    showText(K3, 500, ty); 
    ty = ty + 40; 
    setcolor(BLUE); 
    
    outtextxy(415, ty, T9); 
    showText(K4, 500, ty);
    ty = ty + 40; 
    setcolor(BLUE); 
    
    showText(v, 500, ty); 
    ty = ty + 40; 
    
    outtextxy(30, 65, T10); 
    outtextxy(30, 160, T11); 
    outtextxy(30, 212, T12); 
    outtextxy(30, 185, T10); 
    outtextxy(210, 65, T12); 
    
    plate_init(); 
    setlinestyle(0,0,2); 
    setcolor(WHITE); 
    
    line(now_plate1_x,now_plate1_y,plate1_cenx,pl ate1_ceny); 
    line(now_plate2_x,now_plate2_y,plate2_cenx,pl ate2_ceny); 
    setcolor(RED); 
    
    to_x1=plate1_cenx+plate_radius*0.8*sin(-v* 90/0.6/180.0*3.1415926); 
    to_y1=plate1_ceny+plate_radius*0.8*cos(-v* 90/0.6/180.0*3.1415926); 
    to_x2=plate2_cenx+plate_radius*0.8*sin(-a/ 180.0*3.1415926); 
    to_y2=plate2_ceny+plate_radius*0.8*cos(-a/ 180.0*3.1415926); 
    line(plate1_cenx,plate1_ceny,to_x1,to_y1); 
    line(plate2_cenx,plate2_ceny,to_x2,to_y2); 
    
    now_plate1_x=to_x1; 
    now_plate1_y=to_y1; 
    now_plate2_x=to_x2; 
    now_plate2_y=to_y2; 
    
    setlinestyle(0, 0, 2); 
    setcolor(WHITE); 
    line(last_ruler, ruler_y, last_ruler - 5, ruler_y-10); 
    line(last_ruler, ruler_y, last_ruler + 5, ruler_y-10); 
    line(last_ruler - 5, ruler_y-10, last_ruler + 5, ruler_y-10); 
    line(last_ruler, ruler_y, last_ruler, ruler_y+10); 
    now_ruler = ruler_cenx + p * 34 / 10; setlinestyle(0, 0, 2); 
    setcolor(RED); 
    line(now_ruler, ruler_y, now_ruler - 5, ruler_y-10); 
    line(now_ruler, ruler_y, now_ruler + 5, ruler_y-10); 
    line(now_ruler - 5, ruler_y-10, now_ruler + 5, ruler_y-10); 
    line(now_ruler, ruler_y, now_ruler, ruler_y+10); 
    last_ruler = now_ruler; setlinestyle(0, 0, 2); 
    setcolor(WHITE); 
    line(last_ruler1, 145, last_ruler1 - 5, 135);
    line(last_ruler1, 145, last_ruler1 + 5, 135);
    line(last_ruler1 - 5, 135, last_ruler1 + 5, 135); 
    line(last_ruler1, 145, last_ruler1, 155); 
    now_ruler1 = ruler_cenx + p * 34 / 10; 
    setlinestyle(0, 0, 2); 
    setcolor(RED); 
    line(now_ruler1, 145, now_ruler1 - 5, 135);
    line(now_ruler1, 145, now_ruler1 + 5, 135);
    line(now_ruler1 - 5, 135, now_ruler1 + 5, 135); 
    line(now_ruler1, 145, now_ruler1, 155);
    last_ruler1 = now_ruler1; 

    setlinestyle(0, 0, 2); 
    setcolor(WHITE); 
    line(last_ruler2, ruler1_y, last_ruler2 - 5, ruler1_y-10);
    line(last_ruler2, ruler1_y, last_ruler2 + 5, ruler1_y-10); 
    line(last_ruler2 - 5, ruler1_y-10, last_ruler2 + 5, ruler1_y-10); 
    line(last_ruler2, ruler1_y, last_ruler2, ruler1_y+10); 
    now_ruler2 = ruler_cenx + v * 90 / 0.6 * 34 / 10; setlinestyle(0, 0, 2); 
    setcolor(RED); 
    line(now_ruler2, ruler1_y, now_ruler2 - 5, ruler1_y-10); 
    line(now_ruler2, ruler1_y, now_ruler2 + 5, ruler1_y-10); 
    line(now_ruler2 - 5, ruler1_y-10, now_ruler2 + 5, ruler1_y-10); 
    line(now_ruler2, ruler1_y, now_ruler2, ruler1_y+10); last_ruler2 = now_ruler2; 

    setlinestyle(0, 0, 2); 
    setcolor(WHITE); 
    line(last_ruler3, ruler2_y, last_ruler3 - 5, ruler2_y-10); 
    line(last_ruler3, ruler2_y, last_ruler3 + 5, ruler2_y-10); 
    line(last_ruler3 - 5, ruler2_y-10, last_ruler3 + 5, ruler2_y-10); 
    line(last_ruler3, ruler2_y, last_ruler3, ruler2_y+10); 
    now_ruler3 = ruler_cenx + a * 34 / 10; 

    setlinestyle(0, 0, 2); 
    setcolor(RED); 
    line(now_ruler3, ruler2_y, now_ruler3 - 5, ruler2_y-10); 
    line(now_ruler3, ruler2_y, now_ruler3 + 5, ruler2_y-10); 
    line(now_ruler3 - 5, ruler2_y-10, now_ruler3 + 5, ruler2_y-10); 
    line(now_ruler3, ruler2_y, now_ruler3, ruler2_y+10); 
    last_ruler3 = now_ruler3; 

    if (fabs(a) > 3)starts = 1; 
    if (starts) 
    { 
        det_scope_x = det_time * (float)(scope_right - scope_left) / 10.0; 
        if (now_scope_x + det_scope_x >= scope_right)
        { 
            if (canRefresh) 
            { 
                canRefresh = 0; 
                bar(scope_left,scope_top, scope_right, scope_bottom); 
                scope_init(scope_left, scope_right, scope_top, scope_bottom); 
                now_scope_x = scope_left; 
            }
            else return; 
        }
        to_x = now_scope_x + det_scope_x; 

        setcolor(GREEN); 
        to_y = (scope_top + scope_bottom) / 2 - p / 50.0 * ((scope_bottom - scope_top) / 2.0); 
        line(now_scope_x, now_scope_yp, to_x, to_y);
        now_scope_yp = to_y; 
        
        setcolor(BLUE); 
        to_y = (scope_top + scope_bottom) / 2 - a / 66.0 * ((scope_bottom - scope_top) / 2.0); 
        line(now_scope_x, now_scope_ya, to_x, to_y);
        now_scope_ya = to_y; now_scope_x = to_x; 
    } 
}

void scr_close() 
{ 
    closegraph(); 
}

