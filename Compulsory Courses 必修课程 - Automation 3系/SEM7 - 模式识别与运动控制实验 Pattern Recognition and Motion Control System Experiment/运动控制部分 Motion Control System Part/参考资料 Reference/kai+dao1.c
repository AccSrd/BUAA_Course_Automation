/*     ʵ��                                             */
/*      ���ø�����ֵ                                    */
/*      ��ʼ���棬���ý��棬��ʾ����                    */
/*                                                      */
/*  �涨A/D��                                           */
/*      ͨ��13����С��λ�ö�Ӧ�ĵ�ѹ�����Ȧ��λ�ƣ�    */
/*      ͨ��5 ����С���ٶȶ�Ӧ�ĵ�ѹ                    */
/*      ͨ��14�����ڸ˽Ƕȶ�Ӧ�ĵ�ѹ              �     */
/*      ͨ��6 �����ڸ˽��ٶȶ�Ӧ�ĵ�ѹ            �     */
/*                                                      */
/*  ��ʾ��                                              */
/*      �졪��λ��(m)                                   */
/*      �̡����Ƕ�(����С10��)                          */
/*                                                      */



#include<stdio.h>                              /*ͷ�ļ�*/
#include<graphics.h>
#include<math.h>
#include<dos.h>
#include<conio.h>
#include<stdlib.h>
/*#include <iostream.h> */

#define grad1 4.628;                           /*��Ȧ��λ���ݶ�(V/m)��λ�÷���*/
#define grad2 0.23;                          /*С���ٶ��ݶ�(V.s/m)���ٶȷ���*/
#define grad3 3.30;                          /*��Ȧ��λ���ݶ�(V/rad)���ڽǷ���*/
#define grad4 0.18;                          /*�ڸ��ٶȷ����ݶ�(V/rad/s)���ڽ��ٶȷ���*/

void interrupt(*oldint)( );                  /*��������*/
void interrupt newint( );
float adc(int num );
void dac(float Volt);


float k0,k1,k2,k3;                           /*��������*/
float y0,y1,y11,yt0=0,yt1=01;
int m,i;                                       /*�жϴ���*/
 int t=0.015,N1,timer,ltimer;

