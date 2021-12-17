void kprint(int location, const char alphabet)
{
  *(char *)location = alphabet;
  *(char *)(location + 1) = 0x0f;
}

extern "C" void main()
{
  kprint(0xb8000, 'H');
  kprint(0xb8002, 'e');
  kprint(0xb8004, 'l');
  kprint(0xb8006, 'l');
  kprint(0xb8008, 'o');
  return;
}