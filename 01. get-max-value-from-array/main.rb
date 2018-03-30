# 01. 배열의 최대값 구하기

# 공백 기준으로 여러개의 정수 배열을 입력받고
# 최대값을 구하기

# 배열의 최대값을 구하는 함수
# 배열을 인자로 넘겨주면 최대값을 반환

def get_max_from_array(arr)
    # 정렬하고 마지막 값 받기 \(~_~)/
    return arr.sort.last
end

# 공백으로 입력 분리 (ex: 12 1 5 31)
# 이후 map를 이용해 문자열을 정수로 변환
arr = gets.split(' ').map { |s| Integer(s) }

# 최댓값 구해서 출력!
puts get_max_from_array(arr)