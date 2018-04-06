# 16. 이진 트리의 후위 순회

# 이진 트리에서 root, left, right 노드가 있을 때
# left -> right -> root 순서로 트리를 순회

# - ex -

# A B C
# B D .
# C . E

# ↑ 와 같이 입력을 받아
# ↓ 와 같은 이진 트리를 만들자

#   A
#  B C
# D   E

# 그리고 left -> right -> root 순서로 노드를 방문해
# ↓ 같은 출력을 구하자

# D B E C A


# 트리를 구현하기 위한 이중 연결 리스트 객체
# data: 노드에 들어있는 데이터
# left: 좌측 노드
# right: 우측 노드
class DualLinkedList
    attr_accessor :data, :left, :right

    def initialize(data, left = nil, right = nil)
        @data = data
        @left = left
        @right = right
    end

    def to_s
        # 디버깅을 위한 to_s 메서드
        # puts 로 객체 출력 시 아래와 같은 문자열 반환
        # data: A, left: B, right: . 
        "data: #{@data}, " + 
        "left: #{!@left.nil? ? @left.data : '.'}, " + 
        "right: #{!@right.nil? ? @right.data : '.'}"
    end
end

# 이중 연결 리스트를 이용한 트리 생성
def get_tree_from_dual_linked_list(len)
    # 노드들의 참조를 저장하는 배열
    nodes = []
    
    # 노드 안에 저장되어 있는 데이터를 이용한 요소 추적
    # 찾고자 하는 노드의 데이터와 참조를 담은 배열을 인자로 넘김
    def get_node_by_data(data, nodes)
        # 문자열 '.'은 빈 노드를 나타내므로 nil 반환
        return nil if data == '.'

        # 조건에 부합하는 노드를 찾지 못할 시 nil 반환
        idx = nodes.index { |n| n.data == data }
        node = nil

        # 해당 데이터를 갖는 노드가 배열에 존재하지 않을 경우
        # 새로운 노드를 추가
        unless idx.nil?
            node = nodes[idx]
        else
            node = DualLinkedList.new(data)
            nodes.push node
        end

        # 생성된 노드를 반환
        return node
    end

    # n번 입력을 받아 이진 트리 생성
    (0...len).each do |i|
        data, left, right = gets.split(' ')

        # 입력한 데이터를 갖는 노드가 있을 경우
        # 기존의 노드를 참조에 저장
        cnode = get_node_by_data(data, nodes)
        cnode.left = get_node_by_data(left, nodes)
        cnode.right = get_node_by_data(right, nodes)
    end

    # 배열의 첫번째 요소, 루트 노드를 반환
    return nodes[0]
end

# 트리를 후위 순회하는 함수
# left, right, root 순서로 노드를 방문
def post_order_traverse_tree(root)
    # 현재 노드의 부모 노드를 추적하기 위한 스택(배열)
    stack = []

    # 현재 탐색의 기준이 되는 노드 (current pivot node from traversing)
    cnode = root
    
    loop do
        # 현재 노드의 우측 자식 노드가 존재할 경우
        # 스택에 우측 자식 노드를 저장
        rnode = cnode.right
        stack.push rnode unless rnode.nil?

        # 이후 현재 노드를 스택에 저장
        stack.push cnode

        # 현재 노드의 좌측 자식 노드가 존재할 경우
        # 좌측 자식 노드의 탐방 시작
        lnode = cnode.left

        unless lnode.nil?
            # 좌측 자식 노드가 존재할 경우
            # 탐색할 노드를 좌측 자식 노드로 설정
            cnode = lnode
            next
        end
        
        loop do
            # 스택에 저장해 둔 기준 노드를 꺼냄
            cnode = stack.pop
            break if cnode.nil?

            # 우측 자식 노드가 존재하고 스택의 최상위에 노드가 존재할 경우 
            # 우측 자식 노드의 탐색이 끝나지 않았으므로 새로이 탐색 시작
            rnode = cnode.right
            tnode = stack.last

            unless rnode.nil? || tnode.nil?
                # 최상위 노드가 우측 자식 노드가 아닐 경우
                # 탐색을 수행하지 않음
                if rnode == tnode
                    # 스택에서 우측 노드를 꺼내고
                    # 현재 기준 노드는 다시 집어넣음
                    pnode = stack.pop
                    stack.push cnode

                    cnode = pnode
                    break
                end
            end

            # 현재 기준 노드를 출력
            print "#{cnode.data} "
        end

        break if cnode.nil?
    end

    # 단순한 줄바꿈
    puts
end

len = Integer(gets)
root = get_tree_from_dual_linked_list(len)

post_order_traverse_tree(root)