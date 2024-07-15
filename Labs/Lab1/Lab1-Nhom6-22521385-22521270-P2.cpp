#include "stdio.h"

using namespace std;

int negative(int x)
{
    return (~x) + 1;
}

//2.1 
int isSameSign(int x, int y) {
    x = (x >> 31) & 1;  //Lấy bit dấu (bit đầu) của x.
    y = (y >> 31) & 1;  //Lấy bit dấu (bit đầu) của y.
    return !(x^y);  //Kiểm tra nếu x và y giống nhau thì cùng dấu -> Trả về 1. Ngược lại, khác nhau thì trả về 0.
}

//2.2
int is16x(int x) {  //Để chia hết cho 16 thì số nhị phân đó phải có 4 bit cuối là 0000 vì 16 = 2^4 = 0b10000.
    int mask = 15;  //Tạo mask = 15 vì ở nhị phân 15 là 1111 -> Mục đích tạo mask để lấy 4 bit cuối của x. 
    x = x & mask;   //And với mask để lấy 4 bit cuối của x -> Kiểm tra 4 bit cuối nếu có bit nào = 1 thì số đó không chia hết cho 16 và ngược lại.
    return !(x^0);  //Kiểm tra nếu 4 bit cuối đều là 0 -> x chia hết cho 16. Ngược lại, nếu có bit khác 0 thì x không chia hết cho 16.
}



//2.3
int isPositive(int x) {     //Kiểm tra nếu bit dấu (bit đầu) của x bằng 0 thì chứng tỏ nó không âm.
    return !(x >> 31) ^ !x;  //Và nếu x khác 0 chứng tỏ nó là dương -> return 1. Còn lại (nếu âm hoặc = 0) return 0.
}

//2.4
int isLess2n(int x, int n) {
    x = x >> n; //Để kiểm tra x nhỏ hơn 2^n thì ta xét các bit từ n+1 trở lên -> Dịch phải n bit để bỏ các bit không cần xét 
    return !(x ^ 0);  //Xét các bit còn lại. Nếu khác 0 -> x nhỏ hơn 2^n. Nếu có bit khác 0 -> x lớn hơn hoặc bằng 2^n
}

int main()
{
    int score = 0;
    //2.1
    printf("\n2.1 isSameSign");
    if (isSameSign(4, 10) == 1 && isSameSign(-5, 2) == 0 && isSameSign(-5, -9) == 1)
    {
        printf("\tPass.");
        score += 2;
    }
    else
        printf("\tFailed.");

    //2.2
    printf("\n2.2 is16x");
    if (is16x(16) == 1 && is16x(23) == 0 && is16x(0) == 1)
    {
        printf("\tPass.");
        score += 2;
    }
    else
        printf("\tFailed.");

    //2.3
    printf("\n2.3 isPositive");
    if (isPositive(16) == 1 && isPositive(0) == 0 && isPositive(-8) == 0)
    {
        printf("\tPass.");
        score += 3;
    }
    else
        printf("\tFailed.");

    //2.4
    printf("\n2.4 isLess2n");
    if (isLess2n(12, 4) == 1 && isLess2n(8, 3) == 0 && isLess2n(15, 2) == 0)
    {
        printf("\tPass.");
        score += 3;
    }
    else
        printf("\tFailed.");

    printf("\n------\nYour score: %.1f", (float)score / 2);
    return 0;
}