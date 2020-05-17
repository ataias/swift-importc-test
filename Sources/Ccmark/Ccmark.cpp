#include <stdio.h>

extern "C" {

  int show_something() {
    printf("Hello %d\n", 4);
    return 0;
  }

}
