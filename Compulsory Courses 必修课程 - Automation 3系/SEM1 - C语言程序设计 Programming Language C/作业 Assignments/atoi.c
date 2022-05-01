#include<stdio.h>
#include<math.h>
#include<stdlib.h>

int main()
{
	int atoi(char *string);
	int n;
	char string[999] = { 0 };
	char *p = string;
	printf("Please enter a string:\n");
	scanf("%s", p);
	n = atoi(p);
	printf("The converted integer is %d", n);
	return 0;
	system("pause");
}



int atoi(char *string)
{
	int n = 0, i, j;
	for (i = 0; string[i] != 0; i++);
	{
		if (i == 1)
			n = string[0] - '0';
		else
		{
			j = string[0] - '0';
			string++;
			n = atoi(string) + pow(10, i - 1)*j;
		}
	}
	return n;
}