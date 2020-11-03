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
end
