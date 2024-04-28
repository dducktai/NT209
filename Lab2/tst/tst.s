 .section .data
    prompt: .string "Nhap chuoi 4 ky tu: "
    len_prompt = . - prompt

    prompt_shift: .string "Nhap buoc dich (tu 0 den 9): "
    len_prompt_shift = . - prompt_shift
    
     error_msg: .string "Vui long nhap 4 ky tu!"
    len_error_msg = . - error_msg

    output: .string "Chuoi da ma hoa: "
    len_output = . - output

    newline: .string "\n"
    len_newline = . - newline
    
    count: .int 0
.section .bss
    input: .skip 5       # Đủ để lưu 4 ký tự và null terminator
    shift: .space 1      # Lưu giá trị bước dịch
    res: .space 4	# kết quả mã hóa


.section .text
.globl _start

_start:
    # In ra chuỗi "Nhap chuoi 4 ky tu: "
    movl $4, %eax
    movl $1, %ebx
    movl $prompt, %ecx
    movl $len_prompt, %edx
    int $0x80

    # Nhập dữ liệu từ bàn phím
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $5, %edx
    int $0x80

 
 # Đếm số ký tự đã nhập
    movl $len_promt, %esi
    cmpl $4, %esi
    jn error
    jmp continue_program
    
    

error:
    # In ra thông báo lỗi
    movl $4, %eax           
    movl $1, %ebx           
    movl $error_msg, %ecx   
    movl $len_error_msg, %edx  
    int $0x80    
    
    # In ký tự xuống dòng
    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $len_newline, %edx
    int $0x80

continue_program:
    # In ra chuỗi "Nhap buoc dich (tu 0 den 9): "
    movl $4, %eax
    movl $1, %ebx
    movl $prompt_shift, %ecx
    movl $len_prompt_shift, %edx
    int $0x80

    # Nhập bước dịch từ bàn phím
    movl $3, %eax
    movl $0, %ebx
    movl $shift, %ecx
    movl $1, %edx
    int $0x80

   # Mã hóa chuỗi
    subl $48, shift
    movl $0, %esi           # Số lần lặp
    movl $input, %edi       # Con trỏ đến chuỗi input
    
loop_shift:
    cmpb $5, (%edi)        # Kiểm tra ký tự null terminator
    je end_loop_shift       # Nếu là null terminator thì kết thúc vòng lặp
    movzbl (%edi), %eax    # Load ký tự
    movb (shift), %bl     # Load giá trị của shift vào thanh ghi %bl
    addb %bl, %al         # Thêm giá trị của %bl vào %al
    cmpb $122, %al          # Kiểm tra xem ký tự có vượt quá 'z' không
    jle continue_shift      # Nếu không, tiếp tục vòng lặp
    subb $26, %al           # Nếu có, quay vòng lại 'a'

continue_shift:
    movb %al, (%edi)        # Gán ký tự đã mã hóa vào vị trí của ký tự gốc
    incl %edi               # Di chuyển con trỏ đến ký tự tiếp theo
    incl %esi               # Tăng số lần lặp
    cmp $4, %esi            # Kiểm tra xem đã mã hóa đủ 4 ký tự chưa
    jl loop_shift           # Nếu chưa, lặp lại quá trình mã hóa
    
    
end_loop_shift:
    movl %edi, res
    # In ra chuỗi "Chuoi da ma hoa: "
    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $len_output, %edx
    int $0x80

    # In chuỗi đã mã hóa
    movl $4, %eax
    movl $1, %ebx
    movl $input, %ecx
    movl $4, %edx
    int $0x80

    # In ký tự xuống dòng
    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $len_newline, %edx
    int $0x80

    # Kết thúc chương trình
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
 

