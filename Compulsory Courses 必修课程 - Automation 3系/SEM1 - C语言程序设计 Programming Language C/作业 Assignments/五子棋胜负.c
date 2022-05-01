#include<stdio.h>
#include<stdlib.h>

int chess[19][19] = { 0 };
int ifgameover = 0;
int time = 0;

int main(void)
{
	void showchess();
	int check(int i, int j);
	int *p;
	int i, j, k, qua;
	int x, y;
	while (ifgameover==0)
	{
		printf("Enter the coordinates to change: ");
		scanf("%d,%d", &i, &j);
		printf("\nEnter the color, 1 is black, 2 is white: ");
		scanf("%d", &k);
		chess[i][j] = k;
		time++;
		for (x = 0; x < 19; x++)
		{
			for (y = 0; y < 19; y++)
				printf("%d  ", chess[x][y]);
			printf("\n");
		}
		printf("\nThis is number %d time chessing\n\n", time);
		ifgameover=check(i, j);
	}
	if (ifgameover==1)
	{
		printf("Black Victory!");
	}
	if (ifgameover==2)
	{
		printf("White Victory!");
	}
	system("pause");
	return 0;
}

 input()
{
	int i, j, k, *pt;
	printf("Enter the coordinates to change: ");
	scanf("%d,%d", &i, &j);
	printf("\nEnter the color, 1 is black, 2 is white: ");
	scanf("%d", &k);
	chess[i][j] = k;
	pt = &chess[i][j];

}


void showchess()
{
	int i, j;
	for (i = 0; i < 19; i++)
	{
		for (j = 0; j < 19; j++)
			printf("%d  ", chess[i][j]);
		printf("\n");
	}
}

int check(int i, int j)
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
		}      //Check horiz
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
		}     //Check verti
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
		}
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
		}
		if (a > 5 || b > 5 || c > 5 || d > 5)
			return(1);
 
	   //Check Black
	 
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
		} 
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
		}
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
		}
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
		}
		if (a > 5 || b > 5 || c > 5 || d > 5)
			return(2);
		else return (0);
	}   //Check White
