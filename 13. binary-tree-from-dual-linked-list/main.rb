# 13. 이중 연결 리스트를 이용한 이진트리 만들기

# 입력에서 <current_node> <left_node> <right_node> 의 데이터를 입력받고
# 이중 연결 리스트를 이용해 이진 트리를 구현하자

# - ex -

# A B C
# B D .
# C . E

# ↑ 와 같이 입력을 받아
# ↓ 와 같은 이진 트리를 만들자

#   A
#  B C
# D   E


# 트리를 구현하기 위한 이중 연결 리스트 객체
class DualLinkedList
    attr_accessor :data    # 노드에 들어있는 데이터
    attr_accessor :left    # 좌측 노드
    attr_accessor :right   # 우측 노드

    # 생성자 함수
    # 데이터, 좌, 우측 노드를 설정
    def initialize(data, left = nil, right = nil)
        @data = data
        @left = left
        @right = right
    end

    # 디버깅을 위한 to_s 메서드
    # puts 로 객체 출력 시 아래와 같은 문자열 반환
    # data: A, left: B, right: . 

    def to_s        
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