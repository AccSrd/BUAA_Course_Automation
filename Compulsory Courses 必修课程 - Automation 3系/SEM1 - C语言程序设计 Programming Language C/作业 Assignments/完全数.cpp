#include<stdio.h>
#include<stdlib.h>
int main()
{
	int i, j, a;
	for (i = 1; i <= 1000; i++)
	{ 
		a = 0;
		for (j = 1; j < i; j++)
		{
			if (i%j==0)
			{
				a = a + j;
			}			
		}
		if (a == i)
		{
			printf("%d\n",i);
		}
	}
	system("pause");
	return 0;
}