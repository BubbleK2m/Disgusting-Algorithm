# 후위 계산문 생성기
# 기본적인 덧셈, 뺄셈이 들어간 후위 연산 '+', '-'

def backward_calc(items)
    stack = Array.new    # 연산자 스택

    items.each.with_index do |item, index|
        if /[0-9]+/.match item
            print item
            next
        elsif '+-'.include? item
            print stack.pop unless stack.last.nil? 
            stack.push item
        end
    end

    print stack.pop unless stack.last.nil?
end

backward_calc gets.split(' ')