f = open("./input.txt", "r")

def to_id(n):
    table = str.maketrans("FLBR", "0011")
    new = n.translate(table).replace('\n', '')    
    return int(new, 2)

final = set(map(to_id, f))
all_seats = set(range(min(final), max(final)))
print(list(all_seats - final)[0])
