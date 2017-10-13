class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    str = ''
    self.each_with_index do |el, idx|
      hash_num = (idx + 1) * 42 * 99 / 3
      str << (el * hash_num).to_s
    end
    str.to_i
  end
end

class String
  def hash
    str = ''
    self.chars.each_with_index do |letter, idx|
      str << (letter.ord * idx * 17 / 3 * 43 + 6).to_s
    end
    str.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    str = ''
    self.each do |k, v|
      str << ((k.to_s.hash + v.to_s.hash) * 43874).to_s
    end
    str.to_i
  end
end
