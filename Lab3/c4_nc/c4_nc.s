.section .data
msg1: .string "Nhap diem mon 1 (1 chu so): "
msg1_len = . - msg1

msg2: .string "Nhap diem mon 2 (1 chu so): "
msg2_len = . - msg2

msg3: .string "Nhap diem mon 3 (1 chu so): "
msg3_len = . - msg3

msg4: .string "Nhap diem mon 4 (1 chu so): "
msg4_len = . - msg4

msg5: .string "Diem thu 5 de qua mon: "
msg5_len = . - msg5

msg6: .string "Khong ton tai"
msg6_len = . - msg6

pass_msg:           .string "Qua mon\n"
length_pass_msg=    . - pass_msg

fail_msg:           .string "Khong qua mon\n"
length_fail_msg=    . - fail_msg

newline:            .string "\n"
length_newline=     . - newline

marks: .int 0

min: .float 22.5

.section .bss
    .lcomm num1, 1
    .lcomm num2, 1
    .lcomm num3, 1
    .lcomm num4, 1
    .lcomm mark1, 4    # Biến lưu điểm môn 1 (4 byte)
    .lcomm mark2, 4    # Biến lưu điểm môn 2 (4 byte)
    .lcomm mark3, 4    # Biến lưu điểm môn 3 (4 byte)
    .lcomm mark4, 4    # Biến lưu điểm môn 4 (4 byte)
    .lcomm mark5, 4    # Biến lưu điểm môn 5 (4 byte)
    .lcomm total_marks, 4  # Biến lưu tổng điểm (4 byte)
    .lcomm avg_mark, 4  # Biến lưu tổng điểm (4 byte)
    buffer: .space 1  # Định nghĩa buffer với kích thước 1 byte


.section .text
    .globl _start
_start:
	# Khởi tạo
	movl $0, mark1    # Khởi tạo mark1 là 0
	movl $0, mark2    # Khởi tạo mark2 là 0
	movl $0, mark3    # Khởi tạo mark3 là 0
	movl $0, mark4    # Khởi tạo mark4 là 0
	movl $0, mark5    # Khởi tạo mark4 là 0
	movl $0, total_marks    # Khởi tạo total_marks là 0
	movl $0, avg_mark    # Khởi tạo avg_mark là 0

	# In ra câu hỏi và nhập điểm cho môn 1
	movl $4, %eax              # Gọi hàm sys_write
	movl $1, %ebx              # File descriptor: stdout
	movl $msg1, %ecx           # Con trỏ đến chuỗi msg1
	movl $msg1_len, %edx       # Độ dài của chuỗi
	int $0x80                  # Gọi hàm syscall

	# Nhập điểm môn 1
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $num1, %ecx     # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự tối đa cần nhập
	int $0x80           # Gọi hàm syscall
	movzbl num1, %ecx   # Chuyển byte ASCII thành số nguyên và lưu vào ECX
	sub $48, %ecx       # Chuyển ký tự ASCII thành số nguyên
	movl %ecx, mark1    # Lưu điểm vào mark1

	# Xóa bộ đệm stdin
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $buffer, %ecx  # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự cần đọc (chỉ 1 ký tự)
	int $0x80           # Gọi hàm syscall


	# In ra câu hỏi và nhập điểm cho môn 2
	movl $4, %eax              # Gọi hàm sys_write
	movl $1, %ebx              # File descriptor: stdout
	movl $msg2, %ecx           # Con trỏ đến chuỗi msg2
	movl $msg2_len, %edx       # Độ dài của chuỗi
	int $0x80                  # Gọi hàm syscall

	# Nhập điểm môn 2
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $num2, %ecx     # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự tối đa cần nhập
	int $0x80           # Gọi hàm syscall
	movzbl num2, %ecx   # Chuyển byte ASCII thành số nguyên và lưu vào ECX
	sub $48, %ecx       # Chuyển ký tự ASCII thành số nguyên
	movl %ecx, mark2    # Lưu điểm vào mark1

	# Xóa bộ đệm stdin
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $buffer, %ecx  # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự cần đọc (chỉ 1 ký tự)
	int $0x80           # Gọi hàm syscall


	# In ra câu hỏi và nhập điểm cho môn 3
	movl $4, %eax              # Gọi hàm sys_write
	movl $1, %ebx              # File descriptor: stdout
	movl $msg3, %ecx           # Con trỏ đến chuỗi msg3
	movl $msg3_len, %edx       # Độ dài của chuỗi
	int $0x80                  # Gọi hàm syscall

	# Nhập điểm môn 3
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $num3, %ecx     # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự tối đa cần nhập
	int $0x80           # Gọi hàm syscall
	movzbl num3, %ecx   # Chuyển byte ASCII thành số nguyên và lưu vào ECX
	sub $48, %ecx       # Chuyển ký tự ASCII thành số nguyên
	movl %ecx, mark3    # Lưu điểm vào mark3

	# Xóa bộ đệm stdin
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $buffer, %ecx  # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự cần đọc (chỉ 1 ký tự)
	int $0x80           # Gọi hàm syscall


	# In ra câu hỏi và nhập điểm cho môn 4
	movl $4, %eax              # Gọi hàm sys_write
	movl $1, %ebx              # File descriptor: stdout
	movl $msg4, %ecx           # Con trỏ đến chuỗi msg4
	movl $msg4_len, %edx       # Độ dài của chuỗi
	int $0x80                  # Gọi hàm syscall

	# Nhập điểm môn 4
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $num4, %ecx     # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự tối đa cần nhập
	int $0x80           # Gọi hàm syscall
	movzbl num4, %ecx   # Chuyển byte ASCII thành số nguyên và lưu vào ECX
	sub $48, %ecx       # Chuyển ký tự ASCII thành số nguyên
	movl %ecx, mark4    # Lưu điểm vào mark4

	# Xóa bộ đệm stdin
	movl $3, %eax       # Gọi hàm sys_read
	movl $0, %ebx       # File descriptor: stdin
	movl $buffer, %ecx  # Con trỏ đến buffer input
	movl $1, %edx       # Số ký tự cần đọc (chỉ 1 ký tự)
	int $0x80           # Gọi hàm syscall


	# Tính tổng điểm
	movl mark1, %ebx    # Load mark1 vào ebx
	addl mark2, %ebx    # Cộng mark2 vào ebx
	addl mark3, %ebx    # Cộng mark3 vào ebx
	addl mark4, %ebx    # Cộng mark4 vào ebx
	movl %ebx, total_marks  # Lưu tổng điểm vào total_marks
	


	# Tính trung bình cộng
	xorl %edx, %edx 		# giá trị edx = 0
	movl total_marks, %eax     # Sao chép tổng điểm vào EAX
	movl $4, %ecx              # Load divisor là 4
	divl %ecx                  # Chia tổng điểm cho 4 để tính trung bình cộng

	# Làm tròn trung bình cộng
	cmp $2, %edx    # so sanh phần dư với 2 (vì chia 4 sẽ lần lượt dư 0,1,2,3 tương đương 0, 0.25, 0.5, 0.75)
	jge round_up        # Nhảy tới làm tròn lên nếu phần dư lớn hơn hoặc bằng 2 (tương đương 0.5)

	# Kết thúc, giữ nguyên giá trị
	jmp done

