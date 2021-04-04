
import random;
import string;

def valid(s, c, n):
    return s.find(c * n)

s = list(random.choices(string.ascii_uppercase + string.digits, k=2048))
c = random.choice(string.ascii_uppercase + string.ascii_lowercase)
off = random.randint(0, 2036)
ret = random.randint(1, 10)

for i in range(ret):
    s[i + off] = c

if(valid(''.join(s), c, ret) == entry(''.join(s), c, ret)):
    print("passed")
else:
    print("failed")
