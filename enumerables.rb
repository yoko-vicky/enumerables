module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    array = *self
    array.size.times do |index|
      yield(array[index])
    end
    self
  end

  def my_each_index
    return enum_for(:my_each) unless block_given?

    array = *self
    array.size.times do |index|
      yield(index)
    end
  end

  # select

  def my_select
    return enum_for(:my_each) unless block_given?

    array = *self
    new_array = []
    array.my_each do |item|
      new_array.push(item) if yield(item)
    end
    new_array
  end

  def my_all?(*pat)
    array = *self

    if pat.size.positive?
      case pat
      when Regexp
        array.my_each { |item| return false unless pat.match?(item.to_s) }
      when Class
        array.my_each { |item| return false unless item.class == pat }
      end
    elsif block_given?
      array.my_each { |item| return false unless yield(item) }
    else
      array.my_each { |item| return false unless item }
    end
    true
  end

  # my_any?
  def my_any?(*patt)
    array = *self
    if patt.size.positive?
      case patt[0]
      when Regexp
        array.my_each { |item| return true if patt[0].match?(item.to_s) }
      when Class
        array.my_each { |item| return true if item.is_a?(patt[0]) }
      else
        array.my_each { |item| return true if item == patt[0] }
      end
    elsif block_given?
      array.my_each { |item| return true if yield(item) }
    else
      array.my_each { |item| return true if item }
    end
    false
  end
end
