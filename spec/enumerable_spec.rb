# spec/enumerable_spec.rb

require '../enumerable.rb'

describe Enumerable do
  let(:num_array) { [1, 2, 3, 5, 7, 8] }
  let(:empty_array) { [] }
  let(:str_array) { %w[c h o c o m i n t] }
  let(:range) { (1..10) }
  let(:hash) { { 'a': 2, 'b': 5, 'c': 7, 'd': 8 } }
  let(:str) { %(pineapple) }
  let(:block_for_num) { proc { |i| i * 2 } }
  let(:block_for_str) { proc { |item| item } }
  let(:block_for_hash) { proc { |key, value| "#{key} is #{value}" } }
  let(:bk_for_each_idx) { proc { |item, index| "#{index}: #{item}" } }
  let(:bk_condit_num) { proc { |i| i.even? } }
  let(:bk_condit_str) { proc { |item| item.is_a?(String) } }
  let(:bk_condit_hash) { proc { |_key, value| value < 3 } }
  let(:block_inject_num) { proc { |accum, i| accum * i } }
  let(:block_inject_str) { proc { |accum, word| accum.size > word.size ? accum : word } }

  describe '#my_each' do
    it 'returns the same result as each method to num_array' do
      expect(num_array.my_each(&block_for_num)).to eql(num_array.each(&block_for_num))
    end

    it 'returns the same result as each method to str_array' do
      expect(str_array.my_each(&block_for_str)).to eql(str_array.each(&block_for_str))
    end

    it 'returns the same result as each method to range' do
      expect(range.my_each(&block_for_num)).to eql(range.each(&block_for_num))
    end

    it 'returns the same result as each method to hash' do
      expect(hash.my_each(&block_for_hash)).to eql(hash.each(&block_for_hash))
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
      expect(num_array.my_each_with_index(&bk_for_each_idx)).to eql(num_array.each_with_index(&bk_for_each_idx))
    end

    it 'returns the same result as each_with_index method to str_array' do
      expect(str_array.my_each_with_index(&bk_for_each_idx)).to eql(str_array.each_with_index(&bk_for_each_idx))
    end

    it 'returns the same result as each_with_index method to range' do
      expect(range.my_each_with_index(&bk_for_each_idx)).to eql(range.each_with_index(&bk_for_each_idx))
    end

    it 'returns the same result as each_with_index method to hash' do
      expect(hash.my_each_with_index(&bk_for_each_idx)).to eql(hash.each_with_index(&bk_for_each_idx))
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
      expect(num_array.my_select(&bk_condit_num)).to eql(num_array.select(&bk_condit_num))
    end

    it 'returns the same result as select method to str_array' do
      expect(str_array.my_select(&bk_condit_str)).to eql(str_array.select(&bk_condit_str))
    end

    it 'returns the same result as select method to range' do
      expect(range.my_select(&bk_condit_num)).to eql(range.select(&bk_condit_num))
    end

    it 'returns the same result as select method to hash' do
      expect(hash.my_select(&bk_condit_hash)).to eql(hash.select(&bk_condit_hash))
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
      expect(num_array.my_all?(&bk_condit_num)).to eql(num_array.all?(&bk_condit_num))
    end

    it 'returns the same result as all? method to str_array' do
      expect(str_array.my_all?(&bk_condit_str)).to eql(str_array.all?(&bk_condit_str))
    end

    it 'returns the same result as all? method to range' do
      expect(range.my_all?(&bk_condit_num)).to eql(range.all?(&bk_condit_num))
    end

    it 'returns the same result as all? method to hash' do
      expect(hash.my_all?(&bk_condit_hash)).to eql(hash.all?(&bk_condit_hash))
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
      expect(num_array.my_any?(&bk_condit_num)).to eql(num_array.any?(&bk_condit_num))
    end

    it 'returns the same result as any? method to str_array' do
      expect(str_array.my_any?(&bk_condit_str)).to eql(str_array.any?(&bk_condit_str))
    end

    it 'returns the same result as any? method to range' do
      expect(range.my_any?(&bk_condit_num)).to eql(range.any?(&bk_condit_num))
    end

    it 'returns the same result as any? method to hash' do
      expect(hash.my_any?(&bk_condit_hash)).to eql(hash.any?(&bk_condit_hash))
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
      expect(num_array.my_none?(&bk_condit_num)).to eql(num_array.none?(&bk_condit_num))
    end

    it 'returns the same result as none? method to str_array' do
      expect(str_array.my_none?(&bk_condit_str)).to eql(str_array.none?(&bk_condit_str))
    end

    it 'returns the same result as none? method to range' do
      expect(range.my_none?(&bk_condit_num)).to eql(range.none?(&bk_condit_num))
    end

    it 'returns the same result as none? method to hash' do
      expect(hash.my_none?(&bk_condit_hash)).to eql(hash.none?(&bk_condit_hash))
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
      expect(num_array.my_count).to eql(num_array.count)
    end

    it 'returns the same result as count method to str_array without block' do
      expect(str_array.my_count).to eql(str_array.count)
    end

    it 'returns the same result as count method to range without block' do
      expect(range.my_count).to eql(range.count)
    end

    it 'returns the same result as count method to hash without block' do
      expect(hash.my_count).to eql(hash.count)
    end

    it 'returns the same result as count method to num_array with block' do
      expect(num_array.my_count(&bk_condit_num)).to eql(num_array.count(&bk_condit_num))
    end

    it 'returns the same result as count method to str_array with block' do
      expect(str_array.my_count(&bk_condit_str)).to eql(str_array.count(&bk_condit_str))
    end

    it 'returns the same result as count method to range with block' do
      expect(range.my_count(&bk_condit_num)).to eql(range.count(&bk_condit_num))
    end

    it 'returns the same result as count method to hash with block' do
      expect(hash.my_count(&bk_condit_hash)).to eql(hash.count(&bk_condit_hash))
    end

    it 'returns the same result as count method to num_array with item' do
      expect(num_array.my_count(3)).to eql(num_array.count(3))
    end

    it 'returns the same result as count method to str_array with item' do
      expect(str_array.my_count('a')).to eql(str_array.count('a'))
    end

    it 'returns the same result as count method to range with item' do
      expect(range.my_count(3)).to eql(range.count(3))
    end
  end

  describe '#my_map' do
    it 'returns the same result as map method to num_array' do
      expect(num_array.my_map(&bk_condit_num)).to eql(num_array.map(&bk_condit_num))
    end

    it 'returns the same result as map method to str_array' do
      expect(str_array.my_map(&bk_condit_str)).to eql(str_array.map(&bk_condit_str))
    end

    it 'returns the same result as map method to hash' do
      expect(hash.my_map(&bk_condit_hash)).to eql(hash.map(&bk_condit_hash))
    end

    it 'returns the same result as map method to range' do
      expect(range.my_map(&bk_condit_num)).to eql(range.map(&bk_condit_num))
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
      expect(range.my_inject(3, :*)).to eql(range.inject(3, :*))
    end

    it 'returns the same result as inject method to range with (symbol)' do
      expect(range.my_inject(:*)).to eql(range.inject(:*))
    end

    it 'returns the same result as inject method to range with (initial) with block' do
      expect(range.my_inject(5, &block_inject_num)).to eql(range.inject(5, &block_inject_num))
    end

    it 'returns the same result as inject method to range with block' do
      expect(range.my_inject(&block_inject_num)).to eql(range.inject(&block_inject_num))
    end

    it 'returns the same result as inject method to str_array with block' do
      expect(str_array.my_inject(&block_inject_str)).to eql(str_array.inject(&block_inject_str))
    end

    it 'returns the same result as inject method to str_array with block' do
      expect(str_array.my_inject(&block_inject_str)).to eql(str_array.inject(&block_inject_str))
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
