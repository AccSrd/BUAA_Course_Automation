#include<stdio.h>
#include<math.h>
	int main()
	{
		int check(int x);
		int a, b, c, d, e, f, g, h;
		while (1)
		{
			h = 0;
			printf("---------------BEGIN---------------\n");
			printf("Please enter a five (or lower) digit integer: ");
			scanf("%d", &a);
			b = check(a);
			c = a / pow(10, b - 1);
			d = (a - c*pow(10, b - 1)) / pow(10, b - 2);/
			e = (a - c*pow(10, b - 1) - d*pow(10, b - 2)) / pow(10, b - 3);
			f = (a - c*pow(10, b - 1) - d*pow(10, b - 2) - e*pow(10, b - 3)) / pow(10, b - 4);
			g = (a - c*pow(10, b - 1) - d*pow(10, b - 2) - e*pow(10, b - 3) - f*pow(10, b - 4)) / pow(10, b - 5);
			int a[10] = { 0,0,0,0,0,c,d,e,f,g };
			h = a[b + 4] * pow(10, b - 1) + a[b + 3] * pow(10, b - 2) + a[b + 2] * pow(10, b - 3) + a[b + 1] * pow(10, b - 4) + a[b] * pow(10, b - 5);
			printf("\nAfter inverting the above %d-bit integers, the output is %d\n",b,h);
			printf("---------------END---------------\n");
		}
		return 0;
	}
	int check(int x)
	{
		int j = 10;
		int i = 1;
		do
		{
			if (x >= j)
			{
				j = j * 10, i++;
			}
		} while (x >= j);
		return(i);
	}