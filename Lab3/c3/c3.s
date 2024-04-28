.section .data
	msg: .string "Enter a number (1-digit): "
		msg_len = . - msg
	out: .string "Count 4x: "
		out_len = . - out
	newline: .string "\n"
		newline_len = . - newline
		
	b: .int 4

.section .bss
    .lcomm num, 1
    .lcomm index, 2
    .lcomm count, 2
    buffer: .space 2
    
.section .text
    .globl _start
_start:
	# Khởi tạo
	movl $0, index    # Khởi tạo index là 0
	movl $0, count    # Khởi tạo count là 0

loop:
	# Kiểm tra điều kiện lặp
	cmpb $5, index    # So sánh giá trị của index với 5
	je end_loop         # Nếu bằng nhau, nhảy đến nhãn end_loop
	
	# In ra câu "Enter a number (1-digit): "
	movl $4, %eax              # Gọi hàm sys_write
	movl $1, %ebx              # File descriptor: stdout
	movl $msg, %ecx            # Con trỏ đến chuỗi msg
	movl $msg_len, %edx        # Độ dài của chuỗi
	int $0x80                  # Gọi hàm syscall

	# Nhập số nguyên
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $num, %ecx     # Con trỏ đến buffer input
	movl $2, %edx       # Số ký tự tối đa cần nhập
	int $0x80           # Gọi hàm syscall

	# Chuyển ký tự đầu vào thành số nguyên
	movl num, %eax
	sub $48, %eax       # Chuyển ký tự ASCII thành số nguyên
	
	# Kiểm tra số chia hết cho 4
	#movl %ecx, %eax       # Di chuyển giá trị số nguyên vào %eax
	movl $4, %ecx
	xor %edx, %edx     	# Xóa %edx để lưu trữ phần dư
	div %ecx             # Thực hiện phép chia %eax cho %ebx
	test %edx, %edx     # Kiểm tra phần dư
	jnz not_divisible   # Nếu không chia hết, nhảy tới nhãn not_divisible

	# Tăng giá trị của biến count nếu số chia hết cho 4
	addl $1, count
	
not_divisible:
	# Tăng giá trị của index lên 1
	addl $1, index   

	# Tiếp tục lặp
	jmp loop

end_loop:
	# Chuẩn bị in ra chuỗi "Count 4x: "
	movl $4, %eax           # Gọi hàm sys_write
	movl $1, %ebx           # File descriptor: stdout
	movl $out, %ecx         # Con trỏ đến chuỗi "Count 4x: "
	movl $out_len, %edx     # Độ dài của chuỗi
	int $0x80               # Gọi hàm syscall

	# Chuyển số nguyên thành chuỗi
	addl $'0', count

	# In chuỗi kết quả ra màn hình
	movl $4, %eax           # Gọi hàm sys_write
	movl $1, %ebx           # File descriptor: stdout
	movl $count, %ecx         # Con trỏ đến chuỗi kết quả trong buffer
	movl $1, %edx  		# Độ dài của chuỗi
	int $0x80               # Gọi hàm syscall

	# In ký tự xuống dòng
	movl $4, %eax           # Gọi hàm sys_write
	movl $1, %ebx           # File descriptor: stdout
	movl $newline, %ecx     # Con trỏ đến chuỗi newline
	movl $newline_len, %edx # Độ dài của chuỗi
	int $0x80               # Gọi hàm syscall

	# Kết thúc chương trình
	movl $1, %eax           # Gọi hàm sys_exit
	xorl %ebx, %ebx         # Không có lỗi
	int $0x80               # Gọi hàm syscall
