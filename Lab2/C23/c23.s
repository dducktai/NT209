.section .data
msg: .string "Enter a number (2-digit): "
msg_len =       . - msg

msg_result:     .string "Remider: "
msg_result_len = . - msg_result

output2: .string "\nn ="
op2 = .-output2

b: .int 8


newline:        .string "\n"
newline_len =   . - newline

	
.section .bss
	.lcomm num, 2
	.lcomm output, 2
	.lcomm number_str, 2
	
.section .text
	.globl _start
_start:

	# In ra cau "Enter a number (2-digit): "
	movl $4, %eax              # Gọi hàm sys_write
    	movl $1, %ebx              # File descriptor: stdout
    	movl $msg, %ecx            # Con trỏ đến chuỗi msg
    	movl $msg_len, %edx        # Độ dài của chuỗi
    	int $0x80                  # Gọi hàm syscall
	
	# Nhập số nguyên
	movl $3, %eax 		# Gọi hàm sys_read
	movl $0, %ebx  		# File descriptor: stdin
	movl $num, %ecx 	# Con trỏ đến buffer input
	movl $2, %edx 		# Số ký tự tối đa cần nhập
	int $0x80 		# Gọi hàm syscall

	
	# Khởi tạo và lấy giá trị số nguyên
	movl $0, %eax 
	movl $num, %ebx      
loop:
    	cmpb $0,(%ebx)		# Kiểm tra đã duyệt hết chuỗi chưa?
    	je endloop
    	imull $10,%eax 	     
    	movzbl (%ebx), %ecx	# lấy ký tự thứ nhất của chuỗi
    	subb $'0', %cl		# Chuyển ký tự vừa lấy sang số nguyên
    	addl %ecx, %eax		# Thêm số nguyên vừa chuyển đổi được, vào số nguyên mới
    	incl %ebx		# Index++
    	jmp loop	
	
endloop: 
	movl %eax, output
	jmp phepchia
	
phepchia:
	movl output, %eax 	# dividend
	# divisor = b
	movl $0, %edx  		# clear dividend
	divl b
	movl %edx, output # edx chứa phần dư, chuyển phần dư vào output

	# In ra thông báo "Kết quả là: "
	movl $4, %eax              # Gọi hàm sys_write
	movl $1, %ebx              # File descriptor: stdout
	movl $msg_result, %ecx     # Con trỏ đến chuỗi msg_result
	movl $msg_result_len, %edx # Độ dài của chuỗi
	int $0x80                  # Gọi hàm syscall
	xor %edx, %edx	      		# Xóa bộ nhớ có sẵn


	#In ra số nguyên
	movl (output), %eax
	movl $10, %ebx 		# Đặt giá trị 10 vào thanh ghi %ebx, được sử dụng để chia.
	div %ebx 		# Chia số nguyên trong %eax cho 10, kết quả sẽ lưu trong %eax, phần dư sẽ lưu trong %edx.
	addl $'0, %edx 		# Chuyển phần dư thành ký tự số tương ứng. Ví dụ: nếu phần dư là 1, thì kết quả là ký tự '1'.
	addl $'0, %eax 		# Chuyển phần nguyên thành ký tự số tương ứng. Ví dụ: nếu phần nguyên là 2, thì kết quả là ký tự '2'.
	movl $number_str, %ebx # Di chuyển địa chỉ của chuỗi kết quả vào %ebx.
	movl %edx, (%ebx) 	# Lưu phần dư vào vị trí đầu tiên của chuỗi.
	
	movl $4, %eax  		# Gọi hàm sys_write
	movl $1, %ebx 		# File descriptor: stdout
	movl $number_str, %ecx 	# Con trỏ đến chuỗi kết quả.
	movl $1, %edx 		# Độ dài của chuỗi kết quả.
	int $0x80 	 	# Gọi hàm syscall
	
	
	# In ký tự xuống dòng
	movl $4, %eax            # Gọi hàm sys_write
	movl $1, %ebx            # File descriptor: stdout
	movl $newline, %ecx      # Con trỏ đến chuỗi newline
	movl $newline_len, %edx  # Độ dài của chuỗi
	int $0x80
	
	# Kết thúc chương trình
    	movl $1, %eax            # Gọi hàm sys_exit
    	xorl %ebx, %ebx          # Không có lỗi
    	int $0x80                # Gọi hàm syscall

