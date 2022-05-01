#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct Student
{
	long number;
	char name[20];
	char sex;
	float math_score;
	float eng_score;
	float pol_score;
};
	struct Student stu[4] = {
			{16710001,"张全蛋",'M',99,67,87},
			{16710002,"李狗蛋",'F',87,88.5,78},
			{16710003,"唐马儒",'M',59,59,59},
			{16710004,"王尼玛",'F',99,97.5,96.5} };


int main(void)
{
	void print(int i);
	while (1)
	{
		int a=0;
		printf("Please enter the student serial number to view (1/2/3/4)：");
		scanf("%d", &a);
		if (a <= 0)
		{
			printf("\nPlease enter the correct value! ");
			break;
		}
		print(a);
		system("pause");
	}
	return 0;
}

void print(int i)
{
	i--;
	printf("\n%ld	%8s    %c	%6.2f	%6.2f	%6.2f\n", stu[i].number, stu[i].name, stu[i].sex, stu[i].math_score, stu[i].eng_score, stu[i].pol_score);
}