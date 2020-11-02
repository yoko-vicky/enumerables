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
end
