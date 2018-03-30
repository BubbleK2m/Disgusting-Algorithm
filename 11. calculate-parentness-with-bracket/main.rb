# 소괄호 문자열 "ex: (), (()())" 들이
# 올바르게 감싸져 있는지 검사하는 함수

def validate_parentheses_with_bracket(input)
    items = []    # 괄호들을 담아두는 배열(스택)

    input.each_char do |item|
        last = items.last

        # last 와 item 이 서로 짝이 맞을 경우
        # items의 최상위 요소를 꺼내고 루프 통과

        elems = last, item

        if elems == ['(', ')'] || elems == ['[', ']']
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

# 검증되어있는 소괄호, 대괄호 문자열을 이용해 연산을 진행하는 ㅎ마수 

# () = 2 (x) = x * 2, xy = x + y
# [] = 3 [x] = x * 3, xy = x + y

def calculate_parentheses_with_bracket(src)
    # 올바른 형식의 괄호가 아닌, 값을 구할 수 없는 경우
    # -1을 반환 (저번에 했던 괄호 검증 함수 참조)

    return -1 unless validate_parentheses_with_bracket(src)    

    stack = Array.new    # 괄호들과 값을 담아두는 스택

    def flush_stack(stack, dist, value)
        # 괄호를 비우는 작업

        tmp = 0    # 숫자값들을 누적하는 변수

        loop do
            case top = stack.pop
            when dist
                tmp = tmp == 0 ? value : tmp * value
                break
            when Integer
                tmp += top
            end
        end

        return tmp
    end

    src.each_char do |item|
        case item
        when '(', '['
            stack.push item    # 여는 괄호일 경우 스택에 저장
        when ')'
            stack.push flush_stack(stack, '(', 2)    # 연산 결과 저장 () = 2, (x) = 2 * x, xy = x + y
        when ']'
            stack.push flush_stack(stack, '[', 3)    # 연산 결과 저장 [] = 3, [x] = 3 * x, xy = x + y
        end
    end
    
    return stack.inject(:+)
end

print calculate_parentheses_with_bracket(gets.chomp)