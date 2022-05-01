#include<stdio.h>
#include<stdlib.h>
int main()
{
	float f = 0, c;
	printf("Temperature comparison table: Fahrenheit - Celsius\n");
	printf(" F ---------- C \n");
	do
	{
		c = 5.0 / 9 * (f - 32);
		printf("%3f----------%3f\n", f, c);
		f = f + 20;
	} while (f <= 300);
	system("pause");
	return 0;
}