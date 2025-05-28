from pwn import remote
import subprocess
from sympy.ntheory.generate import randprime
from tqdm import tqdm

def random_3byte_prime():
	return int(randprime(2**16 + 1, 2**24))

for j in range(1000):
	r = remote("leet-prime.atreides.b01lersc.tf", 8443, ssl=True)
	r.recvuntil(b'prefix (hex): ')
	prefix = r.recvline().strip().decode()
	print(prefix)

	process = subprocess.Popen(
		['./solve', prefix],
		stdout=subprocess.PIPE,
		stderr=subprocess.DEVNULL,
		text=True,
		bufsize=1
	)
	try:
		first_line = process.stdout.readline()
		ans = first_line.strip()[len("Found: "):]
		print(ans)
	finally:
		process.terminate()
		process.wait()

	r.sendline(ans.encode())

	print(f"Iteration {j}/1000")
	primes_sent = []
	for _ in range(1337):
		p = random_3byte_prime()
		r.sendline(str(p).encode())
		primes_sent.append(p)

	found = None
	for p in tqdm(primes_sent,total=len(primes_sent)):
		r.recvuntil(b'The power of leet prime >:D: ')
		response = int(r.recvline().strip())
		if response != 1:
			print(f"Received response: {response}")
			found = p
	if found:
		r.sendline(str(found).encode())
		r.interactive()
	r.close()

# bctf{i_HopE_yoU_did_N0T_US3_c@RmIChAE1_nUmBer5}
