#include <windows.h>
/* This is where all the input to the window goes to */
int chess[19][19]={0};
LRESULT CALLBACK WndProc(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam) {
    PAINTSTRUCT ps;
    HDC hdc;
    void PaintChess(HWND,HDC,int,int,int);
    int Check(int,int);
    TCHAR str1[64]="黑方请下棋";
    TCHAR str2[64]="白方请下棋";
    TCHAR str3[64]="恭喜黑方获胜";
    TCHAR str4[64]="恭喜白方获胜";
    static int a=0;//棋子个数 
    static int IsGameOver=0;
    HFONT hFont;
    hFont=CreateFont(60,20,0,0,FW_REGULAR,FALSE,FALSE,FALSE,GB2312_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,PROOF_QUALITY,FIXED_PITCH | FF_MODERN,"微软雅黑" );
	switch(Message) {
		/* Upon destruction, tell the main thread to stop */
		case WM_PAINT:
			hdc=BeginPaint(hwnd,&ps);
			
			for(int i=0;i<19;i++)//棋盘 
			{
				MoveToEx(hdc,15+i*30,15,NULL);
				LineTo(hdc,15+i*30,15+18*30);
				MoveToEx(hdc,15,15+i*30,NULL);
				LineTo(hdc,15+18*30,15+i*30);
				
			}
			
			HBRUSH hBrushx;
			
			hBrushx=CreateSolidBrush(RGB(0,0,0));
			SelectObject(hdc,hBrushx);
			
			for(int i=0;i<3;i++)//星位 
			    for(int j=0;j<3;j++)
			        Pie(hdc,102+i*180,102+j*180,108+i*180,108+j*180,102+i*180,0,108+i*180,0);
			        
			DeleteObject(hBrushx);
			
			SelectObject(hdc,hFont);
			SetTextAlign(hdc,TA_CENTER);
			TextOut(hdc,285,570,str1,(int)strlen(str1));
			DeleteObject(hFont);
			
			EndPaint(hwnd,&ps);
			break;
		
		case WM_LBUTTONUP:
			
			if(IsGameOver)//已有结果不再运行 
			    break;
			
			int x,y;
			char strx[64];
			x=LOWORD(lParam)/30;
			y=HIWORD(lParam)/30;
			
			if(x<0||x>18||y<0||y>18||chess[x][y]!=0)//鼠标点击在棋盘外 
			    break;
			    
			hdc=GetDC(hwnd);
			
			a++;
			chess[x][y]=(a%2==1?1:2);
			PaintChess(hwnd,hdc,x,y,a%2);
			
			if(a>=9)
			    IsGameOver=Check(x,y);
			
			SelectObject(hdc,hFont);//提示信息 
			SetTextAlign(hdc,TA_CENTER);
			if(a%2==0)
			    TextOut(hdc,285,570,str1,(int)strlen(str1));
			else
			    TextOut(hdc,285,570,str2,(int)strlen(str2));
			    
			if(IsGameOver==1)
			    TextOut(hdc,285,570,str3,(int)strlen(str3));
			else if(IsGameOver==2)
			    TextOut(hdc,285,570,str4,(int)strlen(str4));
			    
			DeleteObject(hFont);
			
			ReleaseDC(hwnd,hdc);
			
		    break;
		
		case WM_DESTROY: {
			PostQuitMessage(0);
			break;
		}
		
		/* All other messages (a lot of them) are processed using default procedures */
		default:
			return DefWindowProc(hwnd, Message, wParam, lParam);
	}
	return 0;
}

void PaintChess(HWND hwnd,HDC hdc,int x,int y,int n)//画棋子 
{
	HPEN hPen;
	HBRUSH hBrush;
	
	hPen=CreatePen(PS_SOLID,2,RGB(0,0,0));

	hBrush=CreateSolidBrush(RGB(0,0,0));

	
	if(n==1)
	{   
	    SelectObject(hdc,hPen);
	   	SelectObject(hdc,hBrush);
	    Pie(hdc,3+x*30,3+y*30,27+x*30,27+y*30,3+x*30,0,3+x*30,0);
	    DeleteObject(hPen);
	    DeleteObject(hBrush);
	}
	else
	    RoundRect(hdc,3+x*30,3+y*30,27+x*30,27+y*30,24,24);
}

