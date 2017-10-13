require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    hash_id = key.hash
    unless self[hash_id].include?(key)
      self[hash_id] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if self[key.hash].include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets
    @store[i]

  end

  def num_buckets
    @store.length
  end

  def resize!
    holder_array = @store.flatten
    new_array = Array.new(num_buckets * 2) { Array.new }
    @store = new_array
    @count = 0
    holder_array.each do |item|
      self.insert(item)
    end
  end
end
