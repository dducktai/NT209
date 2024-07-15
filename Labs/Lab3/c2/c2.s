.section .data

prompt_msg:     .string "moi nhap chuoi: "
length_prompt=  . - prompt_msg

output_msg:     .string "Chuoi sau khi chuan hoa: "
length_output=  . - output_msg

newline:        .string "\n"
length_newline= . - newline

.section .bss
    .lcomm input, 5     # Đủ để lưu 5 ký tự và null terminator
    .lcomm output, 5    # Đủ để lưu 5 ký tự và null terminator

.section .text
.globl _start

_start:
    # In ra chuỗi "moi nhap chuoi: "
    movl $4, %eax           
    movl $1, %ebx           
    movl $prompt_msg, %ecx   
    movl $length_prompt, %edx  
    int $0x80               

    # Nhập chuỗi từ bàn phím
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl $5, %edx
    int $0x80

    # Chuẩn hóa chuỗi
    movl $input, %edi       # Con trỏ chuỗi đầu vào
    movb (%edi), %al        # Lấy ký tự đầu tiên
    cmpb $97, %al           # Kiểm tra xem ký tự đầu tiên có phải là chữ cái viết thường không
    jl uppercase            # Nếu không, nhảy tới uppercase
    cmpb $122, %al          # Kiểm tra xem ký tự đầu tiên có phải chữ cái viết thường và có vượt quá 'z' không
    jg uppercase            # Nếu có, nhảy tới uppercase
    subb $32, %al           # Nếu không, chuyển ký tự đầu tiên thành viết hoa
    movb %al, (%edi)        # Gán ký tự đã chuẩn hóa vào vị trí của ký tự gốc
    incl %edi               # Di chuyển con trỏ đến ký tự tiếp theo
    jmp continue_normalize  # Nhảy tới continue_normalize

uppercase:
    incl %edi               # Di chuyển con trỏ đến ký tự tiếp theo

continue_normalize:     # Nhãn tiếp tục chuẩn hóa
    movb (%edi), %al        # Lấy ký tự tiếp theo
    cmpb $0, %al            # Kiểm tra xem đã hết chuỗi chưa
    je end_normalize       # Nếu đã hết chuỗi, kết thúc vòng lặp
    cmpb $65, %al           # Kiểm tra xem ký tự có phải là chữ cái viết hoa không
    jl lowercase           # Nếu không, nhảy tới lowercase
    cmpb $90, %al           # Kiểm tra xem ký tự có vượt quá 'Z' không
    jg lowercase           # Nếu có, nhảy tới lowercase
    addb $32, %al           # Nếu không, chuyển ký tự thành viết thường
    movb %al, (%edi)        # Gán ký tự đã chuẩn hóa vào vị trí của ký tự gốc
    incl %edi               # Di chuyển con trỏ đến ký tự tiếp theo
    jmp continue_normalize  # Nhảy tới continue_normalize

lowercase:
    incl %edi               # Di chuyển con trỏ đến ký tự tiếp theo
    jmp continue_normalize  # Nhảy tới continue_normalize

end_normalize:
    # In ra chuỗi đã được chuẩn hóa
    movl $4, %eax           # Gọi hàm sys_write
    movl $1, %ebx           # File descriptor: stdout
    movl $output_msg, %ecx  # Con trỏ đến chuỗi output_msg
    movl $length_output, %edx  # Độ dài của chuỗi output_msg
    int $0x80               # Gọi hàm syscall

    movl $4, %eax            # Gọi hàm sys_write
    movl $1, %ebx            # File descriptor: stdout
    movl $input, %ecx        # Con trỏ đến chuỗi input
    movl $5, %edx            # Độ dài của chuỗi input
    int $0x80                # Gọi hàm syscall

    # In ký tự xuống dòng
    movl $4, %eax            # Gọi hàm sys_write
    movl $1, %ebx            # File descriptor: stdout
    movl $newline, %ecx      # Con trỏ đến chuỗi newline
    movl $length_newline, %edx  # Độ dài của chuỗi newline
    int $0x80                # Gọi hàm syscall

    # Kết thúc chương trình
    movl $1, %eax            # Gọi hàm sys_exit
    xorl %ebx, %ebx          # Không có lỗi
    int $0x80                # Gọi hàm syscall

