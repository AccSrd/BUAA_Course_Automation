#include<stdio.h>
#include<stdlib.h>

int a[11];

int main(void)
{
	void swap(int * p1, int * p2);
	int i, j, t, add = 0;
	int *p = &a[0];
	printf("-----This program will arrange the data from small to large-----\n");
	printf("Please enter 10 initial positive integers:\n");
	for (i = 0; i < 10; i++)
		scanf("%d", &a[i]);
	printf("\n");
	for (j = 0; j < 9; j++)
		for (i = 0; i < 9 - j; i++)
			if (a[i] > a[i + 1])
			{
				t = a[i];
				a[i] = a[i + 1];
				a[i + 1] = t;
			}
	printf("The initial array is arranged from large to small as follows:");
	for (i = 0; i < 10; i++)
	{
		printf("%d  ", *(a+i));
	}
	printf("\n");
	printf("Please enter the data to insert:");
	scanf("%d",&add);
	a[10] = 0;
	if (add>=a[9])
	{
		a[10] = add;
	}
	else if (add<=a[0])
	{
		for (i = 10; i > 0; i--)
			swap(i, i - 1);
		a[0] = add;
	}
	else
	{
		for (i = 1; i < 10; i++)
			if (a[i - 1] <= add&&add <= a[i])
			{
				for (int k = 10; k > i; k--)
				{
					swap(k, k - 1);
				}
				a[i] = add;
				break;
			}
	}
	for (i = 0; i < 11; i++)
		{
		printf("%d  ", *(a + i));
	}
	system("pause");
	return 0;
}

void swap(int x, int y)
{
	int s;
	s = a[x];
	a[x] = a[y];
	a[y] = s;
}