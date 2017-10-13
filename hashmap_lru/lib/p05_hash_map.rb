require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    i = key.hash % num_buckets
    @store[i].include?(key)
  end

  def set(key, val)
    i = key.hash % num_buckets
    if @store[i].include?(key)
      @store[i].update(key, val)
    else
      if @count == num_buckets
        resize!
      end
      @store[i].append(key, val)
      @count += 1
    end
  end

  def get(key)
    i = key.hash % num_buckets
    @store[i].get(key)
  end

  def delete(key)
    i = key.hash % num_buckets
    if @store[i].include?(key)
      @store[i].remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |list|
      list.each { |el| prc.call(el.key, el.val) }
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |list|
      list.each do |el|
        new_store[el.key.hash % (num_buckets*2)].append(el.key, el.val)
      end
    end
    @store = new_store

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
