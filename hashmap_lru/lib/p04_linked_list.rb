require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new("head")
    @tail = Node.new("tail")
    @head.next = @tail
    @tail.prev = @head

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if @head.next == @tail
    @head.next
  end

  def last
    return nil if @tail.prev == @head
    @tail.prev
  end

  def empty?
    # debugger
    @head.next.key == @tail.key
  end

  def get(key)
    # self.each { |node| return node.val if node.key == key }
    current_node = @head
    until current_node == @tail
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end
    current_node.val

  end

  def include?(key)
    current_node = @head
    until current_node == @tail
      return true if current_node.key == key
      current_node = current_node.next
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    node.next = @tail
    node.prev = @tail.prev
    node.next.prev = node
    node.prev.next = node


  end

  def update(key, val)
    current_node = @head
    until current_node == @tail
      if current_node.key == key
        current_node.val = val
      end
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = @head
    until current_node == @tail
      if current_node.key == key
        current_node.remove
      end
      current_node = current_node.next
    end
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
