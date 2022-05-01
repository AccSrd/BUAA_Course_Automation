#include<stdio.h>
#include<stdlib.h>

FILE *fp;
char com, ch, filename[24] = { 0 };
int ck=0;

int main(void)
{
	void open(void);
	void show(void);
	while (1)
	{
		while (1)
		{
			printf("\n--O(open)\n--S(show)\n--C(close)\n--Q(quit)\nplease input your command:");
			scanf("%c", &com);
			getchar();
			if (com == 'O' || com == 'o' || com == 'S' || com == 's' || com == 'C' || com == 'c' || com == 'Q' || com == 'q')
				break;
			else
				printf("\nERROR: invalid input!\n");
		}
		if (com == 'O' || com == 'o')
			open();
		if (com == 'S' || com == 's')
			show();
		if (com == 'C' || com == 'c')
		{
			fclose(fp);
			ck = 0;
		}
		if (com == 'Q' || com == 'q')
			break;
	}
	return 0;
}

void open(void) //open
{
	if (ck == 1)
		printf("The file has been opened\n");
	if ((fp = fopen(filename, "r")) == NULL)
	{
		ck = 0;
		printf("\n---->Please input the file name:");
		scanf("%s", filename);
		getchar();
		open();
	}
	else
		ck = 1;
}

void show(void)
{
	if (ck==0)
		printf("Please Open file first!");
	else
	{
		printf("The contents of the document are:");
		while (!feof(fp))
		{
			ch = fgetc(fp);
			putchar(ch);
		}
	}
	putchar(10);
}

