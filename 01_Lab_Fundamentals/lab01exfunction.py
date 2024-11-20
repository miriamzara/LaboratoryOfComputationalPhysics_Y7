def square(n):
    try:
        s = n**2
    except:
        ValueError("n must be a int or double value")
    return s