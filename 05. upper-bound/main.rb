# 05. upper bound,
# 정렬된 배열에서 특정 값보다 큰 값의 위치 찾기

def upper_bound(array, target)
    # 배열을 복사
    temp = array.clone

    loop do
        length = temp.length
        pivot = length / 2

        return array[pivot + 1] if temp[pivot] == target
        
        left = temp.first(pivot)
        right = temp.last(length % 2 == 0 ? pivot - 1 : pivot)

        temp = target < temp[pivot] ? left : right 
    end
end

array = gets.split(' ').map{ |s| Integer(s) }.sort
result = upper_bound(array, Integer(gets))

puts !result.nil? ? array.find_index(result) : -1 