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
 272                     ; 11 static uint8_t sheller_found_start_byte(sheller_t *desc)
 272                     ; 12 {
 273                     	switch	.text
 274  0023               L55_sheller_found_start_byte:
 276  0023 89            	pushw	x
 277  0024 89            	pushw	x
 278       00000002      OFST:	set	2
 281                     ; 13     if ((desc->rx_buff_begin == desc->rx_buff_end) && desc->rx_buff_empty_flag == 0) {
 283  0025 9093          	ldw	y,x
 284  0027 ee08          	ldw	x,(8,x)
 285  0029 90e30a        	cpw	x,(10,y)
 286  002c 2666          	jrne	L361
 288  002e 1e03          	ldw	x,(OFST+1,sp)
 289  0030 6d05          	tnz	(5,x)
 290  0032 2660          	jrne	L361
 291                     ; 14         uint16_t i = 0;
 293                     ; 15         for (i = 0; i < desc->rx_buff_length; ++i) {
 295  0034 5f            	clrw	x
 296  0035 1f01          	ldw	(OFST-1,sp),x
 299  0037 203a          	jra	L151
 300  0039               L541:
 301                     ; 16             if(desc->rx_buff[desc->rx_buff_begin] == desc->start_byte) {
 303  0039 1e03          	ldw	x,(OFST+1,sp)
 304  003b ee08          	ldw	x,(8,x)
 305  003d 1603          	ldw	y,(OFST+1,sp)
 306  003f 90ee06        	ldw	y,(6,y)
 307  0042 90bf00        	ldw	c_x,y
 308  0045 92d600        	ld	a,([c_x.w],x)
 309  0048 1e03          	ldw	x,(OFST+1,sp)
 310  004a f1            	cp	a,(x)
 311  004b 260d          	jrne	L551
 312                     ; 17                 desc->start_byte_pos = desc->rx_buff_begin;
 314  004d 1e03          	ldw	x,(OFST+1,sp)
 315  004f 9093          	ldw	y,x
 316  0051 90ee08        	ldw	y,(8,y)
 317  0054 ef0c          	ldw	(12,x),y
 318                     ; 18                 return 1;
 320  0056 a601          	ld	a,#1
 322  0058 2078          	jra	L01
 323  005a               L551:
 324                     ; 20             increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
 326  005a 1e03          	ldw	x,(OFST+1,sp)
 327  005c ee02          	ldw	x,(2,x)
 328  005e 89            	pushw	x
 329  005f ae0001        	ldw	x,#1
 330  0062 89            	pushw	x
 331  0063 1e07          	ldw	x,(OFST+5,sp)
 332  0065 1c0008        	addw	x,#8
 333  0068 ad96          	call	L3_increase_circular_value
 335  006a 5b04          	addw	sp,#4
 336                     ; 15         for (i = 0; i < desc->rx_buff_length; ++i) {
 338  006c 1e01          	ldw	x,(OFST-1,sp)
 339  006e 1c0001        	addw	x,#1
 340  0071 1f01          	ldw	(OFST-1,sp),x
 342  0073               L151:
 345  0073 1e03          	ldw	x,(OFST+1,sp)
 346  0075 9093          	ldw	y,x
 347  0077 51            	exgw	x,y
 348  0078 ee02          	ldw	x,(2,x)
 349  007a 1301          	cpw	x,(OFST-1,sp)
 350  007c 51            	exgw	x,y
 351  007d 22ba          	jrugt	L541
 353  007f 2054          	jra	L751
 354  0081               L161:
 355                     ; 24             increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
 357  0081 1e03          	ldw	x,(OFST+1,sp)
 358  0083 ee02          	ldw	x,(2,x)
 359  0085 89            	pushw	x
 360  0086 ae0001        	ldw	x,#1
 361  0089 89            	pushw	x
 362  008a 1e07          	ldw	x,(OFST+5,sp)
 363  008c 1c0008        	addw	x,#8
 364  008f cd0000        	call	L3_increase_circular_value
 366  0092 5b04          	addw	sp,#4
 367  0094               L361:
 368                     ; 23         while((desc->rx_buff[desc->rx_buff_begin] != desc->start_byte) && (desc->rx_buff_begin != desc->rx_buff_end)) {
 370  0094 1e03          	ldw	x,(OFST+1,sp)
 371  0096 ee08          	ldw	x,(8,x)
 372  0098 1603          	ldw	y,(OFST+1,sp)
 373  009a 90ee06        	ldw	y,(6,y)
 374  009d 90bf00        	ldw	c_x,y
 375  00a0 92d600        	ld	a,([c_x.w],x)
 376  00a3 1e03          	ldw	x,(OFST+1,sp)
 377  00a5 f1            	cp	a,(x)
 378  00a6 270b          	jreq	L761
 380  00a8 1e03          	ldw	x,(OFST+1,sp)
 381  00aa 1603          	ldw	y,(OFST+1,sp)
 382  00ac ee08          	ldw	x,(8,x)
 383  00ae 90e30a        	cpw	x,(10,y)
 384  00b1 26ce          	jrne	L161
 385  00b3               L761:
 386                     ; 27         if (desc->rx_buff[desc->rx_buff_begin] == desc->start_byte) {
 388  00b3 1e03          	ldw	x,(OFST+1,sp)
 389  00b5 ee08          	ldw	x,(8,x)
 390  00b7 1603          	ldw	y,(OFST+1,sp)
 391  00b9 90ee06        	ldw	y,(6,y)
 392  00bc 90bf00        	ldw	c_x,y
 393  00bf 92d600        	ld	a,([c_x.w],x)
 394  00c2 1e03          	ldw	x,(OFST+1,sp)
 395  00c4 f1            	cp	a,(x)
 396  00c5 260e          	jrne	L751
 397                     ; 28             desc->start_byte_pos = desc->rx_buff_begin;
 399  00c7 1e03          	ldw	x,(OFST+1,sp)
 400  00c9 9093          	ldw	y,x
 401  00cb 90ee08        	ldw	y,(8,y)
 402  00ce ef0c          	ldw	(12,x),y
 403                     ; 29             return 1;
 405  00d0 a601          	ld	a,#1
 407  00d2               L01:
 409  00d2 5b04          	addw	sp,#4
 410  00d4 81            	ret
 411  00d5               L751:
 412                     ; 33     return 0;
 414  00d5 4f            	clr	a
 416  00d6 20fa          	jra	L01
 520                     ; 36 static uint8_t sheller_try_read_data(sheller_t *desc)
 520                     ; 37 {
 521                     	switch	.text
 522  00d8               L371_sheller_try_read_data:
 524  00d8 89            	pushw	x
 525  00d9 520a          	subw	sp,#10
 526       0000000a      OFST:	set	10
 529                     ; 38     uint8_t i = 0;
 531                     ; 46     received_crc_position = desc->rx_buff_begin;
 533  00db ee08          	ldw	x,(8,x)
 534  00dd 1f06          	ldw	(OFST-4,sp),x
 536                     ; 47     increase_circular_value(&received_crc_position, desc->usefull_data_length + 1, desc->rx_buff_length);
 538  00df 1e0b          	ldw	x,(OFST+1,sp)
 539  00e1 ee02          	ldw	x,(2,x)
 540  00e3 89            	pushw	x
 541  00e4 1e0d          	ldw	x,(OFST+3,sp)
 542  00e6 e601          	ld	a,(1,x)
 543  00e8 5f            	clrw	x
 544  00e9 97            	ld	xl,a
 545  00ea 5c            	incw	x
 546  00eb 89            	pushw	x
 547  00ec 96            	ldw	x,sp
 548  00ed 1c000a        	addw	x,#OFST+0
 549  00f0 cd0000        	call	L3_increase_circular_value
 551  00f3 5b04          	addw	sp,#4
 552                     ; 48     received_crc_l = desc->rx_buff[received_crc_position];
 554  00f5 1e0b          	ldw	x,(OFST+1,sp)
 555  00f7 ee06          	ldw	x,(6,x)
 556  00f9 72fb06        	addw	x,(OFST-4,sp)
 557  00fc f6            	ld	a,(x)
 558  00fd 6b03          	ld	(OFST-7,sp),a
 560                     ; 49     increase_circular_value(&received_crc_position, 1, desc->rx_buff_length);
 562  00ff 1e0b          	ldw	x,(OFST+1,sp)
 563  0101 ee02          	ldw	x,(2,x)
 564  0103 89            	pushw	x
 565  0104 ae0001        	ldw	x,#1
 566  0107 89            	pushw	x
 567  0108 96            	ldw	x,sp
 568  0109 1c000a        	addw	x,#OFST+0
 569  010c cd0000        	call	L3_increase_circular_value
 571  010f 5b04          	addw	sp,#4
 572                     ; 50     received_crc_h = desc->rx_buff[received_crc_position];
 574  0111 1e0b          	ldw	x,(OFST+1,sp)
 575  0113 ee06          	ldw	x,(6,x)
 576  0115 72fb06        	addw	x,(OFST-4,sp)
 577  0118 f6            	ld	a,(x)
 578  0119 6b0a          	ld	(OFST+0,sp),a
 580                     ; 51     received_crc = received_crc_l | ((uint16_t)received_crc_h << 8);
 582  011b 7b0a          	ld	a,(OFST+0,sp)
 583  011d 5f            	clrw	x
 584  011e 97            	ld	xl,a
 585  011f 7b03          	ld	a,(OFST-7,sp)
 586  0121 02            	rlwa	x,a
 587  0122 1f01          	ldw	(OFST-9,sp),x
 589                     ; 53     calculate_crc = 0xFFFF;
 591  0124 aeffff        	ldw	x,#65535
 592  0127 1f04          	ldw	(OFST-6,sp),x
 594                     ; 54     begin = desc->rx_buff_begin;
 596  0129 1e0b          	ldw	x,(OFST+1,sp)
 597  012b ee08          	ldw	x,(8,x)
 598  012d 1f08          	ldw	(OFST-2,sp),x
 600                     ; 55     increase_circular_value(&begin, 1, desc->rx_buff_length);
 602  012f 1e0b          	ldw	x,(OFST+1,sp)
 603  0131 ee02          	ldw	x,(2,x)
 604  0133 89            	pushw	x
 605  0134 ae0001        	ldw	x,#1
 606  0137 89            	pushw	x
 607  0138 96            	ldw	x,sp
 608  0139 1c000c        	addw	x,#OFST+2
 609  013c cd0000        	call	L3_increase_circular_value
 611  013f 5b04          	addw	sp,#4
 612                     ; 56     for (i = 0; i < desc->usefull_data_length; ++i) {
 614  0141 0f0a          	clr	(OFST+0,sp)
 617  0143 2025          	jra	L552
 618  0145               L152:
 619                     ; 57         get_crc_by_byte(&calculate_crc, desc->rx_buff[begin]);
 621  0145 1e0b          	ldw	x,(OFST+1,sp)
 622  0147 ee06          	ldw	x,(6,x)
 623  0149 72fb08        	addw	x,(OFST-2,sp)
 624  014c f6            	ld	a,(x)
 625  014d 88            	push	a
 626  014e 96            	ldw	x,sp
 627  014f 1c0005        	addw	x,#OFST-5
 628  0152 cd0000        	call	_get_crc_by_byte
 630  0155 84            	pop	a
 631                     ; 58         increase_circular_value(&begin, 1, desc->rx_buff_length);
 633  0156 1e0b          	ldw	x,(OFST+1,sp)
 634  0158 ee02          	ldw	x,(2,x)
 635  015a 89            	pushw	x
 636  015b ae0001        	ldw	x,#1
 637  015e 89            	pushw	x
 638  015f 96            	ldw	x,sp
 639  0160 1c000c        	addw	x,#OFST+2
 640  0163 cd0000        	call	L3_increase_circular_value
 642  0166 5b04          	addw	sp,#4
 643                     ; 56     for (i = 0; i < desc->usefull_data_length; ++i) {
 645  0168 0c0a          	inc	(OFST+0,sp)
 647  016a               L552:
 650  016a 1e0b          	ldw	x,(OFST+1,sp)
 651  016c e601          	ld	a,(1,x)
 652  016e 110a          	cp	a,(OFST+0,sp)
 653  0170 22d3          	jrugt	L152
 654                     ; 61     if (calculate_crc == received_crc) {
 656  0172 1e04          	ldw	x,(OFST-6,sp)
 657  0174 1301          	cpw	x,(OFST-9,sp)
 658  0176 2604          	jrne	L162
 659                     ; 62         return 1;
 661  0178 a601          	ld	a,#1
 663  017a 200e          	jra	L41
 664  017c               L162:
 665                     ; 64         if (desc->crcErrorCallback != NULL) {
 667  017c 1e0b          	ldw	x,(OFST+1,sp)
 668  017e e611          	ld	a,(17,x)
 669  0180 ea10          	or	a,(16,x)
 670  0182 2705          	jreq	L362
 671                     ; 65             desc->crcErrorCallback();
 673  0184 1e0b          	ldw	x,(OFST+1,sp)
 674  0186 ee10          	ldw	x,(16,x)
 675  0188 fd            	call	(x)
 677  0189               L362:
 678                     ; 69     return 0;
 680  0189 4f            	clr	a
 682  018a               L41:
 684  018a 5b0c          	addw	sp,#12
 685  018c 81            	ret
 743                     ; 72 static void sheller_write_received_package(sheller_t *desc, uint8_t *dest)
 743                     ; 73 {
 744                     	switch	.text
 745  018d               L762_sheller_write_received_package:
 747  018d 89            	pushw	x
 748  018e 88            	push	a
 749       00000001      OFST:	set	1
 752                     ; 74     uint8_t i = 0;
 754                     ; 75     for (i = 0; i < desc->usefull_data_length; ++i) {
 756  018f 0f01          	clr	(OFST+0,sp)
 759  0191 202e          	jra	L523
 760  0193               L123:
 761                     ; 76         increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
 763  0193 1e02          	ldw	x,(OFST+1,sp)
 764  0195 ee02          	ldw	x,(2,x)
 765  0197 89            	pushw	x
 766  0198 ae0001        	ldw	x,#1
 767  019b 89            	pushw	x
 768  019c 1e06          	ldw	x,(OFST+5,sp)
 769  019e 1c0008        	addw	x,#8
 770  01a1 cd0000        	call	L3_increase_circular_value
 772  01a4 5b04          	addw	sp,#4
 773                     ; 77         dest[i] = desc->rx_buff[desc->rx_buff_begin];
 775  01a6 7b01          	ld	a,(OFST+0,sp)
 776  01a8 5f            	clrw	x
 777  01a9 97            	ld	xl,a
 778  01aa 72fb06        	addw	x,(OFST+5,sp)
 779  01ad 89            	pushw	x
 780  01ae 1e04          	ldw	x,(OFST+3,sp)
 781  01b0 ee08          	ldw	x,(8,x)
 782  01b2 1604          	ldw	y,(OFST+3,sp)
 783  01b4 90ee06        	ldw	y,(6,y)
 784  01b7 90bf00        	ldw	c_x,y
 785  01ba 92d600        	ld	a,([c_x.w],x)
 786  01bd 85            	popw	x
 787  01be f7            	ld	(x),a
 788                     ; 75     for (i = 0; i < desc->usefull_data_length; ++i) {
 790  01bf 0c01          	inc	(OFST+0,sp)
 792  01c1               L523:
 795  01c1 1e02          	ldw	x,(OFST+1,sp)
 796  01c3 e601          	ld	a,(1,x)
 797  01c5 1101          	cp	a,(OFST+0,sp)
 798  01c7 22ca          	jrugt	L123
 799                     ; 80     if (desc->rx_buff_begin == desc->rx_buff_end) {
 801  01c9 1e02          	ldw	x,(OFST+1,sp)
 802  01cb 1602          	ldw	y,(OFST+1,sp)
 803  01cd ee08          	ldw	x,(8,x)
 804  01cf 90e30a        	cpw	x,(10,y)
 805  01d2 2606          	jrne	L133
 806                     ; 81         desc->rx_buff_empty_flag = 1;
 808  01d4 1e02          	ldw	x,(OFST+1,sp)
 809  01d6 a601          	ld	a,#1
 810  01d8 e705          	ld	(5,x),a
 811  01da               L133:
 812                     ; 83 }
 815  01da 5b03          	addw	sp,#3
 816  01dc 81            	ret
 863                     ; 85 static uint16_t sheller_get_circular_buff_length(sheller_t *desc)
 863                     ; 86 {
 864                     	switch	.text
 865  01dd               L333_sheller_get_circular_buff_length:
 867  01dd 89            	pushw	x
 868  01de 89            	pushw	x
 869       00000002      OFST:	set	2
 872                     ; 87     uint16_t value = 0;
 874  01df 5f            	clrw	x
 875  01e0 1f01          	ldw	(OFST-1,sp),x
 877                     ; 88     if (desc != NULL) {
 879  01e2 1e03          	ldw	x,(OFST+1,sp)
 880  01e4 2753          	jreq	L163
 881                     ; 89         if (desc->rx_buff_end > desc->rx_buff_begin) {
 883  01e6 1e03          	ldw	x,(OFST+1,sp)
 884  01e8 1603          	ldw	y,(OFST+1,sp)
 885  01ea ee0a          	ldw	x,(10,x)
 886  01ec 90e308        	cpw	x,(8,y)
 887  01ef 2313          	jrule	L363
 888                     ; 90             value = desc->rx_buff_end - desc->rx_buff_begin;
 890  01f1 1e03          	ldw	x,(OFST+1,sp)
 891  01f3 ee0a          	ldw	x,(10,x)
 892  01f5 1603          	ldw	y,(OFST+1,sp)
 893  01f7 01            	rrwa	x,a
 894  01f8 90e009        	sub	a,(9,y)
 895  01fb 01            	rrwa	x,a
 896  01fc 90e208        	sbc	a,(8,y)
 897  01ff 01            	rrwa	x,a
 898  0200 1f01          	ldw	(OFST-1,sp),x
 901  0202 2035          	jra	L163
 902  0204               L363:
 903                     ; 91         } else if (desc->rx_buff_end < desc->rx_buff_begin) {
 905  0204 1e03          	ldw	x,(OFST+1,sp)
 906  0206 1603          	ldw	y,(OFST+1,sp)
 907  0208 ee0a          	ldw	x,(10,x)
 908  020a 90e308        	cpw	x,(8,y)
 909  020d 241e          	jruge	L763
 910                     ; 92             value = (desc->rx_buff_length - desc->rx_buff_begin) + desc->rx_buff_end;
 912  020f 1e03          	ldw	x,(OFST+1,sp)
 913  0211 ee02          	ldw	x,(2,x)
 914  0213 1603          	ldw	y,(OFST+1,sp)
 915  0215 01            	rrwa	x,a
 916  0216 90e009        	sub	a,(9,y)
 917  0219 01            	rrwa	x,a
 918  021a 90e208        	sbc	a,(8,y)
 919  021d 01            	rrwa	x,a
 920  021e 1603          	ldw	y,(OFST+1,sp)
 921  0220 01            	rrwa	x,a
 922  0221 90eb0b        	add	a,(11,y)
 923  0224 01            	rrwa	x,a
 924  0225 90e90a        	adc	a,(10,y)
 925  0228 01            	rrwa	x,a
 926  0229 1f01          	ldw	(OFST-1,sp),x
 929  022b 200c          	jra	L163
 930  022d               L763:
 931                     ; 93         } else if (desc->rx_buff_empty_flag == 0) {
 933  022d 1e03          	ldw	x,(OFST+1,sp)
 934  022f 6d05          	tnz	(5,x)
 935  0231 2606          	jrne	L163
 936                     ; 94             value = desc->rx_buff_length;
 938  0233 1e03          	ldw	x,(OFST+1,sp)
 939  0235 ee02          	ldw	x,(2,x)
 940  0237 1f01          	ldw	(OFST-1,sp),x
 942  0239               L163:
 943                     ; 98     return value;
 945  0239 1e01          	ldw	x,(OFST-1,sp)
 948  023b 5b04          	addw	sp,#4
 949  023d 81            	ret
1024                     ; 108 uint8_t sheller_init(sheller_t *desc, uint8_t start_byte, uint8_t usefull_data_length, uint16_t rx_buff_length)
1024                     ; 109 {
1025                     	switch	.text
1026  023e               _sheller_init:
1028  023e 89            	pushw	x
1029  023f 88            	push	a
1030       00000001      OFST:	set	1
1033                     ; 110     uint8_t init_result = SHELLER_OK;
1035  0240 a601          	ld	a,#1
1036  0242 6b01          	ld	(OFST+0,sp),a
1038                     ; 111     if (desc != NULL) {
1040  0244 a30000        	cpw	x,#0
1041  0247 274b          	jreq	L534
1042                     ; 112         desc->start_byte = start_byte;
1044  0249 7b06          	ld	a,(OFST+5,sp)
1045  024b 1e02          	ldw	x,(OFST+1,sp)
1046  024d f7            	ld	(x),a
1047                     ; 113         desc->usefull_data_length = usefull_data_length;
1049  024e 7b07          	ld	a,(OFST+6,sp)
1050  0250 1e02          	ldw	x,(OFST+1,sp)
1051  0252 e701          	ld	(1,x),a
1052                     ; 114         desc->rx_buff_length = rx_buff_length;
1054  0254 1e02          	ldw	x,(OFST+1,sp)
1055  0256 1608          	ldw	y,(OFST+7,sp)
1056  0258 ef02          	ldw	(2,x),y
1057                     ; 115         desc->rx_buff_begin = 0;
1059  025a 1e02          	ldw	x,(OFST+1,sp)
1060  025c 905f          	clrw	y
1061  025e ef08          	ldw	(8,x),y
1062                     ; 116         desc->rx_buff_end   = 0;
1064  0260 1e02          	ldw	x,(OFST+1,sp)
1065  0262 905f          	clrw	y
1066  0264 ef0a          	ldw	(10,x),y
1067                     ; 117         desc->rx_buff_empty_flag = 1;
1069  0266 1e02          	ldw	x,(OFST+1,sp)
1070  0268 a601          	ld	a,#1
1071  026a e705          	ld	(5,x),a
1072                     ; 118         desc->start_byte_pos = 0;
1074  026c 1e02          	ldw	x,(OFST+1,sp)
1075  026e 905f          	clrw	y
1076  0270 ef0c          	ldw	(12,x),y
1077                     ; 119         desc->bufferOverflowCallback = NULL;
1079  0272 1e02          	ldw	x,(OFST+1,sp)
1080  0274 905f          	clrw	y
1081  0276 ef0e          	ldw	(14,x),y
1082                     ; 120         desc->crcErrorCallback = NULL;
1084  0278 1e02          	ldw	x,(OFST+1,sp)
1085  027a 905f          	clrw	y
1086  027c ef10          	ldw	(16,x),y
1087                     ; 122         desc->rx_buff = (uint8_t*)malloc(desc->rx_buff_length);
1089  027e 1e02          	ldw	x,(OFST+1,sp)
1090  0280 ee02          	ldw	x,(2,x)
1091  0282 cd0000        	call	_malloc
1093  0285 1602          	ldw	y,(OFST+1,sp)
1094  0287 90ef06        	ldw	(6,y),x
1095                     ; 123         if (desc->rx_buff == NULL) {
1097  028a 1e02          	ldw	x,(OFST+1,sp)
1098  028c e607          	ld	a,(7,x)
1099  028e ea06          	or	a,(6,x)
1100  0290 2602          	jrne	L534
1101                     ; 124             init_result = SHELLER_ERROR;
1103  0292 0f01          	clr	(OFST+0,sp)
1105  0294               L534:
1106                     ; 129     return init_result;
1108  0294 7b01          	ld	a,(OFST+0,sp)
1111  0296 5b03          	addw	sp,#3
1112  0298 81            	ret
1159                     ; 137 uint8_t sheller_deinit(sheller_t *desc)
1159                     ; 138 {
1160                     	switch	.text
1161  0299               _sheller_deinit:
1163  0299 89            	pushw	x
1164  029a 88            	push	a
1165       00000001      OFST:	set	1
1168                     ; 139     uint8_t deinit_result = SHELLER_ERROR;
1170  029b 0f01          	clr	(OFST+0,sp)
1172                     ; 140     if (desc != NULL) {
1174  029d a30000        	cpw	x,#0
1175  02a0 270f          	jreq	L564
1176                     ; 141         free(desc->rx_buff);
1178  02a2 ee06          	ldw	x,(6,x)
1179  02a4 cd0000        	call	_free
1181                     ; 142         desc->rx_buff = NULL;
1183  02a7 1e02          	ldw	x,(OFST+1,sp)
1184  02a9 905f          	clrw	y
1185  02ab ef06          	ldw	(6,x),y
1186                     ; 143         deinit_result = SHELLER_OK;
1188  02ad a601          	ld	a,#1
1189  02af 6b01          	ld	(OFST+0,sp),a
1191  02b1               L564:
1192                     ; 145     return deinit_result;
1194  02b1 7b01          	ld	a,(OFST+0,sp)
1197  02b3 5b03          	addw	sp,#3
1198  02b5 81            	ret
1253                     ; 155 uint8_t sheller_push(sheller_t *desc, const uint8_t byte)
1253                     ; 156 {
1254                     	switch	.text
1255  02b6               _sheller_push:
1257  02b6 89            	pushw	x
1258  02b7 88            	push	a
1259       00000001      OFST:	set	1
1262                     ; 157     uint8_t work_result = SHELLER_ERROR;
1264  02b8 0f01          	clr	(OFST+0,sp)
1266                     ; 158     if (desc != NULL) {
1268  02ba a30000        	cpw	x,#0
1269  02bd 274a          	jreq	L715
1270                     ; 159         if (desc->rx_buff_end != desc->rx_buff_begin || desc->rx_buff_empty_flag == 1) {
1272  02bf 9093          	ldw	y,x
1273  02c1 ee0a          	ldw	x,(10,x)
1274  02c3 90e308        	cpw	x,(8,y)
1275  02c6 2608          	jrne	L325
1277  02c8 1e02          	ldw	x,(OFST+1,sp)
1278  02ca e605          	ld	a,(5,x)
1279  02cc a101          	cp	a,#1
1280  02ce 262c          	jrne	L125
1281  02d0               L325:
1282                     ; 160             desc->rx_buff_empty_flag = 0;
1284  02d0 1e02          	ldw	x,(OFST+1,sp)
1285  02d2 6f05          	clr	(5,x)
1286                     ; 161             desc->rx_buff[desc->rx_buff_end] = byte;
1288  02d4 7b06          	ld	a,(OFST+5,sp)
1289  02d6 1e02          	ldw	x,(OFST+1,sp)
1290  02d8 ee0a          	ldw	x,(10,x)
1291  02da 1602          	ldw	y,(OFST+1,sp)
1292  02dc 90ee06        	ldw	y,(6,y)
1293  02df 90bf00        	ldw	c_x,y
1294  02e2 92d700        	ld	([c_x.w],x),a
1295                     ; 162             desc->rx_buff_end = (desc->rx_buff_end + 1) % desc->rx_buff_length;
1297  02e5 1e02          	ldw	x,(OFST+1,sp)
1298  02e7 ee0a          	ldw	x,(10,x)
1299  02e9 5c            	incw	x
1300  02ea 1602          	ldw	y,(OFST+1,sp)
1301  02ec 90ee02        	ldw	y,(2,y)
1302  02ef 65            	divw	x,y
1303  02f0 51            	exgw	x,y
1304  02f1 1602          	ldw	y,(OFST+1,sp)
1305  02f3 90ef0a        	ldw	(10,y),x
1306                     ; 163             work_result = SHELLER_OK;
1308  02f6 a601          	ld	a,#1
1309  02f8 6b01          	ld	(OFST+0,sp),a
1312  02fa 200d          	jra	L715
1313  02fc               L125:
1314                     ; 165             if (desc->bufferOverflowCallback != NULL) {
1316  02fc 1e02          	ldw	x,(OFST+1,sp)
1317  02fe e60f          	ld	a,(15,x)
1318  0300 ea0e          	or	a,(14,x)
1319  0302 2705          	jreq	L715
1320                     ; 166                 desc->bufferOverflowCallback();
1322  0304 1e02          	ldw	x,(OFST+1,sp)
1323  0306 ee0e          	ldw	x,(14,x)
1324  0308 fd            	call	(x)
1326  0309               L715:
1327                     ; 171     return work_result;
1329  0309 7b01          	ld	a,(OFST+0,sp)
1332  030b 5b03          	addw	sp,#3
1333  030d 81            	ret
1395                     ; 183 uint8_t sheller_read(sheller_t *desc, uint8_t *dest)
1395                     ; 184 {
1396                     	switch	.text
1397  030e               _sheller_read:
1399  030e 89            	pushw	x
1400  030f 5203          	subw	sp,#3
1401       00000003      OFST:	set	3
1404                     ; 185     uint8_t result = SHELLER_ERROR;
1406  0311 0f03          	clr	(OFST+0,sp)
1408                     ; 186     if (desc != NULL && dest != NULL) {
1410  0313 a30000        	cpw	x,#0
1411  0316 2603cc0399    	jreq	L165
1413  031b 1e08          	ldw	x,(OFST+5,sp)
1414  031d 277a          	jreq	L165
1415                     ; 187         if (sheller_get_circular_buff_length(desc) >= sheller_get_package_length(desc)) {
1417  031f 1e04          	ldw	x,(OFST+1,sp)
1418  0321 cd0427        	call	_sheller_get_package_length
1420  0324 5f            	clrw	x
1421  0325 97            	ld	xl,a
1422  0326 1f01          	ldw	(OFST-2,sp),x
1424  0328 1e04          	ldw	x,(OFST+1,sp)
1425  032a cd01dd        	call	L333_sheller_get_circular_buff_length
1427  032d 1301          	cpw	x,(OFST-2,sp)
1428  032f 2568          	jrult	L165
1429                     ; 188             if (sheller_found_start_byte(desc)) {
1431  0331 1e04          	ldw	x,(OFST+1,sp)
1432  0333 cd0023        	call	L55_sheller_found_start_byte
1434  0336 4d            	tnz	a
1435  0337 2760          	jreq	L165
1436                     ; 189                 if (sheller_get_circular_buff_length(desc) >= sheller_get_package_length(desc)) {
1438  0339 1e04          	ldw	x,(OFST+1,sp)
1439  033b cd0427        	call	_sheller_get_package_length
1441  033e 5f            	clrw	x
1442  033f 97            	ld	xl,a
1443  0340 1f01          	ldw	(OFST-2,sp),x
1445  0342 1e04          	ldw	x,(OFST+1,sp)
1446  0344 cd01dd        	call	L333_sheller_get_circular_buff_length
1448  0347 1301          	cpw	x,(OFST-2,sp)
1449  0349 254e          	jrult	L165
1450                     ; 190                     if (sheller_try_read_data(desc)) {
1452  034b 1e04          	ldw	x,(OFST+1,sp)
1453  034d cd00d8        	call	L371_sheller_try_read_data
1455  0350 4d            	tnz	a
1456  0351 2722          	jreq	L175
1457                     ; 191                         sheller_write_received_package(desc, dest);
1459  0353 1e08          	ldw	x,(OFST+5,sp)
1460  0355 89            	pushw	x
1461  0356 1e06          	ldw	x,(OFST+3,sp)
1462  0358 cd018d        	call	L762_sheller_write_received_package
1464  035b 85            	popw	x
1465                     ; 192                         increase_circular_value(&desc->rx_buff_begin, 3, desc->rx_buff_length);
1467  035c 1e04          	ldw	x,(OFST+1,sp)
1468  035e ee02          	ldw	x,(2,x)
1469  0360 89            	pushw	x
1470  0361 ae0003        	ldw	x,#3
1471  0364 89            	pushw	x
1472  0365 1e08          	ldw	x,(OFST+5,sp)
1473  0367 1c0008        	addw	x,#8
1474  036a cd0000        	call	L3_increase_circular_value
1476  036d 5b04          	addw	sp,#4
1477                     ; 193                         result = SHELLER_OK;
1479  036f a601          	ld	a,#1
1480  0371 6b03          	ld	(OFST+0,sp),a
1483  0373 2013          	jra	L375
1484  0375               L175:
1485                     ; 195                         increase_circular_value(&desc->rx_buff_begin, 1, desc->rx_buff_length);
1487  0375 1e04          	ldw	x,(OFST+1,sp)
1488  0377 ee02          	ldw	x,(2,x)
1489  0379 89            	pushw	x
1490  037a ae0001        	ldw	x,#1
1491  037d 89            	pushw	x
1492  037e 1e08          	ldw	x,(OFST+5,sp)
1493  0380 1c0008        	addw	x,#8
1494  0383 cd0000        	call	L3_increase_circular_value
1496  0386 5b04          	addw	sp,#4
1497  0388               L375:
1498                     ; 198                     if (desc->rx_buff_begin == desc->rx_buff_end) {
1500  0388 1e04          	ldw	x,(OFST+1,sp)
1501  038a 1604          	ldw	y,(OFST+1,sp)
1502  038c ee08          	ldw	x,(8,x)
1503  038e 90e30a        	cpw	x,(10,y)
1504  0391 2606          	jrne	L165
1505                     ; 199                         desc->rx_buff_empty_flag = 1;
1507  0393 1e04          	ldw	x,(OFST+1,sp)
1508  0395 a601          	ld	a,#1
1509  0397 e705          	ld	(5,x),a
1510  0399               L165:
1511                     ; 206     return result;
1513  0399 7b03          	ld	a,(OFST+0,sp)
1516  039b 5b05          	addw	sp,#5
1517  039d 81            	ret
1605                     ; 218 uint8_t sheller_wrap(sheller_t *desc, uint8_t *data, const uint8_t data_length, uint8_t *dest)
1605                     ; 219 {
1606                     	switch	.text
1607  039e               _sheller_wrap:
1609  039e 89            	pushw	x
1610  039f 5203          	subw	sp,#3
1611       00000003      OFST:	set	3
1614                     ; 221     uint8_t result = SHELLER_ERROR;
1616  03a1 0f03          	clr	(OFST+0,sp)
1618                     ; 222     if ((desc != NULL) && (dest != NULL) && (data != NULL)) {
1620  03a3 a30000        	cpw	x,#0
1621  03a6 277a          	jreq	L346
1623  03a8 1e0b          	ldw	x,(OFST+8,sp)
1624  03aa 2776          	jreq	L346
1626  03ac 1e08          	ldw	x,(OFST+5,sp)
1627  03ae 2772          	jreq	L346
1628                     ; 223         if ((data_length <= desc->usefull_data_length) && (data_length > 0)) {
1630  03b0 1e04          	ldw	x,(OFST+1,sp)
1631  03b2 e601          	ld	a,(1,x)
1632  03b4 110a          	cp	a,(OFST+7,sp)
1633  03b6 256a          	jrult	L346
1635  03b8 0d0a          	tnz	(OFST+7,sp)
1636  03ba 2766          	jreq	L346
1637                     ; 224             memset(dest, 0, sheller_get_package_length(desc));
1639  03bc 1e0b          	ldw	x,(OFST+8,sp)
1640  03be bf00          	ldw	c_x,x
1641  03c0 1e04          	ldw	x,(OFST+1,sp)
1642  03c2 ad63          	call	_sheller_get_package_length
1644  03c4 5f            	clrw	x
1645  03c5 97            	ld	xl,a
1646  03c6 5d            	tnzw	x
1647  03c7 2707          	jreq	L43
1648  03c9               L63:
1649  03c9 5a            	decw	x
1650  03ca 926f00        	clr	([c_x.w],x)
1651  03cd 5d            	tnzw	x
1652  03ce 26f9          	jrne	L63
1653  03d0               L43:
1654                     ; 225             dest[0] = desc->start_byte;
1656  03d0 1e04          	ldw	x,(OFST+1,sp)
1657  03d2 f6            	ld	a,(x)
1658  03d3 1e0b          	ldw	x,(OFST+8,sp)
1659  03d5 f7            	ld	(x),a
1660                     ; 226             memcpy((dest + 1), data, data_length);
1662  03d6 1e0b          	ldw	x,(OFST+8,sp)
1663  03d8 5c            	incw	x
1664  03d9 bf00          	ldw	c_x,x
1665  03db 1608          	ldw	y,(OFST+5,sp)
1666  03dd 90bf00        	ldw	c_y,y
1667  03e0 7b0a          	ld	a,(OFST+7,sp)
1668  03e2 5f            	clrw	x
1669  03e3 97            	ld	xl,a
1670  03e4 5d            	tnzw	x
1671  03e5 270a          	jreq	L04
1672  03e7               L24:
1673  03e7 5a            	decw	x
1674  03e8 92d600        	ld	a,([c_y.w],x)
1675  03eb 92d700        	ld	([c_x.w],x),a
1676  03ee 5d            	tnzw	x
1677  03ef 26f6          	jrne	L24
1678  03f1               L04:
1679                     ; 228             crc = get_crc((dest + 1), desc->usefull_data_length);
1681  03f1 1e04          	ldw	x,(OFST+1,sp)
1682  03f3 e601          	ld	a,(1,x)
1683  03f5 5f            	clrw	x
1684  03f6 97            	ld	xl,a
1685  03f7 89            	pushw	x
1686  03f8 1e0d          	ldw	x,(OFST+10,sp)
1687  03fa 5c            	incw	x
1688  03fb cd0000        	call	_get_crc
1690  03fe 5b02          	addw	sp,#2
1691  0400 1f01          	ldw	(OFST-2,sp),x
1693                     ; 229             dest[desc->usefull_data_length + 1] = crc & 0xFF;
1695  0402 1e04          	ldw	x,(OFST+1,sp)
1696  0404 e601          	ld	a,(1,x)
1697  0406 5f            	clrw	x
1698  0407 97            	ld	xl,a
1699  0408 72fb0b        	addw	x,(OFST+8,sp)
1700  040b 7b02          	ld	a,(OFST-1,sp)
1701  040d a4ff          	and	a,#255
1702  040f e701          	ld	(1,x),a
1703                     ; 230             dest[desc->usefull_data_length + 2] = (crc >> 8) & 0xFF;
1705  0411 1e04          	ldw	x,(OFST+1,sp)
1706  0413 e601          	ld	a,(1,x)
1707  0415 5f            	clrw	x
1708  0416 97            	ld	xl,a
1709  0417 72fb0b        	addw	x,(OFST+8,sp)
1710  041a 7b01          	ld	a,(OFST-2,sp)
1711  041c e702          	ld	(2,x),a
1712                     ; 232             result = SHELLER_OK;
1714  041e a601          	ld	a,#1
1715  0420 6b03          	ld	(OFST+0,sp),a
1717  0422               L346:
1718                     ; 236     return result;
1720  0422 7b03          	ld	a,(OFST+0,sp)
1723  0424 5b05          	addw	sp,#5
1724  0426 81            	ret
1762                     ; 239 uint8_t sheller_get_package_length(sheller_t *desc)
1762                     ; 240 {
1763                     	switch	.text
1764  0427               _sheller_get_package_length:
1768                     ; 241     return (desc->usefull_data_length + SHELLER_SERVICE_BYTES_COUNT);
1770  0427 e601          	ld	a,(1,x)
1771  0429 ab03          	add	a,#3
1774  042b 81            	ret
1787                     	xdef	_sheller_get_package_length
1788                     	xdef	_sheller_wrap
1789                     	xdef	_sheller_read
1790                     	xdef	_sheller_push
1791                     	xdef	_sheller_deinit
1792                     	xdef	_sheller_init
1793                     	xref	_malloc
1794                     	xref	_free
1795                     	xref	_get_crc_by_byte
1796                     	xref	_get_crc
1797                     	xref.b	c_x
1798                     	xref.b	c_y
1817                     	end
