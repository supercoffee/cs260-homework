
for i in range(1, 32):
    print('sw ${}, {}($t0)'.format(i, (i - 1) * 4 ))


for i in range(1, 32):
    print('lw ${}, {}($t0)'.format(i, (i - 1) * 4 ))
