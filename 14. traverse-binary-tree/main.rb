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

# 트리의 전위, 중위, 후위 순회를 맡는 함수
# order 매개변수에 순회 방식을 결정하는 :pre, :in, :post 심볼을 인자로 넘겨 순회 방식을 결정
# :pre (전위 - root -> left -> right)
# :in (중위: left -> root -> right)
# :post (후위: left -> right -> root)

def traversal_tree(root, order)
    # 현재 노드의 부모 노드를 추적하기 위한 스택(배열)
    stack = []

    # 현재 루트 노드 (current root node)
    cnode = root

    # 좌측 자식 노드를 탐색하는 바깥쪽 루프
    loop do
        # 후위 순회를 제외하고는 맨 처음에 stack에 노드들을 저장
        stack.push cnode unless order == :post

        # 전위 순회는 루트 노드를 먼저 방문하고, 좌우 노드들을 방문
        print "#{cnode.data} " if order == :pre

        # 우선 왼쪽 방향의 자식 노드를 추적
        unless cnode.left.nil?
            # 후위 순회의 경우 좌측 자식 노드가 있을 때만
            # 현재 루트 노드를 스택에 저장
            stack.push cnode if order == :post
            
            # cnode를 자식 노드로 설정함으로써
            # 자식 노드의 좌측 자식 노드 추적
            cnode = cnode.left
            next
        end

        # 우측 자식 노드를 탐색하는 안쪽 루프
        loop do
            # 후위 노드는 우선 추적한 자식 노드를 방문
            print "#{cnode.data} " if order == :post
            
            # 전, 중위 노드는 스택 최상위에 저장한 노드를 꺼냄
            cnode = stack.pop

            # 스택이 빌 경우는 루트 노드까지 순회가 끝났다는 것
            # 따라서 추적을 중지
            break if cnode.nil?
            
            # 중위 순회는 스택 최상위에서 꺼낸 노드를 출력
            print "#{cnode.data} " if order == :in

            # 우측 노드 발견 시 전, 중위 탐색은
            # 해당 노드를 추적하고 다시 좌측 노드를 탐색

            # 후위 순회는 우측 노드를 방문한 후
            # 부모 노드를 추적
            unless cnode.right.nil?
                if order == :post
                    print "#{cnode.right.data} "
                    next
                else
                    cnode = cnode.right
                    break
                end
            end
        end
        
        # 현재 루트 노드가 nil, 추적이 끝날 경우
        # 바깥쪽 루프도 중단
        break if cnode.nil?
    end

    # 단순한 줄바꿈
    puts
end

# 특정 길이만큼 문자열 입력받기
len = Integer(gets)

# 이중 연결 리스트를 이용한 트리 생성
root = get_tree_from_dual_linked_list(len)

# 전위 순회 (pre order traversal)
traversal_tree(root, :pre)

# 중위 순회 ()
# traversal_tree(root, :in)
# traversal_tree(root, :post)