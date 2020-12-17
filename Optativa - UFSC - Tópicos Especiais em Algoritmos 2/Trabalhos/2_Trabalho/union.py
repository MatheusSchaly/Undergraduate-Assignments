class Node():

    # Inicializador
    def __init__(self, data):
        self.criar(data)

    def __str__(self):
        print('Tree:')
        temp = self.parent
        print(f'{self.data} Rank:{self.rank}')
        print(f'{temp.data} Rank:{temp.rank}')
        while temp.parent != temp:
            temp = temp.parent
            print(f'{temp.data} Rank:{temp.rank}')
        return ""

    # Cria um conjunto com o elemento x (onde x será o representante)
    def criar(self, x):
        self.rank = 0
        self.data = x
        self.parent = self

    # Encontra o representando do cojnuto que o elemento x pertence
    def encontrar(self):
        temp = self.parent
        while temp.parent != temp:
            temp = temp.parent
        return temp

    # Se x está em um conjunto Sx e y está em outro conjunto Sy então a
    # operação cria um novo conjunto S = Sx U Sy
    def unir(self, y):
        rx = self.encontrar()
        ry = y.encontrar()
        if rx == ry:
            return
        elif rx.rank > ry.rank:
            ry.parent = rx
        else:
            rx.parent = ry
            if rx.rank == ry.rank:
                ry.rank += 1

if __name__ == '__main__':
    sets = []
    n = int(input())
    for i in range(n):
        set = [int(n) for n in input().split()]
        node_temp = Node(set[0])
        sets.append(node_temp)
        for j in range(1, len(set)):
            node_temp.unir(Node(set[j]))

    m = int(input())
    for set in sets:
        print(set)
