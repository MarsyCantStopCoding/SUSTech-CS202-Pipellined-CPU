#.data  0x0000              		        # ���ݶ�����׵�ַ
#  buf:   .word  0x00000055, 0x000000AA	# ��������
	
#.text	0x0000	
#���е�syscall�������޸� ��Ҫ����lw��sw���滻

#debug�ô�ӡdata
#ÿһ�������������Լ���procurdure�о����Ƿ���Ҫ��ʼ���Ĵ���
#ʵ������� ÿһ��case���涼��һ��jump

.data
	newline:.asciiz "\n"
	case1_000_part11:.asciiz " is binary palindrome, "
	case1_000_part12:.asciiz " is NOT binary palindrome, "
	
.text	#��Ҫ�����ı������׵�ַ

start:
	#��һ��ѭ��
	#�����еļĴ����ڴ˴�����register��ʼ��
	#���ƶ��ļĴ�����ֵ����ʱ��ת��case��
	
case1_000:
	addi $v0,$zero,5		#read integer  ���޸�      
	syscall
	
	add $s0,$zero,$v0
	add $t0,$zero,$v0 
	addi $t1,$zero,0		
	addi $t2,$zero,0
	addi $s1,$t0,0		#get x2  ($s1)
	
  case1_000_cycle1:			
	beq $t0,$zero,case1_000_exit1	#get x2r ($s2)
	andi $t2,$t0,1
	add $t1,$t1,$t2
	srl $t0,$t0,1
	sll $t1,$t1,1
	j case1_000_cycle1
	
  case1_000_exit1: 
	srl $t1,$t1,1
	addi $s2,$t1,0
	addi $t0,$s0,0    #initialize registers
	addi $t1,$zero,0
	addi $t2,$zero,0

  case1_000_label1:
	bne $s1,$s2,case1_000_exit2
	addi $a0,$zero,1          #�ǻ���
	j case1_000_label2
	
  case1_000_exit2:
	addi $a0,$zero,0          #���ǻ���
	
  case1_000_label2:
  		               #��ӡ�Ƿ��ǻ��� ���޸�
  	addi $v0,$zero,1	    #ԭֵ�洢��s1	
  	syscall		    #�Ƿ��ǻ��Ĵ洢��a0
  			
  	la $a0, newline   	    #newline  ���޸�
	li $v0,4
	syscall

  
case1_001:
  	addi $v0,$zero,5		#read integer  ���޸�      
	syscall
	
  	addi $s1,$v0,0            	#input a �洢��s1
  	
  	addi $a0,$s1,0	    	#��ӡ������   ���޸�
	li $v0,35
  	syscall		
  	la $a0, newline   	    #newline  ���޸�
	li $v0,4
	syscall
	
  	addi $v0,$zero,5		#read integer  ���޸�    
  	  
	syscall
	
  	addi $s2,$v0,0            	#input b �洢��s2
  	
  	addi $a0,$s2,0	    	#��ӡ������   ���޸�
	li $v0,35
  	syscall	
  	la $a0, newline   	    #newline  ���޸�
	li $v0,4
	syscall	
	
case1_010:
	and $s3,$s1,$s2		#s3�洢������
	
	addi $a0,$s3,0	    	#��ӡ������  ���޸�
	li $v0,35
  	syscall		   
  	
  	la $a0, newline  		#newline   ���޸�
	li $v0,4
	syscall

case1_011: 	
	or $s3,$s1,$s2		#s3�洢������
	
	addi $a0,$s3,0	    	#��ӡ������  ���޸�
	li $v0,35
  	syscall		   
  	
  	la $a0, newline   		#newline   ���޸�
	li $v0,4
	syscall
  	
case1_100:   	
  	xor $s3,$s1,$s2		#s3�洢������
	
	addi $a0,$s3,0	    	#��ӡ������   ���޸�
	li $v0,35
  	syscall		   
  	
  	la $a0, newline   		#newline    ���޸�
	li $v0,4
	syscall

	
  	
case1_101:   	
  	sllv $s3,$s1,$s2			#s3�洢������
	
	addi $a0,$s3,0	    	#��ӡ������   ���޸�
	li $v0,35
  	syscall		   	
  	  	  	
  	la $a0, newline   		#newline    ���޸�
	li $v0,4
	syscall
  	
  	
case1_110:   	
  	srlv $s3,$s1,$s2			#s3�洢������
	
	addi $a0,$s3,0	    	#��ӡ������   ���޸�
	li $v0,35
  	syscall		   	
  	  	  	
  	la $a0, newline   		#newline    ���޸�
	li $v0,4
	syscall  	
  	
case1_111:   	
  	srav $s3,$s1,$s2		#s3�洢������
	
	addi $a0,$s3,0	    	#��ӡ������   ���޸�
	li $v0,35
  	syscall		   	
  	  	  	
  	la $a0, newline   		#newline    ���޸�
	li $v0,4
	syscall  	  	
	j start
	
