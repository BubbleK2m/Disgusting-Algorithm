# 18. 이진 트리의 후위 순회

# 주어진 BST의 전위 순회 결과를 나타낸 문자열을 기반으로
# BST를 생성한 후, BST의 후위 순회 결과를 출력


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

# BST의 전위 순회 결과가 담긴 배열을 기반으로
# BST를 생성하는 함수
def generate_bst_from_array(items)
    # BST의 루트 노드를 생성
    rnode = DualLinkedList.new(items.shift)
    
    # BST의 부모, 자식 노드를 기록하는 
    # 스택처럼 쓰일 BST 노드의 배열
    stack = Array.new

    # 스택에 루트 노드를 저장
    stack.push rnode

    for i in items
        # 주어진 데이터을 갖는 BST 노드 생성
        tnode = DualLinkedList.new(i)
        
        # 가장 최근에 저장된 BST 노드
        cnode = stack.pop

        # 스택에서 cnode 바로 밑에 위치한 BST 노드
        pnode = nil

        loop do
            # cnode를 꺼낸 이후 스택의 최상단을 확인
            pnode = stack.last

            # pnode가 존재할 경우
            # pnode가 존재하지 않거나, 스택의 길이가 1보다 클 때까지
            # 스택의 BST 노드들을 꺼내 확장 가능한 BST 노드를 추적
            
            unless pnode.nil?
                if i < pnode.data && pnode.left.nil?
                    pnode.left = tnode
                    break
                end

                if i > pnode.data && pnode.right.nil?
                    pnode.right = tnode
                    break
                end

                if stack.length > 1
                    stack.pop
                    next
                end
            end

            # 확장 가능한 노드가 없을 경우
            # BTS 노드를 cnode에 확장시킴
            # 이 때, cnode를 스택에 담아두는 것을 잊지 말자

            if i < cnode.data && cnode.left.nil?
                cnode.left = tnode
                stack.push cnode
                break
            end

            if i > cnode.data && cnode.right.nil?
                cnode.right = tnode
                stack.push cnode
                break
            end
        end

        # 이후 확장시킨 BST 노드를 스택에 저장
        stack.push tnode
    end

    # 트리 생성 후 루트 노드를 반환
    return rnode
end

# BST의 전위 순회 결과를 입력받음
items = gets.split(' ').map{|i| Integer(i)}

# 이를 토대로 BST를 생성
bst = generate_bst_from_array(items)

# 마지막으로 BST를 후위 순회
post_order_traverse_tree(bst)