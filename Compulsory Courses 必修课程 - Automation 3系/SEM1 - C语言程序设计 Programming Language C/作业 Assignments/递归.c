#include<stdio.h>
#include<math.h>
#include<stdlib.h>
int main()
{
	float cau(int n);
	int a;
	float b;
	printf("Please enter a positive integer n:");
	scanf("%d", &a);
	if (a<=0)
	{
		printf("\nThe value entered is not a positive integer.");
		system("pause");
		return 0;
	}
	else
		b = cau(a);
	printf("The calculation result is %f", b);
	system("pause");
	return 0;
}

float cau(int n)
{
	float m;
	if (n == 1)
		m = 1;
	else
	{
	m = cau(n - 1) + 1.0 / n;
	}
    return(m);
}