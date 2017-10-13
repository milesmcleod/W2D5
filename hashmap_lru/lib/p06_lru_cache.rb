require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  # attr_reader :count
  def initialize(max, prc = nil)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map[key])
    else
      calc!(key)
    end
    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key, val)
    @map[key] = @store.last
    if @map.count > @max
      eject!
    end
  end

  def update_node!(node)
    @store.remove(node.key)
    @store.append(node.key, node.val)
    @map[node.key] = @store.last
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end
