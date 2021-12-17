#include "VGA_Text.h"

int global_vmem_pointer = 0xb8000;

void k_print_c(const char alphabet)
{
  *(char *)global_vmem_pointer = alphabet;
  global_vmem_pointer++;
  *(char *)(global_vmem_pointer) = 0x0f;
  global_vmem_pointer++;
}

void k_print_s(const char *str)
{
  int i = 0;
  while (str[i] != '\0')
  {
    k_print_c(str[i]);
    i++;
  }
}