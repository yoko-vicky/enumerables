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
    return Helper.given_patt_for_all(array, patt[0]) unless patt.empty?

    if block_given?
      array.my_each { |item| return false unless yield(item) }
    else
      array.my_each { |item| return false unless item }
    end

    true
  end

  def my_any?(*patt)
    array = *self
    return Helper.given_patt_for_any(array, patt[0]) unless patt.empty?

    if block_given?
      array.my_each { |item| return true if yield(item) }
    else
      array.my_each { |item| return true if item }
    end
    false
  end

  def my_none?(*patt)
    array = *self
    return Helper.given_patt_for_none(array, patt[0]) unless patt.empty?

    if block_given?
      array.my_each { |item| return false if yield(item) }
    else
      array.my_each { |item| return false if item }
    end
    true
  end

  # my_count
  # my_map
  def my_inject(*arg)
    arr = *self
    raise LocalJumpError, 'no block given' unless block_given? || arg.size.positive?

    if block_given?
      result = arg[0] if arg.size.positive?
      arr.size.times { |index| result = result ? yield(result, arr[index]) : arr[index] }
    else
      if arg.size == 2
        result = arg[0]
        symbol = arg[1]
      elsif arg.size == 1
        symbol = arg[0]
      end
      arr.size.times { |index| result = result ? result.send(symbol, arr[index]) : arr[index] }
    end
    result
  end
end

def multiply_els(array)
  array.my_inject { |result, item| result * item }
end
