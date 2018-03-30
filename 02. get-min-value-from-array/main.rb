# 02. 배열의 최소값 구하기

# 공백 기준으로 여러개의 정수 배열을 입력받고
# 최소값을 구하기

# 배열의 최소값을 구하는 함수
# 배열을 인자로 넘겨주면 최소값을 반환

def get_min_from_array(arr)
    # 정렬하고 처음 값 받기 (~_~)
    return arr.sort.first
end

# 공백으로 입력 분리 (ex: 12 1 5 31)
# 이후 map를 이용해 문자열을 정수로 변환
arr = gets.split(' ').map { |s| Integer(s) }

# 최소값 구해서 출력
puts get_min_from_array(arr)