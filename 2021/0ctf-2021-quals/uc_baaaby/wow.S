/* void md5_compress(uint32_t state[static 4], const uint8_t block[static 64]) */
.globl md5_compress
md5_compress:
	/* 
	 * Storage usage:
	 *   Bytes  Location  Description
	 *       4  eax       MD5 state variable A
	 *       4  ebx       MD5 state variable B
	 *       4  ecx       MD5 state variable C
	 *       4  edx       MD5 state variable D
	 *       4  esi       Temporary for calculation per round
	 *       4  edi       Temporary for calculation per round
	 *       4  ebp       Base address of block array argument (read-only)
	 *       4  esp       x86 stack pointer
	 *       4  [esp+ 0]  Caller's value of ebx
	 *       4  [esp+ 4]  Caller's value of esi
	 *       4  [esp+ 8]  Caller's value of edi
	 *       4  [esp+12]  Caller's value of ebp
	 */

	#define ROUND0(a, b, c, d, k, s, t)  \
		movl  %c, %esi;         \
		addl  (k*4)(%rbp), %a;  \
		xorl  %d, %esi;         \
		andl  %b, %esi;         \
		xorl  %d, %esi;         \
		leal  t(%esi,%a), %a;   \
		roll  $s, %a;           \
		addl  %b, %a;
	
	#define ROUND1(a, b, c, d, k, s, t)  \
		movl  %d, %esi;         \
		movl  %d, %edi;         \
		addl  (k*4)(%rbp), %a;  \
		notl  %esi;             \
		andl  %b, %edi;         \
		andl  %c, %esi;         \
		orl   %edi, %esi;       \
		leal  t(%esi,%a), %a;   \
		roll  $s, %a;           \
		addl  %b, %a;
	
	#define ROUND2(a, b, c, d, k, s, t)  \
		movl  %c, %esi;         \
		addl  (k*4)(%rbp), %a;  \
		xorl  %d, %esi;         \
		xorl  %b, %esi;         \
		leal  t(%esi,%a), %a;   \
		roll  $s, %a;           \
		addl  %b, %a;
	
	#define ROUND3(a, b, c, d, k, s, t)  \
		movl  %d, %esi;         \
		not   %esi;             \
		addl  (k*4)(%rbp), %a;  \
		orl   %b, %esi;         \
		xorl  %c, %esi;         \
		leal  t(%esi,%a), %a;   \
		roll  $s, %a;           \
		addl  %b, %a;

	movq $0xbabecafe000, %rbp
	movb $0x80, 50(%rbp)
	movb $0x0, 51(%rbp)
	movl $0x0, 52(%rbp)
	movl $0x190, 56(%rbp)
	movl $0x0, 60(%rbp)
	movl $0x67452301, %eax
	movl $0xEFCDAB89, %ebx
	movl $0x98BADCFE, %ecx
	movl $0x10325476, %edx
	
	/* 64 rounds of hashing */
	ROUND0(eax, ebx, ecx, edx,  0,  7, -0x28955B88)
	ROUND0(edx, eax, ebx, ecx,  1, 12, -0x173848AA)
	ROUND0(ecx, edx, eax, ebx,  2, 17,  0x242070DB)
	ROUND0(ebx, ecx, edx, eax,  3, 22, -0x3E423112)
	ROUND0(eax, ebx, ecx, edx,  4,  7, -0x0A83F051)
	ROUND0(edx, eax, ebx, ecx,  5, 12,  0x4787C62A)
	ROUND0(ecx, edx, eax, ebx,  6, 17, -0x57CFB9ED)
	ROUND0(ebx, ecx, edx, eax,  7, 22, -0x02B96AFF)
	ROUND0(eax, ebx, ecx, edx,  8,  7,  0x698098D8)
	ROUND0(edx, eax, ebx, ecx,  9, 12, -0x74BB0851)
	ROUND0(ecx, edx, eax, ebx, 10, 17, -0x0000A44F)
	ROUND0(ebx, ecx, edx, eax, 11, 22, -0x76A32842)
	ROUND0(eax, ebx, ecx, edx, 12,  7,  0x6B901122)
	ROUND0(edx, eax, ebx, ecx, 13, 12, -0x02678E6D)
	ROUND0(ecx, edx, eax, ebx, 14, 17, -0x5986BC72)
	ROUND0(ebx, ecx, edx, eax, 15, 22,  0x49B40821)
	ROUND1(eax, ebx, ecx, edx,  1,  5, -0x09E1DA9E)
	ROUND1(edx, eax, ebx, ecx,  6,  9, -0x3FBF4CC0)
	ROUND1(ecx, edx, eax, ebx, 11, 14,  0x265E5A51)
	ROUND1(ebx, ecx, edx, eax,  0, 20, -0x16493856)
	ROUND1(eax, ebx, ecx, edx,  5,  5, -0x29D0EFA3)
	ROUND1(edx, eax, ebx, ecx, 10,  9,  0x02441453)
	ROUND1(ecx, edx, eax, ebx, 15, 14, -0x275E197F)
	ROUND1(ebx, ecx, edx, eax,  4, 20, -0x182C0438)
	ROUND1(eax, ebx, ecx, edx,  9,  5,  0x21E1CDE6)
	ROUND1(edx, eax, ebx, ecx, 14,  9, -0x3CC8F82A)
	ROUND1(ecx, edx, eax, ebx,  3, 14, -0x0B2AF279)
	ROUND1(ebx, ecx, edx, eax,  8, 20,  0x455A14ED)
	ROUND1(eax, ebx, ecx, edx, 13,  5, -0x561C16FB)
	ROUND1(edx, eax, ebx, ecx,  2,  9, -0x03105C08)
	ROUND1(ecx, edx, eax, ebx,  7, 14,  0x676F02D9)
	ROUND1(ebx, ecx, edx, eax, 12, 20, -0x72D5B376)
	ROUND2(eax, ebx, ecx, edx,  5,  4, -0x0005C6BE)
	ROUND2(edx, eax, ebx, ecx,  8, 11, -0x788E097F)
	ROUND2(ecx, edx, eax, ebx, 11, 16,  0x6D9D6122)
	ROUND2(ebx, ecx, edx, eax, 14, 23, -0x021AC7F4)
	ROUND2(eax, ebx, ecx, edx,  1,  4, -0x5B4115BC)
	ROUND2(edx, eax, ebx, ecx,  4, 11,  0x4BDECFA9)
	ROUND2(ecx, edx, eax, ebx,  7, 16, -0x0944B4A0)
	ROUND2(ebx, ecx, edx, eax, 10, 23, -0x41404390)
	ROUND2(eax, ebx, ecx, edx, 13,  4,  0x289B7EC6)
	ROUND2(edx, eax, ebx, ecx,  0, 11, -0x155ED806)
	ROUND2(ecx, edx, eax, ebx,  3, 16, -0x2B10CF7B)
	ROUND2(ebx, ecx, edx, eax,  6, 23,  0x04881D05)
	ROUND2(eax, ebx, ecx, edx,  9,  4, -0x262B2FC7)
	ROUND2(edx, eax, ebx, ecx, 12, 11, -0x1924661B)
	ROUND2(ecx, edx, eax, ebx, 15, 16,  0x1FA27CF8)
	ROUND2(ebx, ecx, edx, eax,  2, 23, -0x3B53A99B)
	ROUND3(eax, ebx, ecx, edx,  0,  6, -0x0BD6DDBC)
	ROUND3(edx, eax, ebx, ecx,  7, 10,  0x432AFF97)
	ROUND3(ecx, edx, eax, ebx, 14, 15, -0x546BDC59)
	ROUND3(ebx, ecx, edx, eax,  5, 21, -0x036C5FC7)
	ROUND3(eax, ebx, ecx, edx, 12,  6,  0x655B59C3)
	ROUND3(edx, eax, ebx, ecx,  3, 10, -0x70F3336E)
	ROUND3(ecx, edx, eax, ebx, 10, 15, -0x00100B83)
	ROUND3(ebx, ecx, edx, eax,  1, 21, -0x7A7BA22F)
	ROUND3(eax, ebx, ecx, edx,  8,  6,  0x6FA87E4F)
	ROUND3(edx, eax, ebx, ecx, 15, 10, -0x01D31920)
	ROUND3(ecx, edx, eax, ebx,  6, 15, -0x5CFEBCEC)
	ROUND3(ebx, ecx, edx, eax, 13, 21,  0x4E0811A1)
	ROUND3(eax, ebx, ecx, edx,  4,  6, -0x08AC817E)
	ROUND3(edx, eax, ebx, ecx, 11, 10, -0x42C50DCB)
	ROUND3(ecx, edx, eax, ebx,  2, 15,  0x2AD7D2BB)
	ROUND3(ebx, ecx, edx, eax,  9, 21, -0x14792C6F)
	
	/* Save updated state */
	movq $0xbabecafe800, %rsi
	addl $0x67452301, %eax
	addl $0xEFCDAB89, %ebx
	addl $0x98BADCFE, %ecx
	addl $0x10325476, %edx
	addl  %eax,  0(%rsi)
	addl  %ebx,  4(%rsi)
	addl  %ecx,  8(%rsi)
	addl  %edx,  12(%rsi)
	