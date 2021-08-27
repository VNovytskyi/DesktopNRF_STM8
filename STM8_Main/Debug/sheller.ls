   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
  83                     ; 3 static void increase_circular_value(uint16_t *value, const uint16_t amount, const uint16_t max_value)
  83                     ; 4 {
  85                     	switch	.text
  86  0000               L3_increase_circular_value:
  88  0000 89            	pushw	x
  89  0001 89            	pushw	x
  90       00000002      OFST:	set	2
  93                     ; 6     for (i = 0; i < amount; ++i) {
  95  0002 5f            	clrw	x
  96  0003 1f01          	ldw	(OFST-1,sp),x
  99  0005 2013          	jra	L15
 100  0007               L54:
 101                     ; 7         *value = (*value + 1) % max_value;
 103  0007 1e03          	ldw	x,(OFST+1,sp)
 104  0009 fe            	ldw	x,(x)
 105  000a 5c            	incw	x
 106  000b 1609          	ldw	y,(OFST+7,sp)
 107  000d 65            	divw	x,y
 108  000e 51            	exgw	x,y
 109  000f 1603          	ldw	y,(OFST+1,sp)
 110  0011 90ff          	ldw	(y),x
 111                     ; 6     for (i = 0; i < amount; ++i) {
 113  0013 1e01          	ldw	x,(OFST-1,sp)
 114  0015 1c0001        	addw	x,#1
 115  0018 1f01          	ldw	(OFST-1,sp),x
 117  001a               L15:
 120  001a 1e01          	ldw	x,(OFST-1,sp)
 121  001c 1307          	cpw	x,(OFST+5,sp)
 122  001e 25e7          	jrult	L54
 123                     ; 9 }
 126  0020 5b04          	addw	sp,#4
 127  0022 81            	ret
 249                     ; 11 static uint8_t sheller_found_start_byte(sheller_t *desc)
 249                     ; 12 {
 250                     	switch	.text
 251  0023               L55_sheller_found_start_byte:
 253  0023 89            	pushw	x
 254  0024 89            	pushw	x
 255       00000002      OFST:	set	2
 258                     ; 13     if ((desc->rx_buff_begin == desc->rx_buff_end) && desc->rx_buff_empty_flag == 0) {
 260  0025 9093          	ldw	y,x
 261  0027 ee08          	ldw	x,(8,x)
 262  0029 90e30a        	cpw	x,(10,y)
 263  002c 2666          	jrne	L351
 265  002e 1e03          	ldw	x,(OFST+1,sp)
 266  0030 6d05          	tnz	(5,x)
 267  0032 2660          	jrne	L351
 268                     ; 14         uint16_t i = 0;
 270                     ; 15         for (i = 0; i < desc->rx_buff_length; ++i) {
 272  0034 5f            	clrw	x
 273  0035 1f01          	ldw	(OFST-1,sp),x
 276  0037 203a          	jra	L141
 277  0039               L531:
 278                     ; 16             if(desc->rx_buff[desc->rx_buff_begin] == desc->start_byte) {
 280  0039 1e03          	ldw	x,(OFST+1,sp)
 281  003b ee08          	ldw	x,(8,x)
 282  003d 1603          	ldw	y,(OFST+1,sp)
 283  003f 90ee06        	ldw	y,(6,y)
 284  0042 90bf00        	ldw	c_x,y
 285  0045 92d600        	ld	a,([c_x.w],x)
 286  0048 1e03          	ldw	x,(OFST+1,sp)
 287  004a f1            	cp	a,(x)
 288  004b 260d          	jrne	L541
 289                     ; 17                 desc->start_byte_pos = desc->rx_buff_begin;
 291  004d 1e03          	ldw	x,(OFST+1,sp)
 292  004f 9093          	ldw	y,x
 293  0051 90ee08        	ldw	y,(8,y)
 294  0054 ef0c          	ldw	(12,x),y
 295                     ; 18                 return 1;
 297  0056 a601          	ld	a,#1
 299  0058 2078          	jra	L01
 300  005a               L541:
 301                     ; 20             increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
 303  005a 1e03          	ldw	x,(OFST+1,sp)
 304  005c ee02          	ldw	x,(2,x)
 305  005e 89            	pushw	x
 306  005f ae0001        	ldw	x,#1
 307  0062 89            	pushw	x
 308  0063 1e07          	ldw	x,(OFST+5,sp)
 309  0065 1c0008        	addw	x,#8
 310  0068 ad96          	call	L3_increase_circular_value
 312  006a 5b04          	addw	sp,#4
 313                     ; 15         for (i = 0; i < desc->rx_buff_length; ++i) {
 315  006c 1e01          	ldw	x,(OFST-1,sp)
 316  006e 1c0001        	addw	x,#1
 317  0071 1f01          	ldw	(OFST-1,sp),x
 319  0073               L141:
 322  0073 1e03          	ldw	x,(OFST+1,sp)
 323  0075 9093          	ldw	y,x
 324  0077 51            	exgw	x,y
 325  0078 ee02          	ldw	x,(2,x)
 326  007a 1301          	cpw	x,(OFST-1,sp)
 327  007c 51            	exgw	x,y
 328  007d 22ba          	jrugt	L531
 330  007f 2054          	jra	L741
 331  0081               L151:
 332                     ; 24             increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
 334  0081 1e03          	ldw	x,(OFST+1,sp)
 335  0083 ee02          	ldw	x,(2,x)
 336  0085 89            	pushw	x
 337  0086 ae0001        	ldw	x,#1
 338  0089 89            	pushw	x
 339  008a 1e07          	ldw	x,(OFST+5,sp)
 340  008c 1c0008        	addw	x,#8
 341  008f cd0000        	call	L3_increase_circular_value
 343  0092 5b04          	addw	sp,#4
 344  0094               L351:
 345                     ; 23         while((desc->rx_buff[desc->rx_buff_begin] != desc->start_byte) && (desc->rx_buff_begin != desc->rx_buff_end)) {
 347  0094 1e03          	ldw	x,(OFST+1,sp)
 348  0096 ee08          	ldw	x,(8,x)
 349  0098 1603          	ldw	y,(OFST+1,sp)
 350  009a 90ee06        	ldw	y,(6,y)
 351  009d 90bf00        	ldw	c_x,y
 352  00a0 92d600        	ld	a,([c_x.w],x)
 353  00a3 1e03          	ldw	x,(OFST+1,sp)
 354  00a5 f1            	cp	a,(x)
 355  00a6 270b          	jreq	L751
 357  00a8 1e03          	ldw	x,(OFST+1,sp)
 358  00aa 1603          	ldw	y,(OFST+1,sp)
 359  00ac ee08          	ldw	x,(8,x)
 360  00ae 90e30a        	cpw	x,(10,y)
 361  00b1 26ce          	jrne	L151
 362  00b3               L751:
 363                     ; 27         if (desc->rx_buff[desc->rx_buff_begin] == desc->start_byte) {
 365  00b3 1e03          	ldw	x,(OFST+1,sp)
 366  00b5 ee08          	ldw	x,(8,x)
 367  00b7 1603          	ldw	y,(OFST+1,sp)
 368  00b9 90ee06        	ldw	y,(6,y)
 369  00bc 90bf00        	ldw	c_x,y
 370  00bf 92d600        	ld	a,([c_x.w],x)
 371  00c2 1e03          	ldw	x,(OFST+1,sp)
 372  00c4 f1            	cp	a,(x)
 373  00c5 260e          	jrne	L741
 374                     ; 28             desc->start_byte_pos = desc->rx_buff_begin;
 376  00c7 1e03          	ldw	x,(OFST+1,sp)
 377  00c9 9093          	ldw	y,x
 378  00cb 90ee08        	ldw	y,(8,y)
 379  00ce ef0c          	ldw	(12,x),y
 380                     ; 29             return 1;
 382  00d0 a601          	ld	a,#1
 384  00d2               L01:
 386  00d2 5b04          	addw	sp,#4
 387  00d4 81            	ret
 388  00d5               L741:
 389                     ; 33     return 0;
 391  00d5 4f            	clr	a
 393  00d6 20fa          	jra	L01
 497                     ; 36 static uint8_t sheller_try_read_data(sheller_t *desc)
 497                     ; 37 {
 498                     	switch	.text
 499  00d8               L361_sheller_try_read_data:
 501  00d8 89            	pushw	x
 502  00d9 520a          	subw	sp,#10
 503       0000000a      OFST:	set	10
 506                     ; 38     uint8_t i = 0;
 508                     ; 46     received_crc_position = desc->rx_buff_begin;
 510  00db ee08          	ldw	x,(8,x)
 511  00dd 1f06          	ldw	(OFST-4,sp),x
 513                     ; 47     increase_circular_value(&received_crc_position, desc->usefull_data_length + 1, desc->rx_buff_length);
 515  00df 1e0b          	ldw	x,(OFST+1,sp)
 516  00e1 ee02          	ldw	x,(2,x)
 517  00e3 89            	pushw	x
 518  00e4 1e0d          	ldw	x,(OFST+3,sp)
 519  00e6 e601          	ld	a,(1,x)
 520  00e8 5f            	clrw	x
 521  00e9 97            	ld	xl,a
 522  00ea 5c            	incw	x
 523  00eb 89            	pushw	x
 524  00ec 96            	ldw	x,sp
 525  00ed 1c000a        	addw	x,#OFST+0
 526  00f0 cd0000        	call	L3_increase_circular_value
 528  00f3 5b04          	addw	sp,#4
 529                     ; 48     received_crc_l = desc->rx_buff[received_crc_position];
 531  00f5 1e0b          	ldw	x,(OFST+1,sp)
 532  00f7 ee06          	ldw	x,(6,x)
 533  00f9 72fb06        	addw	x,(OFST-4,sp)
 534  00fc f6            	ld	a,(x)
 535  00fd 6b03          	ld	(OFST-7,sp),a
 537                     ; 49     increase_circular_value(&received_crc_position, 1, desc->rx_buff_length);
 539  00ff 1e0b          	ldw	x,(OFST+1,sp)
 540  0101 ee02          	ldw	x,(2,x)
 541  0103 89            	pushw	x
 542  0104 ae0001        	ldw	x,#1
 543  0107 89            	pushw	x
 544  0108 96            	ldw	x,sp
 545  0109 1c000a        	addw	x,#OFST+0
 546  010c cd0000        	call	L3_increase_circular_value
 548  010f 5b04          	addw	sp,#4
 549                     ; 50     received_crc_h = desc->rx_buff[received_crc_position];
 551  0111 1e0b          	ldw	x,(OFST+1,sp)
 552  0113 ee06          	ldw	x,(6,x)
 553  0115 72fb06        	addw	x,(OFST-4,sp)
 554  0118 f6            	ld	a,(x)
 555  0119 6b0a          	ld	(OFST+0,sp),a
 557                     ; 51     received_crc = received_crc_l | ((uint16_t)received_crc_h << 8);
 559  011b 7b0a          	ld	a,(OFST+0,sp)
 560  011d 5f            	clrw	x
 561  011e 97            	ld	xl,a
 562  011f 7b03          	ld	a,(OFST-7,sp)
 563  0121 02            	rlwa	x,a
 564  0122 1f01          	ldw	(OFST-9,sp),x
 566                     ; 53     calculate_crc = 0xFFFF;
 568  0124 aeffff        	ldw	x,#65535
 569  0127 1f04          	ldw	(OFST-6,sp),x
 571                     ; 54     begin = desc->rx_buff_begin;
 573  0129 1e0b          	ldw	x,(OFST+1,sp)
 574  012b ee08          	ldw	x,(8,x)
 575  012d 1f08          	ldw	(OFST-2,sp),x
 577                     ; 55     increase_circular_value(&begin, 1, desc->rx_buff_length);
 579  012f 1e0b          	ldw	x,(OFST+1,sp)
 580  0131 ee02          	ldw	x,(2,x)
 581  0133 89            	pushw	x
 582  0134 ae0001        	ldw	x,#1
 583  0137 89            	pushw	x
 584  0138 96            	ldw	x,sp
 585  0139 1c000c        	addw	x,#OFST+2
 586  013c cd0000        	call	L3_increase_circular_value
 588  013f 5b04          	addw	sp,#4
 589                     ; 56     for (i = 0; i < desc->usefull_data_length; ++i) {
 591  0141 0f0a          	clr	(OFST+0,sp)
 594  0143 2025          	jra	L542
 595  0145               L142:
 596                     ; 57         get_crc_by_byte(&calculate_crc, desc->rx_buff[begin]);
 598  0145 1e0b          	ldw	x,(OFST+1,sp)
 599  0147 ee06          	ldw	x,(6,x)
 600  0149 72fb08        	addw	x,(OFST-2,sp)
 601  014c f6            	ld	a,(x)
 602  014d 88            	push	a
 603  014e 96            	ldw	x,sp
 604  014f 1c0005        	addw	x,#OFST-5
 605  0152 cd0000        	call	_get_crc_by_byte
 607  0155 84            	pop	a
 608                     ; 58         increase_circular_value(&begin, 1, desc->rx_buff_length);
 610  0156 1e0b          	ldw	x,(OFST+1,sp)
 611  0158 ee02          	ldw	x,(2,x)
 612  015a 89            	pushw	x
 613  015b ae0001        	ldw	x,#1
 614  015e 89            	pushw	x
 615  015f 96            	ldw	x,sp
 616  0160 1c000c        	addw	x,#OFST+2
 617  0163 cd0000        	call	L3_increase_circular_value
 619  0166 5b04          	addw	sp,#4
 620                     ; 56     for (i = 0; i < desc->usefull_data_length; ++i) {
 622  0168 0c0a          	inc	(OFST+0,sp)
 624  016a               L542:
 627  016a 1e0b          	ldw	x,(OFST+1,sp)
 628  016c e601          	ld	a,(1,x)
 629  016e 110a          	cp	a,(OFST+0,sp)
 630  0170 22d3          	jrugt	L142
 631                     ; 61     if (calculate_crc == received_crc) {
 633  0172 1e04          	ldw	x,(OFST-6,sp)
 634  0174 1301          	cpw	x,(OFST-9,sp)
 635  0176 2604          	jrne	L152
 636                     ; 62         return 1;
 638  0178 a601          	ld	a,#1
 640  017a 2001          	jra	L41
 641  017c               L152:
 642                     ; 65     return 0;
 644  017c 4f            	clr	a
 646  017d               L41:
 648  017d 5b0c          	addw	sp,#12
 649  017f 81            	ret
 707                     ; 68 static void sheller_write_received_package(sheller_t *desc, uint8_t *dest)
 707                     ; 69 {
 708                     	switch	.text
 709  0180               L352_sheller_write_received_package:
 711  0180 89            	pushw	x
 712  0181 88            	push	a
 713       00000001      OFST:	set	1
 716                     ; 70 		uint8_t i = 0;
 718                     ; 71     for (i = 0; i < desc->usefull_data_length; ++i) {
 720  0182 0f01          	clr	(OFST+0,sp)
 723  0184 202e          	jra	L113
 724  0186               L503:
 725                     ; 72         increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
 727  0186 1e02          	ldw	x,(OFST+1,sp)
 728  0188 ee02          	ldw	x,(2,x)
 729  018a 89            	pushw	x
 730  018b ae0001        	ldw	x,#1
 731  018e 89            	pushw	x
 732  018f 1e06          	ldw	x,(OFST+5,sp)
 733  0191 1c0008        	addw	x,#8
 734  0194 cd0000        	call	L3_increase_circular_value
 736  0197 5b04          	addw	sp,#4
 737                     ; 73         dest[i] = desc->rx_buff[desc->rx_buff_begin];
 739  0199 7b01          	ld	a,(OFST+0,sp)
 740  019b 5f            	clrw	x
 741  019c 97            	ld	xl,a
 742  019d 72fb06        	addw	x,(OFST+5,sp)
 743  01a0 89            	pushw	x
 744  01a1 1e04          	ldw	x,(OFST+3,sp)
 745  01a3 ee08          	ldw	x,(8,x)
 746  01a5 1604          	ldw	y,(OFST+3,sp)
 747  01a7 90ee06        	ldw	y,(6,y)
 748  01aa 90bf00        	ldw	c_x,y
 749  01ad 92d600        	ld	a,([c_x.w],x)
 750  01b0 85            	popw	x
 751  01b1 f7            	ld	(x),a
 752                     ; 71     for (i = 0; i < desc->usefull_data_length; ++i) {
 754  01b2 0c01          	inc	(OFST+0,sp)
 756  01b4               L113:
 759  01b4 1e02          	ldw	x,(OFST+1,sp)
 760  01b6 e601          	ld	a,(1,x)
 761  01b8 1101          	cp	a,(OFST+0,sp)
 762  01ba 22ca          	jrugt	L503
 763                     ; 76     if (desc->rx_buff_begin == desc->rx_buff_end) {
 765  01bc 1e02          	ldw	x,(OFST+1,sp)
 766  01be 1602          	ldw	y,(OFST+1,sp)
 767  01c0 ee08          	ldw	x,(8,x)
 768  01c2 90e30a        	cpw	x,(10,y)
 769  01c5 2606          	jrne	L513
 770                     ; 77         desc->rx_buff_empty_flag = 1;
 772  01c7 1e02          	ldw	x,(OFST+1,sp)
 773  01c9 a601          	ld	a,#1
 774  01cb e705          	ld	(5,x),a
 775  01cd               L513:
 776                     ; 79 }
 779  01cd 5b03          	addw	sp,#3
 780  01cf 81            	ret
 827                     ; 81 static uint16_t sheller_get_circular_buff_length(sheller_t *desc)
 827                     ; 82 {
 828                     	switch	.text
 829  01d0               L713_sheller_get_circular_buff_length:
 831  01d0 89            	pushw	x
 832  01d1 89            	pushw	x
 833       00000002      OFST:	set	2
 836                     ; 83     uint16_t value = 0;
 838  01d2 5f            	clrw	x
 839  01d3 1f01          	ldw	(OFST-1,sp),x
 841                     ; 84     if (desc != NULL) {
 843  01d5 1e03          	ldw	x,(OFST+1,sp)
 844  01d7 2753          	jreq	L543
 845                     ; 85         if (desc->rx_buff_end > desc->rx_buff_begin) {
 847  01d9 1e03          	ldw	x,(OFST+1,sp)
 848  01db 1603          	ldw	y,(OFST+1,sp)
 849  01dd ee0a          	ldw	x,(10,x)
 850  01df 90e308        	cpw	x,(8,y)
 851  01e2 2313          	jrule	L743
 852                     ; 86             value = desc->rx_buff_end - desc->rx_buff_begin;
 854  01e4 1e03          	ldw	x,(OFST+1,sp)
 855  01e6 ee0a          	ldw	x,(10,x)
 856  01e8 1603          	ldw	y,(OFST+1,sp)
 857  01ea 01            	rrwa	x,a
 858  01eb 90e009        	sub	a,(9,y)
 859  01ee 01            	rrwa	x,a
 860  01ef 90e208        	sbc	a,(8,y)
 861  01f2 01            	rrwa	x,a
 862  01f3 1f01          	ldw	(OFST-1,sp),x
 865  01f5 2035          	jra	L543
 866  01f7               L743:
 867                     ; 87         } else if (desc->rx_buff_end < desc->rx_buff_begin) {
 869  01f7 1e03          	ldw	x,(OFST+1,sp)
 870  01f9 1603          	ldw	y,(OFST+1,sp)
 871  01fb ee0a          	ldw	x,(10,x)
 872  01fd 90e308        	cpw	x,(8,y)
 873  0200 241e          	jruge	L353
 874                     ; 88             value = (desc->rx_buff_length - desc->rx_buff_begin) + desc->rx_buff_end;
 876  0202 1e03          	ldw	x,(OFST+1,sp)
 877  0204 ee02          	ldw	x,(2,x)
 878  0206 1603          	ldw	y,(OFST+1,sp)
 879  0208 01            	rrwa	x,a
 880  0209 90e009        	sub	a,(9,y)
 881  020c 01            	rrwa	x,a
 882  020d 90e208        	sbc	a,(8,y)
 883  0210 01            	rrwa	x,a
 884  0211 1603          	ldw	y,(OFST+1,sp)
 885  0213 01            	rrwa	x,a
 886  0214 90eb0b        	add	a,(11,y)
 887  0217 01            	rrwa	x,a
 888  0218 90e90a        	adc	a,(10,y)
 889  021b 01            	rrwa	x,a
 890  021c 1f01          	ldw	(OFST-1,sp),x
 893  021e 200c          	jra	L543
 894  0220               L353:
 895                     ; 89         } else if (desc->rx_buff_empty_flag == 0) {
 897  0220 1e03          	ldw	x,(OFST+1,sp)
 898  0222 6d05          	tnz	(5,x)
 899  0224 2606          	jrne	L543
 900                     ; 90             value = desc->rx_buff_length;
 902  0226 1e03          	ldw	x,(OFST+1,sp)
 903  0228 ee02          	ldw	x,(2,x)
 904  022a 1f01          	ldw	(OFST-1,sp),x
 906  022c               L543:
 907                     ; 94     return value;
 909  022c 1e01          	ldw	x,(OFST-1,sp)
 912  022e 5b04          	addw	sp,#4
 913  0230 81            	ret
 988                     ; 104 uint8_t sheller_init(sheller_t *desc, uint8_t start_byte, uint8_t usefull_data_length, uint16_t rx_buff_length)
 988                     ; 105 {
 989                     	switch	.text
 990  0231               _sheller_init:
 992  0231 89            	pushw	x
 993  0232 88            	push	a
 994       00000001      OFST:	set	1
 997                     ; 106     uint8_t init_result = SHELLER_OK;
 999  0233 a601          	ld	a,#1
1000  0235 6b01          	ld	(OFST+0,sp),a
1002                     ; 107     if (desc != NULL) {
1004  0237 a30000        	cpw	x,#0
1005  023a 273f          	jreq	L124
1006                     ; 108         desc->start_byte = start_byte;
1008  023c 7b06          	ld	a,(OFST+5,sp)
1009  023e 1e02          	ldw	x,(OFST+1,sp)
1010  0240 f7            	ld	(x),a
1011                     ; 109         desc->usefull_data_length = usefull_data_length;
1013  0241 7b07          	ld	a,(OFST+6,sp)
1014  0243 1e02          	ldw	x,(OFST+1,sp)
1015  0245 e701          	ld	(1,x),a
1016                     ; 110         desc->rx_buff_length = rx_buff_length;
1018  0247 1e02          	ldw	x,(OFST+1,sp)
1019  0249 1608          	ldw	y,(OFST+7,sp)
1020  024b ef02          	ldw	(2,x),y
1021                     ; 111         desc->rx_buff_begin = 0;
1023  024d 1e02          	ldw	x,(OFST+1,sp)
1024  024f 905f          	clrw	y
1025  0251 ef08          	ldw	(8,x),y
1026                     ; 112         desc->rx_buff_end   = 0;
1028  0253 1e02          	ldw	x,(OFST+1,sp)
1029  0255 905f          	clrw	y
1030  0257 ef0a          	ldw	(10,x),y
1031                     ; 113         desc->rx_buff_empty_flag = 1;
1033  0259 1e02          	ldw	x,(OFST+1,sp)
1034  025b a601          	ld	a,#1
1035  025d e705          	ld	(5,x),a
1036                     ; 114         desc->start_byte_pos = 0;
1038  025f 1e02          	ldw	x,(OFST+1,sp)
1039  0261 905f          	clrw	y
1040  0263 ef0c          	ldw	(12,x),y
1041                     ; 116         desc->rx_buff = (uint8_t*)malloc(desc->rx_buff_length);
1043  0265 1e02          	ldw	x,(OFST+1,sp)
1044  0267 ee02          	ldw	x,(2,x)
1045  0269 cd0000        	call	_malloc
1047  026c 1602          	ldw	y,(OFST+1,sp)
1048  026e 90ef06        	ldw	(6,y),x
1049                     ; 117         if (desc->rx_buff == NULL) {
1051  0271 1e02          	ldw	x,(OFST+1,sp)
1052  0273 e607          	ld	a,(7,x)
1053  0275 ea06          	or	a,(6,x)
1054  0277 2602          	jrne	L124
1055                     ; 118             init_result = SHELLER_ERROR;
1057  0279 0f01          	clr	(OFST+0,sp)
1059  027b               L124:
1060                     ; 122     return init_result;
1062  027b 7b01          	ld	a,(OFST+0,sp)
1065  027d 5b03          	addw	sp,#3
1066  027f 81            	ret
1121                     ; 132 uint8_t sheller_push(sheller_t *desc, const uint8_t byte)
1121                     ; 133 {
1122                     	switch	.text
1123  0280               _sheller_push:
1125  0280 89            	pushw	x
1126  0281 88            	push	a
1127       00000001      OFST:	set	1
1130                     ; 134     uint8_t work_result = SHELLER_ERROR;
1132  0282 0f01          	clr	(OFST+0,sp)
1134                     ; 135     if (desc != NULL) {
1136  0284 a30000        	cpw	x,#0
1137  0287 273b          	jreq	L554
1138                     ; 136         if (desc->rx_buff_end != desc->rx_buff_begin || desc->rx_buff_empty_flag == 1) {
1140  0289 9093          	ldw	y,x
1141  028b ee0a          	ldw	x,(10,x)
1142  028d 90e308        	cpw	x,(8,y)
1143  0290 2608          	jrne	L164
1145  0292 1e02          	ldw	x,(OFST+1,sp)
1146  0294 e605          	ld	a,(5,x)
1147  0296 a101          	cp	a,#1
1148  0298 262a          	jrne	L554
1149  029a               L164:
1150                     ; 137             desc->rx_buff_empty_flag = 0;
1152  029a 1e02          	ldw	x,(OFST+1,sp)
1153  029c 6f05          	clr	(5,x)
1154                     ; 138             desc->rx_buff[desc->rx_buff_end] = byte;
1156  029e 7b06          	ld	a,(OFST+5,sp)
1157  02a0 1e02          	ldw	x,(OFST+1,sp)
1158  02a2 ee0a          	ldw	x,(10,x)
1159  02a4 1602          	ldw	y,(OFST+1,sp)
1160  02a6 90ee06        	ldw	y,(6,y)
1161  02a9 90bf00        	ldw	c_x,y
1162  02ac 92d700        	ld	([c_x.w],x),a
1163                     ; 139             desc->rx_buff_end = (desc->rx_buff_end + 1) % desc->rx_buff_length;
1165  02af 1e02          	ldw	x,(OFST+1,sp)
1166  02b1 ee0a          	ldw	x,(10,x)
1167  02b3 5c            	incw	x
1168  02b4 1602          	ldw	y,(OFST+1,sp)
1169  02b6 90ee02        	ldw	y,(2,y)
1170  02b9 65            	divw	x,y
1171  02ba 51            	exgw	x,y
1172  02bb 1602          	ldw	y,(OFST+1,sp)
1173  02bd 90ef0a        	ldw	(10,y),x
1174                     ; 140             work_result = SHELLER_OK;
1176  02c0 a601          	ld	a,#1
1177  02c2 6b01          	ld	(OFST+0,sp),a
1179  02c4               L554:
1180                     ; 144     return work_result;
1182  02c4 7b01          	ld	a,(OFST+0,sp)
1185  02c6 5b03          	addw	sp,#3
1186  02c8 81            	ret
1248                     ; 156 uint8_t sheller_read(sheller_t *desc, uint8_t *dest)
1248                     ; 157 {
1249                     	switch	.text
1250  02c9               _sheller_read:
1252  02c9 89            	pushw	x
1253  02ca 5203          	subw	sp,#3
1254       00000003      OFST:	set	3
1257                     ; 158     uint8_t result = SHELLER_ERROR;
1259  02cc 0f03          	clr	(OFST+0,sp)
1261                     ; 159     if (desc != NULL && dest != NULL) {
1263  02ce a30000        	cpw	x,#0
1264  02d1 2603cc0354    	jreq	L315
1266  02d6 1e08          	ldw	x,(OFST+5,sp)
1267  02d8 277a          	jreq	L315
1268                     ; 160         if (sheller_get_circular_buff_length(desc) >= sheller_get_package_length(desc)) {
1270  02da 1e04          	ldw	x,(OFST+1,sp)
1271  02dc cd03e2        	call	_sheller_get_package_length
1273  02df 5f            	clrw	x
1274  02e0 97            	ld	xl,a
1275  02e1 1f01          	ldw	(OFST-2,sp),x
1277  02e3 1e04          	ldw	x,(OFST+1,sp)
1278  02e5 cd01d0        	call	L713_sheller_get_circular_buff_length
1280  02e8 1301          	cpw	x,(OFST-2,sp)
1281  02ea 2568          	jrult	L315
1282                     ; 161             if (sheller_found_start_byte(desc)) {
1284  02ec 1e04          	ldw	x,(OFST+1,sp)
1285  02ee cd0023        	call	L55_sheller_found_start_byte
1287  02f1 4d            	tnz	a
1288  02f2 2760          	jreq	L315
1289                     ; 162                 if (sheller_get_circular_buff_length(desc) >= sheller_get_package_length(desc)) {
1291  02f4 1e04          	ldw	x,(OFST+1,sp)
1292  02f6 cd03e2        	call	_sheller_get_package_length
1294  02f9 5f            	clrw	x
1295  02fa 97            	ld	xl,a
1296  02fb 1f01          	ldw	(OFST-2,sp),x
1298  02fd 1e04          	ldw	x,(OFST+1,sp)
1299  02ff cd01d0        	call	L713_sheller_get_circular_buff_length
1301  0302 1301          	cpw	x,(OFST-2,sp)
1302  0304 254e          	jrult	L315
1303                     ; 163                     if (sheller_try_read_data(desc)) {
1305  0306 1e04          	ldw	x,(OFST+1,sp)
1306  0308 cd00d8        	call	L361_sheller_try_read_data
1308  030b 4d            	tnz	a
1309  030c 2722          	jreq	L325
1310                     ; 164                         sheller_write_received_package(desc, dest);
1312  030e 1e08          	ldw	x,(OFST+5,sp)
1313  0310 89            	pushw	x
1314  0311 1e06          	ldw	x,(OFST+3,sp)
1315  0313 cd0180        	call	L352_sheller_write_received_package
1317  0316 85            	popw	x
1318                     ; 165                         increase_circular_value(&desc->rx_buff_begin, 3, desc->rx_buff_length);
1320  0317 1e04          	ldw	x,(OFST+1,sp)
1321  0319 ee02          	ldw	x,(2,x)
1322  031b 89            	pushw	x
1323  031c ae0003        	ldw	x,#3
1324  031f 89            	pushw	x
1325  0320 1e08          	ldw	x,(OFST+5,sp)
1326  0322 1c0008        	addw	x,#8
1327  0325 cd0000        	call	L3_increase_circular_value
1329  0328 5b04          	addw	sp,#4
1330                     ; 166                         result = SHELLER_OK;
1332  032a a601          	ld	a,#1
1333  032c 6b03          	ld	(OFST+0,sp),a
1336  032e 2013          	jra	L525
1337  0330               L325:
1338                     ; 168                         increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
1340  0330 1e04          	ldw	x,(OFST+1,sp)
1341  0332 ee02          	ldw	x,(2,x)
1342  0334 89            	pushw	x
1343  0335 ae0001        	ldw	x,#1
1344  0338 89            	pushw	x
1345  0339 1e08          	ldw	x,(OFST+5,sp)
1346  033b 1c0008        	addw	x,#8
1347  033e cd0000        	call	L3_increase_circular_value
1349  0341 5b04          	addw	sp,#4
1350  0343               L525:
1351                     ; 171                     if (desc->rx_buff_begin == desc->rx_buff_end) {
1353  0343 1e04          	ldw	x,(OFST+1,sp)
1354  0345 1604          	ldw	y,(OFST+1,sp)
1355  0347 ee08          	ldw	x,(8,x)
1356  0349 90e30a        	cpw	x,(10,y)
1357  034c 2606          	jrne	L315
1358                     ; 172                         desc->rx_buff_empty_flag = 1;
1360  034e 1e04          	ldw	x,(OFST+1,sp)
1361  0350 a601          	ld	a,#1
1362  0352 e705          	ld	(5,x),a
1363  0354               L315:
1364                     ; 179     return result;
1366  0354 7b03          	ld	a,(OFST+0,sp)
1369  0356 5b05          	addw	sp,#5
1370  0358 81            	ret
1458                     ; 191 uint8_t sheller_wrap(sheller_t *desc, uint8_t *data, const uint8_t data_length, uint8_t *dest)
1458                     ; 192 {
1459                     	switch	.text
1460  0359               _sheller_wrap:
1462  0359 89            	pushw	x
1463  035a 5203          	subw	sp,#3
1464       00000003      OFST:	set	3
1467                     ; 194     uint8_t result = SHELLER_ERROR;
1469  035c 0f03          	clr	(OFST+0,sp)
1471                     ; 195     if ((desc != NULL) && (dest != NULL) && (data != NULL)) {
1473  035e a30000        	cpw	x,#0
1474  0361 277a          	jreq	L575
1476  0363 1e0b          	ldw	x,(OFST+8,sp)
1477  0365 2776          	jreq	L575
1479  0367 1e08          	ldw	x,(OFST+5,sp)
1480  0369 2772          	jreq	L575
1481                     ; 196         if ((data_length <= desc->usefull_data_length) && (data_length > 0)) {
1483  036b 1e04          	ldw	x,(OFST+1,sp)
1484  036d e601          	ld	a,(1,x)
1485  036f 110a          	cp	a,(OFST+7,sp)
1486  0371 256a          	jrult	L575
1488  0373 0d0a          	tnz	(OFST+7,sp)
1489  0375 2766          	jreq	L575
1490                     ; 197             memset(dest, 0, sheller_get_package_length(desc));
1492  0377 1e0b          	ldw	x,(OFST+8,sp)
1493  0379 bf00          	ldw	c_x,x
1494  037b 1e04          	ldw	x,(OFST+1,sp)
1495  037d ad63          	call	_sheller_get_package_length
1497  037f 5f            	clrw	x
1498  0380 97            	ld	xl,a
1499  0381 5d            	tnzw	x
1500  0382 2707          	jreq	L23
1501  0384               L43:
1502  0384 5a            	decw	x
1503  0385 926f00        	clr	([c_x.w],x)
1504  0388 5d            	tnzw	x
1505  0389 26f9          	jrne	L43
1506  038b               L23:
1507                     ; 198             dest[0] = desc->start_byte;
1509  038b 1e04          	ldw	x,(OFST+1,sp)
1510  038d f6            	ld	a,(x)
1511  038e 1e0b          	ldw	x,(OFST+8,sp)
1512  0390 f7            	ld	(x),a
1513                     ; 199             memcpy((dest + 1), data, data_length);
1515  0391 1e0b          	ldw	x,(OFST+8,sp)
1516  0393 5c            	incw	x
1517  0394 bf00          	ldw	c_x,x
1518  0396 1608          	ldw	y,(OFST+5,sp)
1519  0398 90bf00        	ldw	c_y,y
1520  039b 7b0a          	ld	a,(OFST+7,sp)
1521  039d 5f            	clrw	x
1522  039e 97            	ld	xl,a
1523  039f 5d            	tnzw	x
1524  03a0 270a          	jreq	L63
1525  03a2               L04:
1526  03a2 5a            	decw	x
1527  03a3 92d600        	ld	a,([c_y.w],x)
1528  03a6 92d700        	ld	([c_x.w],x),a
1529  03a9 5d            	tnzw	x
1530  03aa 26f6          	jrne	L04
1531  03ac               L63:
1532                     ; 201             crc = get_crc((dest + 1), desc->usefull_data_length);
1534  03ac 1e04          	ldw	x,(OFST+1,sp)
1535  03ae e601          	ld	a,(1,x)
1536  03b0 5f            	clrw	x
1537  03b1 97            	ld	xl,a
1538  03b2 89            	pushw	x
1539  03b3 1e0d          	ldw	x,(OFST+10,sp)
1540  03b5 5c            	incw	x
1541  03b6 cd0000        	call	_get_crc
1543  03b9 5b02          	addw	sp,#2
1544  03bb 1f01          	ldw	(OFST-2,sp),x
1546                     ; 202             dest[desc->usefull_data_length + 1] = crc & 0xFF;
1548  03bd 1e04          	ldw	x,(OFST+1,sp)
1549  03bf e601          	ld	a,(1,x)
1550  03c1 5f            	clrw	x
1551  03c2 97            	ld	xl,a
1552  03c3 72fb0b        	addw	x,(OFST+8,sp)
1553  03c6 7b02          	ld	a,(OFST-1,sp)
1554  03c8 a4ff          	and	a,#255
1555  03ca e701          	ld	(1,x),a
1556                     ; 203             dest[desc->usefull_data_length + 2] = (crc >> 8) & 0xFF;
1558  03cc 1e04          	ldw	x,(OFST+1,sp)
1559  03ce e601          	ld	a,(1,x)
1560  03d0 5f            	clrw	x
1561  03d1 97            	ld	xl,a
1562  03d2 72fb0b        	addw	x,(OFST+8,sp)
1563  03d5 7b01          	ld	a,(OFST-2,sp)
1564  03d7 e702          	ld	(2,x),a
1565                     ; 205             result = SHELLER_OK;
1567  03d9 a601          	ld	a,#1
1568  03db 6b03          	ld	(OFST+0,sp),a
1570  03dd               L575:
1571                     ; 209     return result;
1573  03dd 7b03          	ld	a,(OFST+0,sp)
1576  03df 5b05          	addw	sp,#5
1577  03e1 81            	ret
1615                     ; 212 uint8_t sheller_get_package_length(sheller_t *desc)
1615                     ; 213 {
1616                     	switch	.text
1617  03e2               _sheller_get_package_length:
1621                     ; 214     return (desc->usefull_data_length + SHELLER_SERVICE_BYTES_COUNT);
1623  03e2 e601          	ld	a,(1,x)
1624  03e4 ab03          	add	a,#3
1627  03e6 81            	ret
1640                     	xdef	_sheller_get_package_length
1641                     	xdef	_sheller_wrap
1642                     	xdef	_sheller_read
1643                     	xdef	_sheller_push
1644                     	xdef	_sheller_init
1645                     	xref	_malloc
1646                     	xref	_get_crc_by_byte
1647                     	xref	_get_crc
1648                     	xref.b	c_x
1649                     	xref.b	c_y
1668                     	end
