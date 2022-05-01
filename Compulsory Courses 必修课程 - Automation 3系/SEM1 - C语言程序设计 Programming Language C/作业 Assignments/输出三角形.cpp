#include<stdio.h>
#include<stdlib.h>
int main()
{
	int n, i = 1, j = 1, z = 1;
	printf("Please enter integer n=");
	scanf("%d", &n);
	while (i <= n)
	{
		while (j <= n - i)
		{
			printf(" ");
			j = j++;
		}	
		while (z <= 2*i - 1)
		{
			printf("*");
			z = z++;
		}
		j = z = 1;
		printf("\n");
		i = i++;
	}
	system("pause");
	return 0;
}