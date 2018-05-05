# 17. 1부터 n까지의 BST를 만들 수 있는 경우의 수

# 현재 노드의 값을 기준으로
# 왼쪽에는 자신보다 작은 값을 가진 노드를
# 오른쪽에는 자신보다 큰 값을 가진 노드를 배치시키는
# (Binary Search Tree: 이진 탐색 트리) 를
# 만들 수 있는 경우의 수를 구한다
# 이 때 BST에는 1부터 n까지의 수가 담긴다.


# 1 부터 n까지의 수가 담긴
# BST를 구하는 함수
# 메모이제이션을 위해 n을 매개 변수로 받는 
# Proc 객체를 반환하므로
# get_bst_num.call(6) 과 같은 형태로 써야 함에 유의하자

def get_bst_num
    # 트리 길이를 구하는 함수의 재귀 호출을 위해
    # BST의 길이가 0, 1, 2 일 때
    # BST의 길이를 저장해두는 해시
    
    cached = Hash.new
    cached[0] = 0
    cached[1] = 1
    cached[2] = 2
    
    
    # 순수 함수의 동일한 입, 출력을 사전에 저장하였다가
    # 특정 입력에 대해 저장한 값을 반환하는 메모이제이션
    # (재귀 함수를 연달아 호출할 때 유용함)
    
    get_bst_num_memoize = Proc.new do |bst_len|
        result = 0

        # 값이 캐싱되지 않은 경우만
        # 실제 로직을 수행
        
        unless cached.keys.include? bst_len
            (1..bst_len).each do |cur_bst|
                # 좌측 BST의 길이 (현재 BST 노드의 인덱스 - 1)
                # 우측 BST의 길이 (BST의 길이 - 현재 BST 노드의 인덱스) 
                # 를 이용해 좌, 우측 BST의 길이를 구함
                
                left_len = get_bst_num_memoize.call(cur_bst - 1)
                right_len = get_bst_num_memoize.call(bst_len - cur_bst)
                
                # 좌, 우측 BST의 길이가 모두 0 이상일 경우
                # 곱의 법칙을 이용해 경우의 수를 구할 수 있음 
                
                # 허나 둘 중에 하나라도 0일 경우
                # 특정 방향의 경우의 수만 구함
                
                unless left_len.zero? || right_len.zero?
                    result += left_len * right_len
                else
                    unless left_len.zero?
                        result += left_len
                    else
                        result += right_len
                    end
                end
            end

            # 구한 값을 저장
            cached[bst_len] = result
        end

        # 캐싱된 값 반환
        cached[bst_len]
    end

    # Proc 객체를 반환 (.call 을 이용한 호출)
    return get_bst_num_memoize
end

(3..12).each do |bst_len| 
    puts "#{bst_len}: #{get_bst_num.call(bst_len)}"
end
