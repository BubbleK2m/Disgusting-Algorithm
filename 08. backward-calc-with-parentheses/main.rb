# 후위 계산문 생성기
# 괄호 ['(', ')'] 추가 버전

def backward_calc_with_parentheses(items)
    ranks = Hash.new    # 우선 순위가 담긴 맵

    ranks['+'] = 2
    ranks['-'] = 2
    ranks['*'] = 1
    ranks['/'] = 1

    stack  = Array.new    # 연산자를 담아두는 스택

    items.each do |item|
        if /[0-9]+/.match item
            # item이 숫자라면
            # 출력 후 다음 루프로 점프

            print "#{item}"
            next
        end

        # item이 여는 괄호 ['('] 를 제외한 나머지 연산자 중 하나라면

        if '+-*/)'.include? item
            
            # 우선 순위보다 낮거나 같은 연산자를 찾아 꺼내는 루프

            loop do
                # top (스택의 최상단) 이 nil, stack의 길이가 0이거나 여는 괄호일 경우 루프를 끊음

                top = stack.last
                break if top.nil? || top == '(' 
                
                # item이 top보다 우선 순위가 높을 경우 루프를 끊음
                # 반대의 경우 top을 꺼내서 출력

                break if item != ')' && ranks[item] < ranks[top]
                print stack.pop    
            end
        end

        item == ')' ? stack.pop : stack.push(item)    # 닫는 괄호 [')'] 를 제외한 나머지 연산자는 스택에 저장 
    end
    
    # 마지막으로 스택에 담겨 있는 연산자를 모두 꺼냄

    loop do
        stack.last.nil? ? break : print(stack.pop)
    end
end

backward_calc_with_parentheses gets.chomp.split(' ')