/******************************************************************************

Welcome to GDB Online.
  GDB online is an online compiler and debugger tool for C, C++, Python, PHP, Ruby, 
  C#, OCaml, VB, Perl, Swift, Prolog, Javascript, Pascal, COBOL, HTML, CSS, JS
  Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <stdio.h>
#include <iostream>

using namespace std;

int bitOr(int x, int y)
{
    return ~(~x & ~y);
}

int negative(int x)
{
    return (~x) + 1;
}

int flipByte(int x, int n) 
{
    int mask = 0xFF << (n << 3);
    x ^= mask;
    return x;

}


int mod2n(int x, int n) 
{
    int temp = signed(0xFFFFFFFFF);
    int mask = (1 << n) + temp;
    return x & mask;
}

unsigned int divpw2(unsigned int x, int n) 
{
    
    n = (~n)+1;
    return x<<n;
    
}



int main()
{
    int score = 0;
    //1.1
     printf("1.1 bitOr");
    if (bitOr(3, -9) == (3 | -9))
    {
        printf("\tPass.");
        score += 1;
    }
    else
        printf("\tFailed.");

    //1.2
    printf("\n1.2 negative");
    if (negative(0) == 0 && negative(9) == -9 && negative(-5) == 5)
    {
        printf("\tPass.");
        score += 1;
    }
    else
        printf("\tFailed.");
    //1.3
    printf("\n1.3 flipByte");
    if (flipByte(10, 0) == 245 && flipByte(0, 1) == 65280 && flipByte(0x5501, 1) == 0xaa01)
    {
        printf("\tPass.");
        score += 2;
    }
    else
        printf("\tFailed.");

    //1.4
    printf("\n1.4 mod2n");
    if (mod2n(2, 1) == 0 && mod2n(30, 2) == 2 && mod2n(63, 6) == 63)
    {
        printf("\tPass.");
        score += 2;
    }
    else
        printf("\tFailed.");
    //1.5
    printf("\n1.5 divpw2");
    if (divpw2(0xfffffff, -4) == 0xfffffff0 && divpw2(15, -2) == 60 && divpw2(2, -4) == 32)
    {
        if (divpw2(10, 1) == 5 && divpw2(50, 2) == 12)
        {
            printf("\tAdvanced Pass.");
            score += 4;
        }
        else
        {
            printf("\tPass.");
            score += 3;
        }
    }
    else
        printf("\tFailed.");
    
    
    printf("\n------\nYour score: %.1f", (float)score / 2);
    return 0;

    
}

