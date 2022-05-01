#include<stdio.h>
#include<math.h>
#include<stdlib.h>
int main()
{
	float check(float x, float y, float z);
	float caud(float x, float y, float z);
	float caus(float x, float y, float z, float d);
	float a, b, c, d, s;
	printf("Please enter three sides of the triangle separated by commas:");
	scanf("%f,%f,%f", &a, &b, &c);
	if (check(a, b, c))
	{
		printf("\nInput error, please check and input.\n");
		system("pause");
		return 0;
	}
	d = caud(a, b, c);
	s = caus(a, b, c, d);
	printf("\nTriangle area is %f\n", s);
	system("pause");
	return 0;
}

float check(float x, float y, float z)
{
	if (x>0&&y>0&&z>0&&x+y>z&&x+z>y&&y+z>x)
		return(0);
	else
		return(1);
}

float caud(float x, float y, float z)
{
	float d;
	d = 1.0 / 2 * (x + y + z);
	return(d);
}

float caus(float x, float y, float z,float d)
{
	float s;
	s = sqrt(d*(d - x)*(d - y)*(d - z));
	return(s);
}