#include<stdio.h>
#include<stdlib.h>
int main()
{
	int x, y, i;
	printf("Input an int: x=");
	scanf("%d", &x);
	printf("-----------BEGIN-----------\n");
	y = x / 5;
	i = 0;
	if (y >= 1)
	{
		do
		{
			printf("[  ]");
			i++;
		} while (i <= y - 1);
	}	
	printf("[%d]\n", x);
	printf("-----------END-----------\n");
	printf("%d has %d after devide by 5, output is on the no.%d col\n", x, y, y);
	system("pause");
	return 0;
}
