module Helper
  def self.given_patt_for_all(array, patt)
    case patt
    when Regexp
      array.my_each { |item| return false unless patt.match?(item.to_s) }
    when Class
      array.my_each { |item| return false unless item.is_a?(patt) }
    else
      array.my_each { |item| return false unless item == patt }
    end
    true
  end

  def self.given_patt_for_any(array, patt)
    case patt
    when Regexp
      array.my_each { |item| return true if patt.match?(item.to_s) }
    when Class
      array.my_each { |item| return true if item.is_a?(patt) }
    else
      array.my_each { |item| return true if item == patt }
    end
    false
  end

  def self.given_patt_for_none(array, patt)
    case patt
    when Regexp
      array.my_each { |item| return false if patt.match?(item.to_s) }
    when Class
      array.my_each { |item| return false if item.is_a?(patt) }
    else
      array.my_each { |item| return false if item == patt }
    end
    true
  end

  def self.not_block_given_for_inject(arr, arg)
    if arg.size == 2
      result = arg[0]
      symbol = arg[1]
    elsif arg.size == 1
      symbol = arg[0]
    end
    arr.size.times { |index| result = result ? result.send(symbol, arr[index]) : arr[index] }
    result
  end
end
