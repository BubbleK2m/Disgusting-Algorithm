# 04. 이진 탐색

# 배열의 특정 요소를 이진 탐색을 이용하여 찾아내기
# 이진 탐색일 이용하여 찾고자 하는 값이 담긴 인덱스를 반환합니다

# 이진 탐색에 대해 조금 떠들자면 찾고자 하는 값이
# 배열의 가운데 요소, pivot을 기준으로

# pivot 보다 크면 pivot의 왼쪽 배열에서
# pivot 보다 작으면 pivot의 오른쪽 배열에서

# 아래와 같이 값을 탐색합니다
# (value < pivot <- pivot -> pivot > value)

# pivot 주위에 아무 것도 없거나
# pivot 값과 찾고자 하는 값이 일치할 때까지
# 이 과정을 재귀적으로 반복합미당

# 단 이진 탐색은 정렬된 배열에서만 사용 가능하다는 점을
# 위의 과정에서 왼쪽, 오른쪽 방향의 기준을 거꾸로 해주시면
# 내림차순으로 정렬된 배열에서도 이진 탐색이 가능합니다


# 배열의 정렬 여부를 확인하는 함수
# 버블 정렬의 비교 과정과 유사하게
# 주변의 값을 기준으로 정렬 여부를 확인

# ord 매개 변수에 정렬 순서를 나타내는 
# :aesc(오름차순), :desc(내림차순) 심볼을 넘겨 정렬 순서를 결정
def is_sorted_arr?(arr, dir)
    len = arr.length

    arr[i...(len-1)].each.with_index do |v, i| 
        # 오름차순 배열의 경우 우측 요소가 자신보다 작으면
        # 내림차순 배열의 경우 우측 요서가 자신보다 크면
        # 올바르게 정렬되지 못한 배열임

        return false if (dir == :aesc ? v > self[i+1] : v < self[i+1]) 
    end

    return true
end


# 배열을 이용한 이진 탐색 함수
# 요소를 찾을 경우 해당 요소가 담긴 인덱스를
# 찾지 못할 경우 -1을 반환합니다
def binary_search_with_array(arr, val)
    len = arr.length
    
    # pivot 값을 구함 (배열의 길이 / 2)
    piv = len / 2

    # 이진 탐색이 종료되는 경우
    # 배열에서 값을 찾았거나, 값이 없을 경우
    
    # arr[pivot] 값과 찾고자 하는 값의 일치 여부 확인 후
    # pivot 또는 -1 반환

    if arr[piv].nil? || arr[piv] == val
        return arr[piv] == val ? piv : -1
    end

    # pivot 을 기준으로 좌측 배열
    left = arr.first(piv)

    # pivot 을 기준으로 우측 배열
    right = arr.last(length % 2 == 0 ? piv - 1 : piv)

    # 이진 탐색을 재귀적으로 반복
    return binary_search(val < arr[piv] ? left : right , val)
end

# 공백을 기준으로 입력받은 정수를 분리
# map를 이용해 정수형 배열로 전환
arr = gets.split(' ').map{ |s| Integer(s) }.sort

# 이진 탐색의 결과를 출력
puts binary_search(arr, Integer(gets))