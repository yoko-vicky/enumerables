require_relative 'helpers'
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    array = *self
    array.size.times { |index| yield(array[index]) }
    self
  end

  def my_each_with_index
    return enum_for(:my_each) unless block_given?

    array = *self
    array.size.times { |index| yield(array[index], index) }
    self
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

  def my_count(*value)
    array = *self
    count = 0

    if block_given?
      array.my_each { |item| count += 1 if yield(item) }
      return count
    elsif value.size.positive?
      array.my_each { |item| count += 1 if item == value[0] }
      return count
    end

    array.size
  end

  def my_map(*args, &block)
    return enum_for(:my_each) unless block_given?

    array = *self
    new_array = []
    array = args if args.size.positive?
    array.my_each { |item| new_array.push(block ? block.call(item) : yield(item)) }
    new_array
  end

  def my_inject(*arg)
    arr = *self
    raise LocalJumpError, 'no block given' unless block_given? || arg.size.positive?

    return Helper.not_block_given_for_inject(arr, arg) unless block_given?

    result = arg[0] if arg.size.positive?
    arr.size.times { |index| result = result ? yield(result, arr[index]) : arr[index] }
    result
  end
end

def multiply_els(array)
  array.my_inject { |result, item| result * item }
end
