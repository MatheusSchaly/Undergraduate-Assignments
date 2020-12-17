while True:
    B, t, I, S = input().split()
    B = int(B)
    t = int(t)
    I = int(I)
    S = int(S)

    mp = B**-1 * B**I

    if B == 10:
        b = ['0.']
        for i in range(t):
            b.append('9')
        b = "".join(b)
        b = float(b)
        MP = b * B**S
    elif B == 2:
        sum = 0
        for i in range(1, t+1):
            sum += B**(-i)
        MP = sum * B**S

    NF = ((B-1)*B**(t-1)) * (S-I+1) * 2 + 1

    print('mp:', mp)
    print('MP:', MP)
    print('NF:', NF)
    print(f'regiao de underflow: {-mp} a {mp}')
    print(f'regiao de overflow: menor que {-MP} ou maior que {MP}')
    print()
