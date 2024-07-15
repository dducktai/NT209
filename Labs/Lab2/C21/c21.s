.section .data

output: .string "From UIT"
length = . - output

newline:        .string "\n"
newline_len =   . - newline

.section .bss
.lcomm text,  1

	
.section .text 

.globl _start
_start:

		
	addl $48, %esi         # Thêm 48 vào thanh ghi %esi 
	add $length, %esi      # Cộng độ dài của chuỗi "From UIT" vào thanh ghi %esi
	subl $1, %esi          # Trừ đi 1 để con trỏ %esi trỏ vào ký tự cuối cùng của chuỗi "From UIT"

	movl %esi, (text)      # Di chuyển giá trị của thanh ghi %esi vào vùng nhớ được đặt tên là text

	# In độ dài của chuỗi
	movl $4, %eax          # Gọi hàm sys_write
	movl $1, %ebx          # File descriptor: stdout
	movl $text, %ecx       # Con trỏ đến chuỗi text (chứa ký tự cuối cùng của chuỗi "From UIT")
	movl $1, %edx          # Độ dài của chuỗi (chỉ 1 ký tự)
	int $0x80              # Gọi hàm syscall để in ra màn hình ký tự cuối cùng của chuỗi "From UIT"

	# In ký tự xuống dòng
	movl $4, %eax            # Gọi hàm sys_write
	movl $1, %ebx            # File descriptor: stdout
	movl $newline, %ecx      # Con trỏ đến chuỗi newline
	movl $newline_len, %edx  # Độ dài của chuỗi newline (1 ký tự)
	int $0x80                # Gọi hàm syscall để in ký tự xuống dòng

	# Kết thúc chương trình
	movl $1, %eax            # Gọi hàm sys_exit
	xorl %ebx, %ebx          # Không có lỗi (đặt %ebx = 0)
	int $0x80                # Gọi hàm syscall để kết thúc chương trình
