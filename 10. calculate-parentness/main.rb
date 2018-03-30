# 소괄호 문자열 "ex: (), (()())" 들이
# 올바르게 감싸져 있는지 검사하는 함수

def validate_parentheses(input)
    items = []    # 괄호들을 담아두는 배열(스택)

    input.each_char do |item|
        last = items.last    # items 의 최상위 요소 

        # last 와 item 이 서로 짝이 맞을 경우
        # items의 최상위 요소를 꺼내고 루프 통과

        if last == '(' && item != last
            items.pop
            next
        end

        # last 와 item 이 짝이 맞지 않는 경우
        # items에 item 을 담아둠

        items.push item
    end

    # 이 과정을 거치고 items의 길이가 0일 경우
    # 모두 각자에게 맞는 쌍이 있으므로 검증 통과

    return items.length == 0
end

# 검증되어있는 소괄호 문자열을 이용해
# 값을 계산하는 함수 () = 2 (x: int) = x * 2, x:int y:int = x + y

def calculate_parentheses(src)
    # 올바른 형식의 괄호가 아닌, 값을 구할 수 없는 경우
    # -1을 반환 (저번에 했던 괄호 검증 함수 참조)

    return -1 unless validate_parentheses(src)    

    stack = Array.new    # 괄호들과 값을 담아두는 스택

    src.each_char do |item|
        case item
        when '('
            stack.push item    # 여는 괄호일 경우 스택에 저장
        when ')'
            tmp = 0    # 숫자값들을 누적하는 변수

            loop do
                # 여는 괄호를 만날 경우 누적되어 있는 숫자들의 합 x 2 또는
                # 숫자들의 합이 0일 경우 2 스택에 저장

                case top = stack.pop
                when '('
                    tmp = tmp == 0 ? 2 : tmp * 2
                    break
                when Integer
                    tmp += top
                end
            end

            stack.push tmp    # 연산 결과 저장
        end
    end
    
    return stack.inject(:+)
end

puts calculate_parentheses(gets.chomp)