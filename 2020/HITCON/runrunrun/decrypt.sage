enc = [98, 32, 84, 253, 217, 18, 92, 22, 112, 138, 147, 46, 168, 229, 31, 149, 72, 94, 191, 124, 21, 176, 10, 104, 154, 213, 235, 25, 237, 61, 18, 15]
keys = [1, 3, 9, 27, 81, 243, 729, 2187, 6561, 19683, 59049, 177147, 531441, 1594323, 4782969, 14348907, 43046721, 129140163, 387420489, 1162261467, 3486784401, 10460353203, 31381059609, 94143178827, 282429536481, 847288609443, 2541865828329, 7625597484987, 22876792454961, 68630377364883, 205891132094649, 617673396283947]

K = GF(31337)

update = Matrix([
	[2, 1, 7],
	[1, 0, 0],
	[0, 1, 0],
], ring=K)

col = Matrix([[1], [1], [1]], ring=K)

def solve(cnt):
	a = 1
	b = 1
	c = 1

	for _ in range(cnt):
		d = (a*2 + b + c*7)%31337
		c = b
		b = a
		a = d
	
	return a

def fast_solve(n):
	return int(((update^n) * col)[0,0])

flag = bytearray()

for e, k in zip(enc, keys):
	flag.append(e ^^ (fast_solve(k)&0xff))
	print(flag)
