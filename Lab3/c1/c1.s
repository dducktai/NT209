.section .data
prompt: .string "Enter a number (3 digits): "
	len_prompt = . - prompt

wrong: .string "Khong tang dan\n"
	len_wrong = . - wrong

right: .string "Tang dan \n"
	len_right = . - right

.section .bss
	.lcomm input, 5

.section .text
	.globl _start

_start:
	# In ra chuỗi "Enter a number (3 digits): "
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

	# So sánh 2 số đầu	#Giả sử 3 số của input là abc
	movl $input, %eax	
	mov 1(%eax), %bl	#Lấy ra số thứ 2 (b)

	movl $input, %eax
	movb (%eax), %al	#Lấy ra số đầu tiên (a)

	cmpb %bl, %al
	jg label                # Nếu a > b, nhảy đến nhãn label
	je equal		# Nếu a = b, nhảy đến nhãn label

	# So sánh 2 số cuối 
	movl $input, %eax
	mov 2(%eax), %bl	#Lấy ra số thứ 3 (c)
	
	movl $input, %eax	
	mov 1(%eax), %al	# Lấy ra số thứ 2 (b)

	cmpb %bl, %al
	jg label                # Nếu c > b, nhảy đến nhãn label

	jmp end_if		# Nếu không có trường hợp sai thì nhảy đến end_if

label:
	# In ra chuỗi "Khong tang dan"
	movl $4, %eax
	movl $1, %ebx
	movl $wrong, %ecx
	movl $len_wrong, %edx
	int $0x80
	jmp end			# Nhảy đến end để kết thúc chương trình
	
end_if:
	# In ra chuỗi "Tang dan"
	movl $4, %eax
	movl $1, %ebx
	movl $right, %ecx
	movl $len_right, %edx
    	int $0x80
    	jmp end
    	
equal:
    	# So sánh 2 số cuối 
	movl $input, %eax
	mov 2(%eax), %bl	#Lấy ra số thứ 3 (c)
	
	movl $input, %eax	
	mov 1(%eax), %al	# Lấy ra số thứ 2 (b)

	cmpb %bl, %al
	je label                # Nếu c > b, nhảy đến nhãn label

	jmp end_if		# Nếu không có trường hợp sai thì nhảy đến end_if
end:
	# Kết thúc chương trình
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80


