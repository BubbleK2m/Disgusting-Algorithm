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
        unless cached_lens.keys.include? len
            (1..len).each do |cur_bst|
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
    return get_bst_len_memoize
end

(1..10).each do |bst_len| 
    puts "#{bst_len}: #{get_bst_len.call(bst_len)}"
end
