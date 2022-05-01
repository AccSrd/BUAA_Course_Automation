#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
int main()
{
	char a[9];
	int i=0,b,c;
	printf("Please enter decimal integer: ");
        scanf("%d",&b);
    while(b>=1)
	{a[i]=b%2;
	i=i++;
	b=b/2;}
	printf("\nThe result is ");
	for(c=i-1;c!=-1;c--)
	printf("%d",a[c]);
	system("pause");
	return 0;
}
