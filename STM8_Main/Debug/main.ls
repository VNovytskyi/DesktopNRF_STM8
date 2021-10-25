   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
  58                     ; 24 void main()
  58                     ; 25 {
  60                     	switch	.text
  61  0000               _main:
  65                     ; 26 	CLK_Config();
  67  0000 cd0098        	call	L3_CLK_Config
  69                     ; 27 	GPIO_Config();
  71  0003 cd00a5        	call	L5_GPIO_Config
  73                     ; 28 	UART1_Config();
  75  0006 cd00b7        	call	L7_UART1_Config
  77                     ; 29 	Sheller_Config();
  79  0009 cd00e0        	call	L11_Sheller_Config
  81                     ; 31 	enableInterrupts();
  84  000c 9a            rim
  86  000d               L33:
  87                     ; 33 		if (sheller_read(&shell, receiveBuffer) == SHELLER_OK) {
  89  000d ae0014        	ldw	x,#_receiveBuffer
  90  0010 89            	pushw	x
  91  0011 ae001c        	ldw	x,#_shell
  92  0014 cd0000        	call	_sheller_read
  94  0017 85            	popw	x
  95  0018 a101          	cp	a,#1
  96  001a 26f1          	jrne	L33
  97                     ; 34 			GPIO_WriteReverse(GPIOB, GPIO_PIN_5);
  99  001c 4b20          	push	#32
 100  001e ae5005        	ldw	x,#20485
 101  0021 cd0000        	call	_GPIO_WriteReverse
 103  0024 84            	pop	a
 104                     ; 35 			transmitMessage[0] = 12;
 106  0025 350c0000      	mov	_transmitMessage,#12
 107                     ; 36 			transmitMessage[1] = 54;
 109  0029 35360001      	mov	_transmitMessage+1,#54
 110                     ; 37 			transmitMessage[2] = 221;
 112  002d 35dd0002      	mov	_transmitMessage+2,#221
 113                     ; 38 			sheller_wrap(&shell, transmitMessage, 3, transmitBuffer);
 115  0031 ae0009        	ldw	x,#_transmitBuffer
 116  0034 89            	pushw	x
 117  0035 4b03          	push	#3
 118  0037 ae0000        	ldw	x,#_transmitMessage
 119  003a 89            	pushw	x
 120  003b ae001c        	ldw	x,#_shell
 121  003e cd0000        	call	_sheller_wrap
 123  0041 5b05          	addw	sp,#5
 124                     ; 39 			for (transmitMessageIndex = 0; transmitMessageIndex < (SHELLER_DATA_LENGTH + SHELLER_SERVICE_BYTES_COUNT); ++transmitMessageIndex) {
 126  0043 3f08          	clr	_transmitMessageIndex
 127  0045               L14:
 128                     ; 40 				UART1_SendData8(transmitBuffer[transmitMessageIndex]);
 130  0045 b608          	ld	a,_transmitMessageIndex
 131  0047 5f            	clrw	x
 132  0048 97            	ld	xl,a
 133  0049 e609          	ld	a,(_transmitBuffer,x)
 134  004b cd0000        	call	_UART1_SendData8
 137  004e               L15:
 138                     ; 41 				while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 140  004e ae0080        	ldw	x,#128
 141  0051 cd0000        	call	_UART1_GetFlagStatus
 143  0054 4d            	tnz	a
 144  0055 27f7          	jreq	L15
 145                     ; 39 			for (transmitMessageIndex = 0; transmitMessageIndex < (SHELLER_DATA_LENGTH + SHELLER_SERVICE_BYTES_COUNT); ++transmitMessageIndex) {
 147  0057 3c08          	inc	_transmitMessageIndex
 150  0059 b608          	ld	a,_transmitMessageIndex
 151  005b a10b          	cp	a,#11
 152  005d 25e6          	jrult	L14
 153  005f 20ac          	jra	L33
 180                     ; 47 @far @interrupt void UART1_RX_IRQ(void) 
 180                     ; 48 {
 182                     	switch	.text
 183  0061               f_UART1_RX_IRQ:
 185  0061 8a            	push	cc
 186  0062 84            	pop	a
 187  0063 a4bf          	and	a,#191
 188  0065 88            	push	a
 189  0066 86            	pop	cc
 190  0067 3b0002        	push	c_x+2
 191  006a be00          	ldw	x,c_x
 192  006c 89            	pushw	x
 193  006d 3b0002        	push	c_y+2
 194  0070 be00          	ldw	x,c_y
 195  0072 89            	pushw	x
 198                     ; 49 	sheller_push(&shell, UART1_ReceiveData8());
 200  0073 cd0000        	call	_UART1_ReceiveData8
 202  0076 88            	push	a
 203  0077 ae001c        	ldw	x,#_shell
 204  007a cd0000        	call	_sheller_push
 206  007d 84            	pop	a
 207                     ; 51 	if (UART1_GetFlagStatus(UART1_FLAG_OR) == SET) {
 209  007e ae0008        	ldw	x,#8
 210  0081 cd0000        	call	_UART1_GetFlagStatus
 212  0084 a101          	cp	a,#1
 213  0086 2603          	jrne	L56
 214                     ; 52 		UART1_ReceiveData8();
 216  0088 cd0000        	call	_UART1_ReceiveData8
 218  008b               L56:
 219                     ; 54 }
 222  008b 85            	popw	x
 223  008c bf00          	ldw	c_y,x
 224  008e 320002        	pop	c_y+2
 225  0091 85            	popw	x
 226  0092 bf00          	ldw	c_x,x
 227  0094 320002        	pop	c_x+2
 228  0097 80            	iret
 252                     ; 56 static void CLK_Config(void)
 252                     ; 57 {
 254                     	switch	.text
 255  0098               L3_CLK_Config:
 259                     ; 58 	CLK_DeInit();
 261  0098 cd0000        	call	_CLK_DeInit
 263                     ; 59 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 265  009b a680          	ld	a,#128
 266  009d cd0000        	call	_CLK_SYSCLKConfig
 268                     ; 60 	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);	
 270  00a0 4f            	clr	a
 271  00a1 cd0000        	call	_CLK_SYSCLKConfig
 273                     ; 61 }
 276  00a4 81            	ret
 301                     ; 63 static void GPIO_Config(void)
 301                     ; 64 {
 302                     	switch	.text
 303  00a5               L5_GPIO_Config:
 307                     ; 65 	GPIO_DeInit(GPIOB);
 309  00a5 ae5005        	ldw	x,#20485
 310  00a8 cd0000        	call	_GPIO_DeInit
 312                     ; 66 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
 314  00ab 4be0          	push	#224
 315  00ad 4b20          	push	#32
 316  00af ae5005        	ldw	x,#20485
 317  00b2 cd0000        	call	_GPIO_Init
 319  00b5 85            	popw	x
 320                     ; 67 }
 323  00b6 81            	ret
 350                     ; 69 static void UART1_Config(void)
 350                     ; 70 {
 351                     	switch	.text
 352  00b7               L7_UART1_Config:
 356                     ; 71 	UART1_DeInit();
 358  00b7 cd0000        	call	_UART1_DeInit
 360                     ; 72 	UART1_Init(9600, 
 360                     ; 73 							UART1_WORDLENGTH_8D, 
 360                     ; 74 							UART1_STOPBITS_1, 
 360                     ; 75 							UART1_PARITY_NO, 
 360                     ; 76 							UART1_SYNCMODE_CLOCK_DISABLE, 
 360                     ; 77 							UART1_MODE_TXRX_ENABLE);
 362  00ba 4b0c          	push	#12
 363  00bc 4b80          	push	#128
 364  00be 4b00          	push	#0
 365  00c0 4b00          	push	#0
 366  00c2 4b00          	push	#0
 367  00c4 ae2580        	ldw	x,#9600
 368  00c7 89            	pushw	x
 369  00c8 ae0000        	ldw	x,#0
 370  00cb 89            	pushw	x
 371  00cc cd0000        	call	_UART1_Init
 373  00cf 5b09          	addw	sp,#9
 374                     ; 80 	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
 376  00d1 4b01          	push	#1
 377  00d3 ae0205        	ldw	x,#517
 378  00d6 cd0000        	call	_UART1_ITConfig
 380  00d9 84            	pop	a
 381                     ; 81 	UART1_Cmd(ENABLE);	
 383  00da a601          	ld	a,#1
 384  00dc cd0000        	call	_UART1_Cmd
 386                     ; 82 }
 389  00df 81            	ret
 425                     ; 84 static void Sheller_Config(void)
 425                     ; 85 {
 426                     	switch	.text
 427  00e0               L11_Sheller_Config:
 429  00e0 88            	push	a
 430       00000001      OFST:	set	1
 433                     ; 86 	uint8_t init_result = sheller_init(&shell, 0x23, SHELLER_DATA_LENGTH, 128);
 435  00e1 ae0080        	ldw	x,#128
 436  00e4 89            	pushw	x
 437  00e5 4b08          	push	#8
 438  00e7 4b23          	push	#35
 439  00e9 ae001c        	ldw	x,#_shell
 440  00ec cd0000        	call	_sheller_init
 442  00ef 5b04          	addw	sp,#4
 443  00f1 6b01          	ld	(OFST+0,sp),a
 445                     ; 87 	if (init_result == SHELLER_ERROR) {
 447  00f3 0d01          	tnz	(OFST+0,sp)
 448  00f5 2602          	jrne	L531
 449  00f7               L731:
 450                     ; 88 		while(1);
 452  00f7 20fe          	jra	L731
 453  00f9               L531:
 454                     ; 90 }
 457  00f9 84            	pop	a
 458  00fa 81            	ret
 492                     ; 92 static void delay_ticks(uint32_t t) {
 493                     	switch	.text
 494  00fb               L31_delay_ticks:
 496       00000000      OFST:	set	0
 499  00fb               L361:
 500                     ; 93     while(--t);
 502  00fb 96            	ldw	x,sp
 503  00fc 1c0003        	addw	x,#OFST+3
 504  00ff a601          	ld	a,#1
 505  0101 cd0000        	call	c_lgsbc
 507  0104 96            	ldw	x,sp
 508  0105 1c0003        	addw	x,#OFST+3
 509  0108 cd0000        	call	c_lzmp
 511  010b 26ee          	jrne	L361
 512                     ; 94 }
 515  010d 81            	ret
 550                     ; 97 void assert_failed(uint8_t* file, uint32_t line)
 550                     ; 98 {
 551                     	switch	.text
 552  010e               _assert_failed:
 556  010e               L502:
 557  010e 20fe          	jra	L502
 719                     	xdef	_main
 720                     	xdef	f_UART1_RX_IRQ
 721                     	switch	.ubsct
 722  0000               _transmitMessage:
 723  0000 000000000000  	ds.b	8
 724                     	xdef	_transmitMessage
 725  0008               _transmitMessageIndex:
 726  0008 00            	ds.b	1
 727                     	xdef	_transmitMessageIndex
 728  0009               _transmitBuffer:
 729  0009 000000000000  	ds.b	11
 730                     	xdef	_transmitBuffer
 731  0014               _receiveBuffer:
 732  0014 000000000000  	ds.b	8
 733                     	xdef	_receiveBuffer
 734  001c               _shell:
 735  001c 000000000000  	ds.b	18
 736                     	xdef	_shell
 737                     	xref	_sheller_wrap
 738                     	xref	_sheller_read
 739                     	xref	_sheller_push
 740                     	xref	_sheller_init
 741                     	xdef	_assert_failed
 742                     	xref	_UART1_GetFlagStatus
 743                     	xref	_UART1_SendData8
 744                     	xref	_UART1_ReceiveData8
 745                     	xref	_UART1_ITConfig
 746                     	xref	_UART1_Cmd
 747                     	xref	_UART1_Init
 748                     	xref	_UART1_DeInit
 749                     	xref	_GPIO_WriteReverse
 750                     	xref	_GPIO_Init
 751                     	xref	_GPIO_DeInit
 752                     	xref	_CLK_SYSCLKConfig
 753                     	xref	_CLK_DeInit
 754                     	xref.b	c_x
 755                     	xref.b	c_y
 775                     	xref	c_lzmp
 776                     	xref	c_lgsbc
 777                     	end
