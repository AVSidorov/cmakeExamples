#include "print.h"
#include "hello.h"

void print(char* msg){
    hello();
    std::cout << msg << '\n';
}