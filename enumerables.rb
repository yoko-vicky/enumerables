require_relative 'helpers'
# call rubocop:disable Style/CaseEquality
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    array = *self
    array.size.times { |index| yield(array[index]) }
    self
  end

  def my_each_index
    return enum_for(:my_each) unless block_given?

    array = *self
    array.size.times { |index| yield(index) }
  end

  def my_select
    return enum_for(:my_each) unless block_given?

    array = *self
    new_array = []
    array.my_each { |item| new_array.push(item) if yield(item) }
    new_array
  end

  def my_all?(*patt)
    array = *self
    return Helper.given_patt_for_all(array, patt[0]) if patt.size.positive?

    if block_given?
      array.my_each { |item| return false unless yield(item) }
    else
      array.my_each { |item| return false unless item }
    end

    true
  end

  def my_any?(*patt)
    array = *self
    # should use helper
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

  # my_none?
  # my_count
  # my_map
  # my_inject
  # multiply_els => multiplies all the elements of the array together by using #my_inject,
  # e.g. multiply_els([2,4,5])=> 40
end
