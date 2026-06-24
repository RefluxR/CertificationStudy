def f(a):
    m = [[x] for x in a]
    b = m[:] # 이렇게 하면 b와 m이 메모리상 동일하게 됨, 그래서 
             # b가 수정되면 m도 똑같이 수정 됨

    #print(m) = [[1], [2], [3], [4]]
    #print(b)

    for i in range(len(b) - 1):
        b[i+1] += b[i]

    print(b)
    print(m)
    return sum(len(x) for x in m)
 
print(f([1, 2, 3, 4]))