void main()
{
int graphdriver = DETECT, graphmode, errorcode,ch;
 k0=907.3;  k1=45.706;   k2=636.39;  k3=209.79;    /*Ĭ�Ϸ���ϵ������*/
   /* request auto detection */

   /* initialize graphics mode */
   initgraph(&graphdriver, &graphmode, "");    /*d:\BORLANDC\my program\mm*/
   cleardevice();
   /* read result of initialization */
   AAA:
   errorcode = graphresult();
   if (errorcode != grOk)  /* an error occurred */
   {
      printf("Graphics error: %s\n", grapherrormsg(errorcode));
      printf("Press any key to halt:");
      getch();
      exit(1);             /* return with error code */
   }

 /*The cover program */
setfillstyle(1,LIGHTGREEN);
bar(0,0,640,640);
setcolor(GREEN);
bar3d(50,155,590,240,15,1);
setcolor(GREEN);
settextstyle(10,0,10);
outtextxy(65,170,"DIgital Crane Control System");
setcolor(DARKGRAY);
settextstyle(1,0,1);
outtextxy(80,100,"made by li kai 37030519      Date: Nov 2010");
/*outtextxy(300,250,"date Nov 2010");*/
 outtextxy(95,300,"Welcome! Please press any key to enter this software.");
 getch();

 setbkcolor(YELLOW);
 next1:
     graphdriver = DETECT;
   /* initialize graphics mode */
   initgraph(&graphdriver, &graphmode, "");   /*d:\BORLANDC\my program\mm*/
   cleardevice();
   /* read result of initialization */
   errorcode = graphresult();
   if (errorcode != grOk)  /* an error occurred */
   {
      printf("Graphics error: %s\n", grapherrormsg(errorcode));
      printf("Press any key to halt:");
      getch();
      exit(1);             /* return with error code */
   }
 /*The second page program */
 setfillstyle(1,LIGHTGREEN);
bar(0,0,640,640);
setcolor(GREEN);
bar3d(50,25,590,110,15,1);
setcolor(GREEN);
settextstyle(10,0,10);
outtextxy(65,40,"DIgital Crane Control System");
setfillstyle(2,GREEN);
fillellipse(95,150,60,20);
fillellipse(245,150,60,20);
fillellipse(395,150,60,20);
fillellipse(545,150,60,20);
setcolor(WHITE);
settextstyle(0,0,1);
outtextxy(35,145,"1.SET PARAMETER");
outtextxy(185,145,"    2.RUN");
outtextxy(335,145,"    3.HELP");
outtextxy(485,145,"    4.EXIT");
settextstyle(0,0,2);
outtextxy(80,250,"      Please enter 1 to 4 !");
 setcolor(YELLOW);
 settextstyle(0,0,1);
 outtextxy(120,410,"If this is your time to used this software,");
 outtextxy(120,430,"please enter '3' for help!");


 /*5 different pages design as follows */
next:
setfillstyle(1,LIGHTGREEN);
bar(0,0,640,640);
setcolor(GREEN);
bar3d(50,25,590,110,15,1);
setcolor(GREEN);
settextstyle(10,0,10);
outtextxy(65,40,"DIgital Crane Control System");
setfillstyle(2,GREEN);
fillellipse(95,150,60,20);
fillellipse(245,150,60,20);
fillellipse(395,150,60,20);
fillellipse(545,150,60,20);
setcolor(WHITE);
settextstyle(0,0,1);
outtextxy(35,145,"1.SET PARAMETER");
outtextxy(185,145,"    2.RUN");
outtextxy(335,145,"    3.HELP");
outtextxy(485,145,"    4.EXIT");
settextstyle(0,0,2);
outtextxy(80,250,"     Please enter 1 to 4 !");

BBB:ch=getch();
/*float k1=20,k2=-25,k3=8,k4=0.1;*/
switch(ch)
{
   case '1': /*���ò���   */
  setfillstyle(1,BLACK);
bar(50,180,590,380);
setcolor(LIGHTGREEN);
        settextstyle(0,0,1);
        outtextxy(250,260,"K1=");
        outtextxy(250,276,"K2=");
        outtextxy(250,292,"K3=");
        outtextxy(250,308,"K4=");
outtextxy(120,200,"  Please input the parameter k1,k2,k3,k4");
        outtextxy(120,225,"  finished with the key 'Enter'");



           gotoxy(37,17);
           scanf("%f",&k0);
           gotoxy(37,18);
           scanf("%f",&k1);
           gotoxy(37,19);
           scanf("%f",&k2);
           gotoxy(37,20);
           scanf("%f",&k3);
               
           break;

 case '2': clearviewport();
           closegraph();
           graphdriver = DETECT;                        /*��ʼ����ͼ״̬*/
           initgraph(&graphdriver, &graphmode, "");
           cleardevice();
           errorcode = graphresult();
           if (errorcode != grOk)  
           {
           printf("Graphics error: %s\n", grapherrormsg(errorcode));
           printf("Press any key to halt:");
           getch();
           exit(1);
           }

           /*������    */
           setbkcolor(GREEN);                /*LIGHTBLUE    */
           setlinestyle(0,0,3);
               setcolor(GREEN);                  /*WHITE     */
           line(50,450,600,450);
           line(50,440,50,450);
           line(600,440,600,450);
           setlinestyle(0,0,1);
           line(305,450,350,450);
           line(305,420,350,420);
           line(305,420,305,450);
           line(350,420,350,450);
           circle(328,375,4);
           setlinestyle(0,0,3);
           line(328,375,328,435);

               /*�ֽ���      */
           setcolor(GREEN);
           setlinestyle(0,0,3);
           line(40,350,610,350);

               /*������      */
           setcolor(BLUE);                /*WHITE  */
           settextstyle(0,0,1);
           outtextxy(60,320,"0");
           outtextxy(110,320,"0.5s");
           outtextxy(160,320,"1s");
           outtextxy(210,320,"1.5s");
           outtextxy(260,320,"2s");
           outtextxy(310,320,"2.5s");
           outtextxy(360,320,"3s");
           outtextxy(410,320,"3.5s");
           outtextxy(460,320,"4s");
           outtextxy(510,320,"4.5s");
           outtextxy(560,320,"5s");
           outtextxy(20,305,"-1.0");
           outtextxy(20,285,"-0.8");
           outtextxy(20,265,"-0.6");
           outtextxy(20,245,"-0.4");
           outtextxy(20,225,"-0.2");
           outtextxy(45,205,"0");
           outtextxy(30,185,"0.2");
           outtextxy(30,165,"0.4");
           outtextxy(30,145,"0.6");
           outtextxy(30,125,"0.8");
           outtextxy(30,105,"1.0");
           gotoxy(10,4);
           printf("DIgital Crane Control System",k0,k1,k2,k3);     /*̧ͷ������ */
           setlinestyle(0,0,1);
           setcolor(7);
           for(i=2;i<23;i++)
           line(60,90+i*10,610,90+i*10);
           for(i=0;i<12;i++)
           line(60+i*50,310,60+i*50,110);
           setcolor(7);
           setlinestyle(0,0,1);
           line(60,210,610,210);
           line(60,310,60,110);
               moveto(60,295);
           setcolor(RED);
           outtextxy(70,80,"Red--position");
           setcolor(YELLOW);
           outtextxy(200,80,"YELLOW--Angle");


               /*�ж�  */
           oldint=getvect(0xb);
           setvect(0xb,newint);
           disable();
           outportb(0x31b,0xb6);                  /*����ʱ��0.02s   */
           outportb(0x31a,0x10);
           outportb(0x31a,0x27);
           outportb(0x21,inportb(0x21)&0xf7);     /*8259ѡͨ        */
           enable();                              /*���ж�          */
               


           while(m<=50000)                        /*������10s         */
           {
            while(m<=500)
            {
             /*���������仯����  */
             setcolor(RED);            /*λ��   */
             line(60+m-1,210-yt0*10*10,60+m,210-y0*10*10);
     
             setcolor(YELLOW);          /*ƫ��           */
         if(m>50||y1>0.1)
         {
             line(60+m-1,210-yt1*10*10,60+m,210-y11*10*10);
             yt1=y11;
         }
             else
         {
             line(60+m-1,210-yt1*10*10,60+m,210-y1*10*10);
             yt1=y1;
         }

         yt0=y0;
         }
           }

           outportb(0x21,inport(0x21)|0x08);  /*���ж�          */
           setvect(0xb,oldint);

           getch();
           closegraph();
       
           break;
       
            /*��������             */
       
            case '3': 
           clearviewport();
           setcolor(BLUE);
           settextstyle(0,0,2);
           outtextxy(60,60,"Help Information:");
           setcolor(RED);
           settextstyle(0,0,1);
           outtextxy(60,120,"(1) Press NUM 1 to set the parameters K0--K3!");
           outtextxy(60,160,"(2) Press NUM 2 to run the program and show the curves!");
           outtextxy(60,200,"(3) Press NUM 3 to see the help information!");
           outtextxy(60,240,"(4) Press NUM 4 to exit the program!");
           outtextxy(60,280,"(5) the position signal is in AD13,the velocity signal is in AD5");
           outtextxy(90,320,"the angle signal is in AD14,the velocity single of stick is in AD6");
           setcolor(YELLOW);
           setlinestyle(0,0,3);
           line(40,380,600,380);
           outtextxy(200,410,"Press anykey to return!");
           getch();

           break;
      
          /*�˳�    */
          case '4': exit(1);
          break;
          default:  goto BBB;
   }
      goto AAA;
}