int Check(int i,int j)//判断是否有结果 
{
	int a, b, c, d, u, v;

	u = i, v = j, a = 0;
	for (u; u < u + 5; u++)
	{
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 1)
    		a++;
			else
				break;
	}
	u = i, v = j;
	for (u; u > u - 5; u--)
	{
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 1)
			a++;
		else
			break;
	}      //检查横排
	u = i, v = j, b = 0;
	for (v; v < v + 5; v++)
	{
		if (v > 18 || v < 0)
			break;
		else if (chess[u][v] == 1)
			b++;
		else
			break;
	}
	u = i, v = j;
	for (v; v > v - 5; v--)
	{
		if (v > 18 || v < 0)
			break;
		else if (chess[u][v] == 1)
			b++;
		else
			break;
	}     //检查竖排
	u = i, v = j, c = 0;
	for (u, v; v < v + 5 && u < u + 5; v++, u++)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 1)
			c++;
		else
			break;
    }
	u = i, v = j;
	for (v, u; v > v - 5 && u > u - 5; v--, u--)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 1)
			c++;
		else
			break;
	}     //检查左下-右上
	u = i, v = j, d = 0;
	for (u, v; v > v - 5 && u < u + 5; v--, u++)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 1)
			d++;
		else
			break;
	}
	u = i, v = j;
	for (v, u; v < v + 5 && u > u - 5; v++, u--)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 1)
			d++;
		else
			break;
	}     //检查左上-右下
	if (a > 5 || b > 5 || c > 5 || d > 5)
		return(1);
 
   //检查黑子
	 
	u = i, v = j, a = 0;
	for (u; u < u + 5; u++)
	{
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 2)
			a++;
		else
			break;
	}
	u = i, v = j;
	for (u; u > u - 5; u--)
	{
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 2)
			a++;
		else
			break;
	}      //检查横排
	u = i, v = j, b = 0;
	for (v; v < v + 5; v++)
	{
		if (v > 18 || v < 0)
			break;
		else if (chess[u][v] == 2)
			b++;
		else
			break;
	}
	u = i, v = j;
	for (v; v > v - 5; v--)
	{
		if (v > 18 || v < 0)
			break;
		else if (chess[u][v] == 2)
			b++;
		else
			break;
	}     //检查竖排
	u = i, v = j, c = 0;
	for (u, v; v < v + 5 && u < u + 5; v++, u++)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 2)
			c++;
		else
			break;
	}
	u = i, v = j;
	for (v, u; v > v - 5 && u > u - 5; v--, u--)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 2)
			c++;
		else
			break;
	}     //检查左下-右上
	u = i, v = j, d = 0;
	for (u, v; v > v - 5 && u < u + 5; v--, u++)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 2)
			d++;
		else
			break;
	}
	u = i, v = j;
	for (v, u; v < v + 5 && u > u - 5; v++, u--)
	{
		if (v > 18 || v < 0)
			break;
		if (u > 18 || u < 0)
			break;
		else if (chess[u][v] == 2)
			d++;
		else
			break;
	}     //检查左上-右下
	if (a > 5 || b > 5 || c > 5 || d > 5)
		return(2);
	else return (0);
}

/* The 'main' function of Win32 GUI programs: this is where execution starts */
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	WNDCLASSEX wc; /* A properties struct of our window */
	HWND hwnd; /* A 'HANDLE', hence the H, or a pointer to our window */
	MSG Msg; /* A temporary location for all messages */

	/* zero out the struct and set the stuff we want to modify */
	memset(&wc,0,sizeof(wc));
	wc.cbSize		 = sizeof(WNDCLASSEX);
	wc.lpfnWndProc	 = WndProc; /* This is where we will send messages to */
	wc.hInstance	 = hInstance;
	wc.hCursor		 = LoadCursor(NULL, IDC_ARROW);
	
	/* White, COLOR_WINDOW is just a #define for a system color, try Ctrl+Clicking it */
	wc.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
	wc.lpszClassName = "WindowClass";
	wc.hIcon		 = LoadIcon(NULL, IDI_APPLICATION); /* Load a standard icon */
	wc.hIconSm		 = LoadIcon(NULL, IDI_APPLICATION); /* use the name "A" to use the project icon */

	if(!RegisterClassEx(&wc)) {
		MessageBox(NULL, "Window Registration Failed!","Error!",MB_ICONEXCLAMATION|MB_OK);
		return 0;
	}

	hwnd = CreateWindowEx(WS_EX_CLIENTEDGE,"WindowClass","五子棋",WS_VISIBLE|WS_OVERLAPPED|WS_SYSMENU,//窗口类型 
		CW_USEDEFAULT, /* x */
		CW_USEDEFAULT, /* y */
		580, /* width */
		680, /* height */
		NULL,NULL,hInstance,NULL);

	if(hwnd == NULL) {
		MessageBox(NULL, "Window Creation Failed!","Error!",MB_ICONEXCLAMATION|MB_OK);
		return 0;
	}

	/*
		This is the heart of our program where all input is processed and 
		sent to WndProc. Note that GetMessage blocks code flow until it receives something, so
		this loop will not produce unreasonably high CPU usage
	*/
	while(GetMessage(&Msg, NULL, 0, 0) > 0) { /* If no error is received... */
		TranslateMessage(&Msg); /* Translate key codes to chars if present */
		DispatchMessage(&Msg); /* Send it to WndProc */
	}
	return Msg.wParam;
}