round_up:
	addl $1, %eax       # Làm tròn lên bằng cách tăng phần nguyên lên 1

done:
	# Kết quả là giá trị trong thanh ghi ebx
	cmp $5, %eax             # So sánh trung bình cộng với 5
	jl not_pass              # Nếu trung bình cộng < 5, nhảy tới nhãn not_pass

	# In ra thông báo "Qua mon"
	movl $4, %eax               # Gọi hàm sys_write
	movl $1, %ebx               # File descriptor: stdout
	movl $pass_msg, %ecx        # Con trỏ đến chuỗi pass_msg
	movl $length_pass_msg, %edx # Độ dài của chuỗi
	int $0x80                   # Gọi hàm syscall
	jmp end_program             # Nhảy tới nhãn end_program để kết thúc chương trình



not_pass:
	# In ra thông báo "Khong qua mon"
	movl $4, %eax               # Gọi hàm sys_write
	movl $1, %ebx               # File descriptor: stdout
	movl $fail_msg, %ecx        # Con trỏ đến chuỗi fail_msg
	movl $length_fail_msg, %edx # Độ dài của chuỗi
	int $0x80                   # Gọi hàm syscall

end_program:
	# In ra thông báo "Diem thu 5 de qua mon: "
	movl $4, %eax               # Gọi hàm sys_write
	movl $1, %ebx               # File descriptor: stdout
	movl $msg5, %ecx        # Con trỏ đến chuỗi pass_msg
	movl $msg5_len, %edx # Độ dài của chuỗi
	int $0x80                   # Gọi hàm syscall
	
	# In ra diem thu 5
	movl total_marks, %ebx  	#ebx = giá trị tổng 4 điểm
	movl $24, %ecx			# 24 là tổng điểm 5 môn tối thiểu để qua được (tương đương trung bình môn đạt từ 4.75 ~ 4.8)
	subl %ebx, %ecx			#ecx = 24 - tổng điểm
	cmp $9, %ecx			# so sánh với 9
	jg error			# nếu lớn hơn 9, in lỗi, ngược lại thực thi tiếp
	cmp $0, %ecx			# so sánh với 0
	jl error			# nếu nhỏ hơn 0, in lỗi, ngược lại thực thi tiếp
	
	addl $48, %ecx			# chuyển về mã ascii
	movl %ecx, mark5		# gán giá trị vào mark5
	movl $4, %eax               # Gọi hàm sys_write
	movl $1, %ebx               # File descriptor: stdout
	movl $mark5, %ecx        # Con trỏ đến chuỗi pass_msg
	movl $1, %edx 		# Độ dài của chuỗi
	int $0x80                   # Gọi hàm syscall
	jmp end

error:
	# In loi
	movl $4, %eax               # Gọi hàm sys_write
	movl $1, %ebx               # File descriptor: stdout
	movl $msg6, %ecx         # Con trỏ đến chuỗi newline
	movl $msg6_len, %edx  # Độ dài của chuỗi
	int $0x80                   # Gọi hàm syscall
	
end:
	# In ký tự xuống dòng
	movl $4, %eax               # Gọi hàm sys_write
	movl $1, %ebx               # File descriptor: stdout
	movl $newline, %ecx         # Con trỏ đến chuỗi newline
	movl $length_newline, %edx  # Độ dài của chuỗi
	int $0x80                   # Gọi hàm syscall

	# Kết thúc chương trình
	movl $1, %eax               # Gọi hàm sys_exit
	xorl %ebx, %ebx             # Không có lỗi
	int $0x80                   # Gọi hàm syscall

