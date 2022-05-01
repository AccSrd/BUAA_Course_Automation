#include<stdio.h>
#include<math.h>
#include<stdlib.h>

int main()
{
	char *itoa(int, char *string);
	int n;
	char string[999] = { 0 };
	char *p = string;
	printf("Please enter an integer:\n");
	scanf("%d", &n);
	itoa(n, p);
	printf("The converted string is %s", p);
	return 0;
	system("pause");
}

char *itoa(int n, char *string)
{
	int i;
	int x = 0, z = n;
	for (x, z; z > 0; x++)
		z /= 10;
	for (i = 0; string[i] != 0; i++);
	{
		if (x == 1)
		{
			string[i] = n + '0';
			string[i + 1] = 0;
		}
		else
		{
			string[i] = n / pow(10, x - 1) + '0';
			n = n - (string[i] - '0')*pow(10, x - 1);
			string[i + 1] = 0;
			itoa(n, string);
		}
	}
	return string;
}