/*�жϺ���           */
void interrupt newint( )
{

    float car_position0,car_speed0,stick_angle0,stick_angle_speed0;
    float car_position1,car_speed1,stick_angle1,stick_angle_speed1;
    float ukv;
    float uk;
    m=m+1;

    car_position0=adc(13);          /*��ȡС��λ��*/
    car_speed0=adc(5);              /*��ȡС���ٶ�*/
    stick_angle0=adc(14);           /*��ȡ�ڸ˽Ƕ�*/
    stick_angle_speed0=adc(6);      /*��ȡ�ڸ˽��ٶ�*/

    car_position1=car_position0/grad1;           /*����ʵ��С��λ��*/
    car_speed1=car_speed0/grad2;                 /*����ʵ��С���ٶ�*/
    stick_angle1=stick_angle0/grad3;             /*����ʵ�ʰڸ˽Ƕ�*/
    stick_angle_speed1=stick_angle_speed0/grad4; /*����ʵ�ʰڸ˽��ٶ�*/

    y0=car_position1;
    y1=stick_angle1;

    uk=(k0*stick_angle1+k1*stick_angle_speed1+k2*car_position1+k3*car_speed1);
     if(uk>221.3)
     {
      uk=221.3;                           /*�����������޷�*/
     }
     else if (uk<-221.3)
     {
     uk=-221.3;                          /*�����������������޷�*/
     }

     ukv=uk/221.3;
     dac(ukv);

     outportb(0x20,0x20);                /*��8259��EOI�źţ���ʼ��һ�ֵ��ж�*/
}



/*DA����    */
void dac(float Volt)   
{
    unsigned int x;
    unsigned char lo,hi,newhi,newlo;
    x=(Volt+1)/2*0xfff0;        /*ת��Ϊ16����ƫ���� */
    lo=x%256;                   /*��8λ              */
    hi=(x-lo)/256;              /*��8λ              */
    newhi=hi%16*16+(int)hi/16;  /*��8λ�ĸ�4λ�͵�4λ����     */
    outportb(0x314,newhi);      /*д���8λ                   */
    newlo=lo%16*16+(int)lo/16;  /*��8λ�ĸ�4λ�͵�4λ����     */
    outportb(0x315,newlo);      /*д���8λ                   */
    inportb(0x314);             /*����D/Aת��                 */
}


/*AD����       */
float adc(int num)
{
   int i,j,k,r;
   unsigned int p,q;
   int data;
   float ad;
   outportb(0x31b,0x18);
   outportb(0x310,num);
   for(i=0;i<1000;i++)
   outportb(0x311,0x0);
   for(i=0;i<1000;i++)
   p=inportb(0x312)%16;
   q=inportb(0x313);
   r=p*256+q;
   data=r-0x800;
   ad=10.0*data/0x800;
   return ad;
}
