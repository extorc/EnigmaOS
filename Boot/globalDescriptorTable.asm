CODE_SEG equ code_descriptor - gdt_start
DATA_SEG equ data_descriptor - gdt_start

gdt_initiate:
  cli                                          ;disable interupts
  lgdt [gdt_descriptor]
  mov eax, cr0
  or eax, 1
  mov cr0, eax           ;set cr0 to 1
  jmp CODE_SEG:start_protected_mode

  jmp $
  ret

gdt_start:
  null_descriptor:   
    dd 0
    dd 0
  code_descriptor:
    dw 0xffff                                ; 16 bits of limit
    dw 0                                     ; 24 bits of base
    db 0                                     ;
    db 10011010b                             ;present privilage type
    db 11001111b                             ;other flags + limit last bit
    db 0
  data_descriptor:
    dw 0xffff                                ; 16 bits of limit
    dw 0                                     ; 24 bits of base
    db 0                                     ;
    db 10010011b                             ;present privilage type
    db 11001111b                             ;other flags + limit last bit
    db 0
  gdt_end:

gdt_descriptor:
  dw gdt_end - gdt_start - 1                 ;gdt size
  dd gdt_start                               ;gdt start

[bits 32]
start_protected_mode:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov al, 'A'
  mov ah, 0x0f
  mov ebp, 0x90000
  mov esp, ebp
  jmp KERNAL_LOCATION                        ;final kernal jump