# spec/enumerable_spec.rb

require '../enumerable.rb'

describe Enumerable do
  let(:num_array) { [1, 2, 3, 5, 7, 8] }
  let(:empty_array) { [] }
  let(:str_array) { %w[m i n t] }
  let(:range) { (1..5) }
  let(:hash) { { 'a': 2, 'b': 5, 'c': 7, 'd': 8 } }
  let(:str) { %(pine) }

  describe '#my_each' do
    it 'returns the same result as each method to num_array' do
      test_array = []
      num_array.my_each { |i| test_array << i * 2 }
      expect(test_array).to eql([2, 4, 6, 10, 14, 16])
    end

    it 'returns the same result as each method to str_array' do
      test_array = []
      str_array.my_each { |item| test_array << item }
      expect(test_array).to eql(%w[m i n t])
    end

    it 'returns the same result as each method to range' do
      test_array = []
      range.my_each { |i| test_array << i * 2 }
      expect(test_array).to eql([2, 4, 6, 8, 10])
    end

    it 'returns the same result as each method to hash' do
      test_array = []
      hash.my_each { |key, value| test_array << "#{key}: #{value}" }
      expect(test_array).to eql(['a: 2', 'b: 5', 'c: 7', 'd: 8'])
    end

    it 'returns the same result as each method to string without block' do
      expect { str.my_each }.to raise_error(NoMethodError)
    end

    it 'returns the same result as each method to num_array without block' do
      expect(num_array.my_each).to be_a(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'returns the same result as each_with_index method to num_array' do
      test_array = []
      num_array.my_each_with_index { |item, index| test_array << "#{index}: #{item}" }
      expect(test_array).to eql(['0: 1', '1: 2', '2: 3', '3: 5', '4: 7', '5: 8'])
    end

    it 'returns the same result as each_with_index method to str_array' do
      test_array = []
      str_array.my_each_with_index { |item, index| test_array << "#{index}: #{item}" }
      expect(test_array).to eql(['0: m', '1: i', '2: n', '3: t'])
    end

    it 'returns the same result as each_with_index method to range' do
      test_array = []
      range.my_each_with_index { |item, index| test_array << "#{index}: #{item}" }
      expect(test_array).to eql(['0: 1', '1: 2', '2: 3', '3: 4', '4: 5'])
    end

    it 'returns the same result as each_with_index method to hash' do
      test_array = []
      hash.my_each_with_index { |item, index| test_array << "#{index}: #{item}" }
      expect(test_array).to eql(['0: [:a, 2]', '1: [:b, 5]', '2: [:c, 7]', '3: [:d, 8]'])
    end

    it 'returns the same result as each_with_index method to string without block' do
      expect { str.my_each_with_index }.to raise_error(NoMethodError)
    end

    it 'returns the same result as each_with_index method to num_array without block' do
      expect(num_array.my_each_with_index).to be_a(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns the same result as select method to num_array' do
      test_array = []
      num_array.my_select { |i| test_array << i.even? }
      expect(test_array).to eql([false, true, false, false, false, true])
    end

    it 'returns the same result as select method to str_array' do
      test_array = []
      str_array.my_select { |item| test_array << item }
      expect(test_array).to eql(%w[m i n t])
    end

    it 'returns the same result as select method to range' do
      test_array = []
      range.my_select { |i| test_array << i.even? }
      expect(test_array).to eql([false, true, false, true, false])
    end

    it 'returns the same result as select method to hash' do
      test_array = []
      hash.my_select { |_key, value| test_array << (value < 3) }
      expect(test_array).to eql([true, false, false, false])
    end

    it 'returns the same result as select method to string without block' do
      expect { str.my_select }.to raise_error(NoMethodError)
    end

    it 'returns the same result as select method to num_array without block' do
      expect(num_array.my_select).to be_a(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns the same result as all? method to num_array' do
      result = num_array.my_all?(&:even?)
      expect(result).to eql(false)
    end

    it 'returns the same result as all? method to str_array' do
      result = str_array.my_all? { |item| item.is_a?(String) }
      expect(result).to eql(true)
    end

    it 'returns the same result as all? method to range' do
      result = range.my_all?(&:even?)
      expect(result).to eql(false)
    end

    it 'returns the same result as all? method to hash' do
      result = hash.my_all? { |_key, value| value < 3 }
      expect(result).to eql(false)
    end

    it 'returns the same result as all? method to string without block' do
      expect { str.my_all? }.to raise_error(NoMethodError)
    end

    it 'returns the same result as all? method to empty_array without block' do
      expect(empty_array.my_all?).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns the same result as any? method to num_array' do
      result = num_array.my_any?(&:even?)
      expect(result).to eql(true)
    end

    it 'returns the same result as any? method to str_array' do
      result = str_array.my_any? { |item| item.is_a?(String) }
      expect(result).to eql(true)
    end

    it 'returns the same result as any? method to range' do
      result = range.my_any?(&:even?)
      expect(result).to eql(true)
    end

    it 'returns the same result as any? method to hash' do
      result = hash.my_any? { |_key, value| value < 3 }
      expect(result).to eql(true)
    end

    it 'returns the same result as any? method to string without block' do
      expect { str.my_any? }.to raise_error(NoMethodError)
    end

    it 'returns the same result as any? method to empty_array without block' do
      expect(empty_array.my_any?).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'returns the same result as none? method to num_array' do
      result = num_array.my_none?(&:even?)
      expect(result).to eql(false)
    end

    it 'returns the same result as none? method to str_array' do
      result = str_array.my_none? { |item| item.is_a?(String) }
      expect(result).to eql(false)
    end

    it 'returns the same result as none? method to range' do
      result = range.my_none?(&:even?)
      expect(result).to eql(false)
    end

    it 'returns the same result as none? method to hash' do
      result = hash.my_none? { |_key, value| value < 3 }
      expect(result).to eql(false)
    end

    it 'returns the same result as none? method to string without block' do
      expect { str.my_none? }.to raise_error(NoMethodError)
    end

    it 'returns the same result as none? method to empty_array without block' do
      expect(empty_array.my_none?).to eql(true)
    end
  end

  describe '#my_count' do
    it 'returns the same result as count method to num_array without block' do
      result = num_array.my_count
      expect(result).to eql(6)
    end

    it 'returns the same result as count method to str_array without block' do
      result = str_array.my_count
      expect(result).to eql(4)
    end

    it 'returns the same result as count method to range without block' do
      result = range.my_count
      expect(result).to eql(5)
    end

    it 'returns the same result as count method to hash without block' do
      result = hash.my_count
      expect(result).to eql(4)
    end

    it 'returns the same result as count method to num_array with block' do
      result = num_array.my_count(&:even?)
      expect(result).to eql(2)
    end

    it 'returns the same result as count method to str_array with block' do
      result = str_array.my_count { |item| item.is_a?(String) }
      expect(result).to eql(4)
    end

    it 'returns the same result as count method to range with block' do
      result = range.my_count(&:even?)
      expect(result).to eql(2)
    end

    it 'returns the same result as count method to hash with block' do
      result = hash.my_count { |_key, value| value < 3 }
      expect(result).to eql(1)
    end

    it 'returns the same result as count method to num_array with item' do
      result = num_array.my_count(3)
      expect(result).to eql(1)
    end

    it 'returns the same result as count method to str_array with item' do
      result = str_array.my_count('m')
      expect(result).to eql(1)
    end

    it 'returns the same result as count method to range with item' do
      result = range.my_count(3)
      expect(result).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns the same result as map method to num_array' do
      result = num_array.my_map { |i| i * 2 }
      expect(result).to eql [2, 4, 6, 10, 14, 16]
    end

    it 'returns the same result as map method to str_array' do
      result = str_array.my_map { |item| item }
      expect(result).to eql(%w[m i n t])
    end

    it 'returns the same result as map method to hash' do
      result = hash.my_map { |key, value| "#{key} is #{value}" }
      expect(result).to eql(['a is 2', 'b is 5', 'c is 7', 'd is 8'])
    end

    it 'returns the same result as map method to range' do
      result = range.my_map { |i| i * 2 }
      expect(result).to eql [2, 4, 6, 8, 10]
    end

    it 'returns the same result as map method to num_array without block' do
      expect(num_array.my_map).to be_a(Enumerator)
    end

    it 'returns the same result as map method to string without block' do
      expect { str.my_map }.to raise_error(NoMethodError)
    end
  end

  describe '#my_inject' do
    it 'returns the same result as inject method to range with (initial, symbol)' do
      result = range.my_inject(3, :*)
      expect(result).to eql(360)
    end

    it 'returns the same result as inject method to range with (symbol)' do
      result = range.my_inject(:*)
      expect(result).to eql(120)
    end

    it 'returns the same result as inject method to range with (initial) with block' do
      result = range.my_inject(5) { |accum, i| accum * i }
      expect(result).to eql(600)
    end

    it 'returns the same result as inject method to range with block' do
      result = range.my_inject { |accum, i| accum * i }
      expect(result).to eql(120)
    end

    it 'returns the same result as inject method to str_array with block' do
      result = str_array.my_inject { |accum, word| accum.size > word.size ? accum : word }
      expect(result).to eql('t')
    end

    it 'returns the same result as inject method to num_array without block and item' do
      expect { num_array.my_inject }.to raise_error(LocalJumpError)
    end

    it 'returns the same result as inject method to string without block and item' do
      expect { str.my_inject }.to raise_error(NoMethodError)
    end
  end

  describe '#multiply_els' do
    it 'returns the result from my_inject correctly when given num_array' do
      expect(multiply_els(num_array)).to eql(1680)
    end
  end
end
