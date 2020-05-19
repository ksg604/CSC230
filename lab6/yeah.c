/*division, using repeated subtractions*/
int main()
{
    int x = 123;
    int divisor = 10;
    int quotient = 0;
    char num[4];
    num[3] = '\0';

    num[1] = x + '0';


    while(x>=divisor)
		{
			quotient++;
            x -= divisor;
		}
    printf("%d", x);
	return 0;
}
