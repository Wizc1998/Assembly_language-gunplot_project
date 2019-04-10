# BY SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
# ALL OF THE CONTENT OF THIS FILE WAS CREATED BY ME WITH NO  
# ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE  
# OR ONE OF OUR UNDERGRADUATE GRADERS.

.file "lea.s"
# Assembler directives to allocate storage for static array
.section .rodata
.data
.globl lea_calc
	.type lea_calc, @function
.text 
lea_calc:
    push %rbp				# save caller's %rbp
    movq %rsp, %rbp			# copy %rsp to %rbp so our stack frame is ready to use

					# %rdi contains high x value
					# %rsi contains high y value
					# %rdx contains the address of structure pointer
    					# use %rax for z variable
	
	pushq %r12			# planning to use %r12
	pushq %r13			# planning to use %r13
	pushq %r14			# planning to use %r14
	pushq %r15			# planning to use %r15
	pushq %rbx			# planning to use %rbx

	# Calculate z = 4x + 8y + 16 over all values x/y
	# between 0 and high values passed

	# calculates z for all values x and y
	# where –a <= x <= a and –b <= y <= b and z = (4x^2)+(x^2)(y^2)+8(y^2)
	# and put (x,y,z) onto dynamic location of structure
	
	
	movq $0, %r15			# %r15: counter: of loop number, starts from 0
					# increase after each y changes
					# this should end at (x goes to -x)(y goes to -y)
					# note: each single loop bring address up by 
					# 12 address, and no alignment gap need
										

	movq %rsi, %r8			# make a copy of high y value so we can use it every y loop

	movq $0, %r9			# %r9 to 0
	subq %rdi, %r9			# %r9 contains -x

	movq $0, %r12			# %r12 to 0
	subq %rsi, %r12			# %r12 contains -y
	
	incq %rdi
Calc_loop_x:
    	decq %rdi			# decrement x
    	cmpl %r9d, %edi;		# set SF when s1<s2 ::: cmp s2, s1
    	jl Calc_exit			# if current x < - high x, we're done
					# if not, continue

    	movq %rdi, %rcx			# %rcx: make a copy of x to solve 4*x^2
	
	
	imulq %rcx, %rcx		# %rcx contains x^2
	movq %rcx, %r13			# %r13 = make a copy of x^2
    	shlq $2, %rcx			# %rcx contains 4*x^2

    	movq %r8, %rsi			# set %rsi back to high y value
Calc_loop_y:
	
	leaq (%rdx, %r15), %rbx
	movl %edi, (%rbx)		# put curr x to p+i*12+0

	movq %rsi, %r14			# %r14: make a copy of y and solve 8*y^2
	
	leaq 4(%rdx, %r15), %rbx
	movl %r14d, (%rbx)		# put curr y to p+i*12+4
	
	imulq %r14, %r14		# %r14 contains y^2
	pushq %r13			# save x^2 value
	imulq %r14, %r13		# %r13 = x^2 * y^2
    	shlq $3, %r14			# %r14 contains 8*y^2
	

    	movq %rcx, %rax			# %rax: 4*x^2 ----z
	addq %r13, %rax			# %rax: 4*x^2 + x^2*y^2 -----z
	addq %r14, %rax			# %rax: 4*x^2 + x^2*y^2 + 8*y^2 -----z
	
	leaq 8(%rdx, %r15), %rbx
	movl %eax, (%rbx)		# put curr z to p+i*12+8
					
	popq %r13			# restore x^2 value
	addq $12, %r15			#increase the loop counter by 12

    	decq %rsi			# decrement y
	cmpl %r12d, %esi;		# set SF if %esi (current y) is smaller than %r12l (- high y)
    	jl Calc_loop_x			# if current y < - high y, set up next x value
    	jmp Calc_loop_y			# otherwise calculate next result


Calc_exit:
	popq %rbx			# pop %rbx
	popq %r15			# pop %r15
	popq %r14			# pop %r14
	popq %r13			# pop %r13
	popq %r12			# pop %r12
	
    	leave
    	ret
.size lea_calc, .-lea_calc

