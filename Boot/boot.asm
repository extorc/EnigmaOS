[org 0x7c00] 

KERNAL_LOCATION equ 0x1000                   ;kernal location

BOOT_DISK: db 0                              ;boot disk number
mov [BOOT_DISK], dl

mov bp, 0x8000                               ;
mov sp, bp                                   ;set stack pointers

xor ax, ax                                   ;TODO                                      
mov es, ax                                   ;TODO 
mov ds, ax                                   ;TODO

mov bx, KERNAL_LOCATION
mov dh, 20

mov ah, 0x02
mov al, dh                                   ;num sec
mov ch, 0x00                                 ;cylinder num
mov dh, 0x00                                 ;head num
mov cl, 0x02                                 ;sec unm
mov dl, [BOOT_DISK]

int 0x13

call clearScreen                             ;Clear Screen
call gdt_initiate                            ;GDT implementation

%include "Boot/clearScreen.asm"
%include "Boot/globalDescriptorTable.asm"

times 510-($-$$) db 0              
dw 0xaa55