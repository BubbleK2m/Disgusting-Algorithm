# 배열을 이용한 이진 트리 생성

def tree(len)
    nodes = Array.new

    (0...len).each do |i|
        node, left, right = gets.split(' ')
        nodes[i] = node if trees[i].nil?

        nodes[i * 2 + 1] = left
        nodes[i * 2 + 2] = right
    end

    return nodes
end

print "#{tree(Integer(gets))}\n"