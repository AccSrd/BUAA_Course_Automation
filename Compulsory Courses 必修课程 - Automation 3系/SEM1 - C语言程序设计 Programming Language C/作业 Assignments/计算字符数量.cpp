#include<stdio.h>
#include<stdlib.h>
int main()
{
	char a;
	int x, y, z;
	x = y = z = 0;
	printf("Please enter a character (end with enter): ");
	do
	{
		a = getchar();
		if (a == 32)
		{
			y = y++;
		}
		else if (a >= '0'&&a <= '9')
		{
			x = x++;
		}
		else
		{
			z = z++;
		}
	} while (a != '\n');
	z = z - 1;
	printf("There are %d numbers \n%d blanks \n%d other chars \n", x, y, z);
	system("pause");
		return 0;
}