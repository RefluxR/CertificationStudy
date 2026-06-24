class Data:
    value = None
    next = None
    def __init__(self, value, next=None):
        self.value = value
        self.next = next

def create_list(elements):      #def insert(head, value):
    head = None                     #new_node = Data(value, head)
    for i in elements:              #return new_node
        head = Data(i, head)
        print(f"생성된 head는 {head.value}")
    return head


def reconnect(head, value):
    
    return 0

def show_list(head):
    prev_node = head
    list = []
    while(prev_node.next != None):
        print(prev_node.value)
        list.append(prev_node.value)
        prev_node = prev_node.next # 노드 이동
    
    return list

size = int(input("list size >>> "))

head = create_list(range(1,size+1))
node = show_list(head)
print(node)
