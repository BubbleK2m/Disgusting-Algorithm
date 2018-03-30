# 후위 계산문 생성기 
# 연산자의 우선순위 등장 ('*', '/') = 1 , ('+', '-') = 2

def backward_calc_with_priority(items)
    ranks = Hash.new    # 연산자 우선순위 지정 맵

    ranks['+'] = 2
    ranks['-'] = 2
    ranks['*'] = 1
    ranks['/'] = 1

    stack = Array.new    # 연산자 스택

    # 출력을 위한 아이템 순회
    items.each do |item|
        if /[0-9]+/.match item
            # 숫자는 출력
            print item
        elsif '+-*/'.include? item
            # 우선순위가 자신보다 높거나 같은 연산자를 
            # 추출, 출력하는 루프

            loop do 
                top = stack.last
                
                # 스택의 길이가 0이거나 item의 우선순위가 top보다 높을 경우
                # 루프문 종료

                break if top.nil? || ranks[item] < ranks[top]    
                print stack.pop    # 현재 연산자를 추출
            end

            stack.push item    # 연산자는 스택에 저장
        end
    end

    # 마지막으로 스택에 담겨져 있는 연산자 추출

    loop do
        stack.last.nil? ? break : print(stack.pop)    # 스택이 빌 때까지 꺼내서 출력
    end
end

backward_calc_with_priority gets.split(' ')