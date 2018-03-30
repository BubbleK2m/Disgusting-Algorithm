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

count = Integer(gets.chomp)

count.times do
    puts validate_parentheses(gets.chomp) ? "YES" : "NO"
end
