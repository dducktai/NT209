#include <iostream>
#include <cstring>

int success_3()
{
    return puts("Congrats! You found your own username/password pair :).");
}

int failed()
{
    return puts("Nice try but that is not the answer.");
}

int userpass()
{
    char v7[5] = {123, 60, 105, 115, 105};
    char s[10];
    char v5[10];

    std::cout << "Enter your username: ";
    std::cin.getline(s, sizeof(s));

    std::cout << "Enter your password: ";
    std::cin.getline(v5, sizeof(v5));

    std::cout << "Your input username: " << s
              << " and password: " << v5 << std::endl;

    if (strlen(s) == 9 && strlen(s) == strlen(v5))
    {
        char v4[9];
        for (unsigned int i = 0; i <= 8; ++i)
        {
            if (i > 1)
            {
                if (i > 3)
                    v4[i] = v7[i - 4];
                else
                    v4[i] = s[i + 5];
            }
            else
            {
                v4[i] = s[i + 2];
            }
        }
        unsigned int i;
        for (i = 0; i < strlen(s); ++i)
        {
            if ((s[i] + v4[i]) / 2 != v5[i])
                break;
        }
        if (strlen(s) == i)
            return success_3();
        else
            return failed();
    }
    else
    {
        return failed();
    }
}

int main()
{
    userpass();
    return 0;
}
