.section .data
    prompt: .string "Nhap MSSV (8 so): "
    len_prompt = . - prompt
    
    error_msg: .string ", Sinh vien tu do"
    len_error_msg = . - error_msg

    output_1: .string ", Nien khoa: 20"
    len_1 = . - output_1

    output_2: .string ", Sinh vien nam: "
    len_2 = . - output_2

    newline: .string "\n"
    newline_len = . - newline

.section .bss
    .lcomm input, 10     # Đủ để lưu 8 số và null terminator
    .lcomm x, 4
    .lcomm number_str, 4
    .lcomm out, 2
    result: .space 1
    
.section .text
.globl _start

_start:
    # In ra chuỗi "Nhap MSSV (8 so): "
    movl $4, %eax           
    movl $1, %ebx           
    movl $prompt, %ecx      
    movl $len_prompt, %edx  
    int $0x80               

    # Nhập dữ liệu từ bàn phím
    movl $3, %eax           
    movl $0, %ebx           
    movl $input, %ecx      
    movl $10, %edx          
    int $0x80               

    # In ra 2 số đầu trước
    movl $4, %eax           
    movl $1, %ebx           
    movl $input, %ecx       # Đặt con trỏ vào vị trí bắt đầu của input
    movl $2, %edx           # Chỉ in ra 2 số đầu 
    int $0x80               

    # In ra tiếp 4 số cuối
    movl $4, %eax           
    movl $1, %ebx           
    movl $input, %ecx       
    addl $4, %ecx           # Đặt con trỏ vào vị trí bắt đầu của 4 số cuối
    movl $4, %edx           # Chỉ in ra 4 số cuối
    int $0x80     


    # In ra chuỗi "Niên khóa 20"
    movl $4, %eax           
    movl $1, %ebx           
    movl $output_1, %ecx      
    movl $len_1, %edx      
    int $0x80               

    # In ra 2 số đầu tiên của giá trị đầu vào, ta được niên khóa
    movl $4, %eax           
    movl $1, %ebx           
    movl $input, %ecx       
    movl $2, %edx           # Chỉ in ra 2 số đầu tiên
    int $0x80            
    
    
    # Lấy giá trị số thứ hai từ input và gán vào x
    movl $input, %ebx       # Đặt con trỏ vào vị trí bắt đầu của input
    addl $1, %ebx           # Di chuyển con trỏ lên 4 byte (1 int) để lấy số thứ hai
    movzx (%ebx), %edx      # Lấy giá trị của số thứ hai
    movl $52, %esi
    subl %edx, %esi
    addl $48, %esi 
    movl %esi, x            # Gán giá trị của số thứ hai vào x
    jmp compare
    

compare:    
    # So sánh giá trị của X với 49
    cmpl $49, x         # So sánh giá trị của X với 49
    jl not_in_range         # Nếu X < 49, nhảy tới nhãn not_in_range
    
    # So sánh giá trị của X với 52
    cmpl $52, x         # So sánh giá trị của X với 52
    jg not_in_range         # Nếu X > 52, nhảy tới nhãn not_in_range
    
    # In ra chuỗi "Sinh viên năm x" 
    movl $4, %eax           
    movl $1, %ebx           
    movl $output_2, %ecx   
    movl $len_2, %edx  
    int $0x80
    xor %edx, %edx            # Xóa bộ nhớ có sẵn    
    
    # In ra giá trị x
    movl $4, %eax           # Gọi hàm sys_write
    movl $1, %ebx           # File descriptor: stdout
    movl $x, %ecx           # Con trỏ đến biến result
    movl $1, %edx           # Độ dài của chuỗi kết quả
    int $0x80               # Gọi hàm syscall
    jmp end_program

not_in_range:
    movl $4, %eax           # Gọi hàm sys_write
    movl $1, %ebx           # File descriptor: stdout
    movl $error_msg, %ecx   # Con trỏ đến chuỗi thông báo lỗi
    movl $len_error_msg, %edx  # Độ dài của chuỗi thông báo lỗi
    int $0x80               # Gọi hàm syscall
    jmp end_program
    
end_program:
    # In ký tự xuống dòng
    movl $4, %eax            # Gọi hàm sys_write
    movl $1, %ebx            # File descriptor: stdout
    movl $newline, %ecx      # Con trỏ đến chuỗi newline
    movl $newline_len, %edx  # Độ dài của chuỗi
    int $0x80                # Gọi hàm syscall

    # Kết thúc chương trình
    movl $1, %eax                 
    int $0x80                 

