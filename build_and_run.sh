mkdir build
i386-elf-gcc -ffreestanding -m32 -g -c ./Kernal/kernal.c -o ./build/kernal.o
i386-elf-gcc -ffreestanding -m32 -g -c ./Drivers/VGA_Text.c -o ./build/VGA_Text.o
nasm -f elf ./Boot/kernal_entry.asm -o ./build/kernal_entry.o
i386-elf-ld -o ./build/full_kernal.bin -Ttext 0x1000 ./build/kernal_entry.o ./build/kernal.o ./build/VGA_Text.o --oformat binary
nasm ./Boot/boot.asm -fbin -o ./build/boot.bin
cat ./build/boot.bin ./build/full_kernal.bin > ./build/final_kernal.bin
nasm -fbin ./Boot/memory_padding.asm -o ./build/zeros.bin
cat ./build/final_kernal.bin ./build/zeros.bin > ./build/OS.bin
qemu-system-x86_64 -drive format=raw,file="./build/OS.bin",index=0,if=floppy, -m 128M