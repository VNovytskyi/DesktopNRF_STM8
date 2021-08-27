   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
  52                     ; 20 void main()
  52                     ; 21 {
  54                     	switch	.text
  55  0000               _main:
  59                     ; 22 	CLK_Config();
  61  0000 ad59          	call	L3_CLK_Config
  63                     ; 23 	GPIO_Config();
  65  0002 ad64          	call	L5_GPIO_Config
  67                     ; 24 	UART1_Config();
  69  0004 ad74          	call	L7_UART1_Config
  71                     ; 25 	Sheller_Config();
  73  0006 cd00a3        	call	L11_Sheller_Config
  75                     ; 27 	enableInterrupts();
  78  0009 9a            rim
  80  000a               L33:
  81                     ; 29 		if (sheller_read(&shell, receiveBuffer) == SHELLER_OK) {
  83  000a ae0000        	ldw	x,#_receiveBuffer
  84  000d 89            	pushw	x
  85  000e ae0008        	ldw	x,#_shell
  86  0011 cd0000        	call	_sheller_read
  88  0014 85            	popw	x
  89  0015 a101          	cp	a,#1
  90  0017 26f1          	jrne	L33
  91                     ; 30 			GPIO_WriteReverse(GPIOB, GPIO_PIN_5);
  93  0019 4b20          	push	#32
  94  001b ae5005        	ldw	x,#20485
  95  001e cd0000        	call	_GPIO_WriteReverse
  97  0021 84            	pop	a
  98  0022 20e6          	jra	L33
 125                     ; 35 @far @interrupt void UART1_RX_IRQ(void) 
 125                     ; 36 {
 127                     	switch	.text
 128  0024               f_UART1_RX_IRQ:
 130  0024 8a            	push	cc
 131  0025 84            	pop	a
 132  0026 a4bf          	and	a,#191
 133  0028 88            	push	a
 134  0029 86            	pop	cc
 135  002a 3b0002        	push	c_x+2
 136  002d be00          	ldw	x,c_x
 137  002f 89            	pushw	x
 138  0030 3b0002        	push	c_y+2
 139  0033 be00          	ldw	x,c_y
 140  0035 89            	pushw	x
 143                     ; 37 	sheller_push(&shell, UART1_ReceiveData8());
 145  0036 cd0000        	call	_UART1_ReceiveData8
 147  0039 88            	push	a
 148  003a ae0008        	ldw	x,#_shell
 149  003d cd0000        	call	_sheller_push
 151  0040 84            	pop	a
 152                     ; 39 	if (UART1_GetFlagStatus(UART1_FLAG_OR) == SET) {
 154  0041 ae0008        	ldw	x,#8
 155  0044 cd0000        	call	_UART1_GetFlagStatus
 157  0047 a101          	cp	a,#1
 158  0049 2603          	jrne	L15
 159                     ; 40 		UART1_ReceiveData8();
 161  004b cd0000        	call	_UART1_ReceiveData8
 163  004e               L15:
 164                     ; 42 }
 167  004e 85            	popw	x
 168  004f bf00          	ldw	c_y,x
 169  0051 320002        	pop	c_y+2
 170  0054 85            	popw	x
 171  0055 bf00          	ldw	c_x,x
 172  0057 320002        	pop	c_x+2
 173  005a 80            	iret
 197                     ; 44 static void CLK_Config(void)
 197                     ; 45 {
 199                     	switch	.text
 200  005b               L3_CLK_Config:
 204                     ; 46 	CLK_DeInit();
 206  005b cd0000        	call	_CLK_DeInit
 208                     ; 47 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 210  005e a680          	ld	a,#128
 211  0060 cd0000        	call	_CLK_SYSCLKConfig
 213                     ; 48 	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);	
 215  0063 4f            	clr	a
 216  0064 cd0000        	call	_CLK_SYSCLKConfig
 218                     ; 49 }
 221  0067 81            	ret
 246                     ; 51 static void GPIO_Config(void)
 246                     ; 52 {
 247                     	switch	.text
 248  0068               L5_GPIO_Config:
 252                     ; 53 	GPIO_DeInit(GPIOB);
 254  0068 ae5005        	ldw	x,#20485
 255  006b cd0000        	call	_GPIO_DeInit
 257                     ; 54 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
 259  006e 4be0          	push	#224
 260  0070 4b20          	push	#32
 261  0072 ae5005        	ldw	x,#20485
 262  0075 cd0000        	call	_GPIO_Init
 264  0078 85            	popw	x
 265                     ; 55 }
 268  0079 81            	ret
 295                     ; 57 static void UART1_Config(void)
 295                     ; 58 {
 296                     	switch	.text
 297  007a               L7_UART1_Config:
 301                     ; 59 	UART1_DeInit();
 303  007a cd0000        	call	_UART1_DeInit
 305                     ; 60 	UART1_Init(9600, 
 305                     ; 61 							UART1_WORDLENGTH_8D, 
 305                     ; 62 							UART1_STOPBITS_1, 
 305                     ; 63 							UART1_PARITY_NO, 
 305                     ; 64 							UART1_SYNCMODE_CLOCK_DISABLE, 
 305                     ; 65 							UART1_MODE_TXRX_ENABLE);
 307  007d 4b0c          	push	#12
 308  007f 4b80          	push	#128
 309  0081 4b00          	push	#0
 310  0083 4b00          	push	#0
 311  0085 4b00          	push	#0
 312  0087 ae2580        	ldw	x,#9600
 313  008a 89            	pushw	x
 314  008b ae0000        	ldw	x,#0
 315  008e 89            	pushw	x
 316  008f cd0000        	call	_UART1_Init
 318  0092 5b09          	addw	sp,#9
 319                     ; 68 	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
 321  0094 4b01          	push	#1
 322  0096 ae0205        	ldw	x,#517
 323  0099 cd0000        	call	_UART1_ITConfig
 325  009c 84            	pop	a
 326                     ; 69 	UART1_Cmd(ENABLE);	
 328  009d a601          	ld	a,#1
 329  009f cd0000        	call	_UART1_Cmd
 331                     ; 70 }
 334  00a2 81            	ret
 370                     ; 72 static void Sheller_Config(void)
 370                     ; 73 {
 371                     	switch	.text
 372  00a3               L11_Sheller_Config:
 374  00a3 88            	push	a
 375       00000001      OFST:	set	1
 378                     ; 74 	uint8_t init_result = sheller_init(&shell, 0x23, SHELLER_DATA_LENGTH, 128);
 380  00a4 ae0080        	ldw	x,#128
 381  00a7 89            	pushw	x
 382  00a8 4b08          	push	#8
 383  00aa 4b23          	push	#35
 384  00ac ae0008        	ldw	x,#_shell
 385  00af cd0000        	call	_sheller_init
 387  00b2 5b04          	addw	sp,#4
 388  00b4 6b01          	ld	(OFST+0,sp),a
 390                     ; 75 	if (init_result == SHELLER_ERROR) {
 392  00b6 0d01          	tnz	(OFST+0,sp)
 393  00b8 2602          	jrne	L121
 394  00ba               L321:
 395                     ; 76 		while(1);
 397  00ba 20fe          	jra	L321
 398  00bc               L121:
 399                     ; 78 }
 402  00bc 84            	pop	a
 403  00bd 81            	ret
 437                     ; 80 static void delay_ticks(uint32_t t) {
 438                     	switch	.text
 439  00be               L31_delay_ticks:
 441       00000000      OFST:	set	0
 444  00be               L741:
 445                     ; 81     while(--t);
 447  00be 96            	ldw	x,sp
 448  00bf 1c0003        	addw	x,#OFST+3
 449  00c2 a601          	ld	a,#1
 450  00c4 cd0000        	call	c_lgsbc
 452  00c7 96            	ldw	x,sp
 453  00c8 1c0003        	addw	x,#OFST+3
 454  00cb cd0000        	call	c_lzmp
 456  00ce 26ee          	jrne	L741
 457                     ; 82 }
 460  00d0 81            	ret
 495                     ; 85 void assert_failed(uint8_t* file, uint32_t line)
 495                     ; 86 {
 496                     	switch	.text
 497  00d1               _assert_failed:
 501  00d1               L171:
 502  00d1 20fe          	jra	L171
 611                     	xdef	_main
 612                     	xdef	f_UART1_RX_IRQ
 613                     	switch	.ubsct
 614  0000               _receiveBuffer:
 615  0000 000000000000  	ds.b	8
 616                     	xdef	_receiveBuffer
 617  0008               _shell:
 618  0008 000000000000  	ds.b	14
 619                     	xdef	_shell
 620                     	xref	_sheller_read
 621                     	xref	_sheller_push
 622                     	xref	_sheller_init
 623                     	xdef	_assert_failed
 624                     	xref	_UART1_GetFlagStatus
 625                     	xref	_UART1_ReceiveData8
 626                     	xref	_UART1_ITConfig
 627                     	xref	_UART1_Cmd
 628                     	xref	_UART1_Init
 629                     	xref	_UART1_DeInit
 630                     	xref	_GPIO_WriteReverse
 631                     	xref	_GPIO_Init
 632                     	xref	_GPIO_DeInit
 633                     	xref	_CLK_SYSCLKConfig
 634                     	xref	_CLK_DeInit
 635                     	xref.b	c_x
 636                     	xref.b	c_y
 656                     	xref	c_lzmp
 657                     	xref	c_lgsbc
 658                     	end
