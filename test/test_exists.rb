require File.expand_path('../abstract_unit', __FILE__)

class TestExists < ActiveSupport::TestCase
  fixtures :articles, :capitols, :departments, :dorms
  
  def test_id
    assert(Dorm.exists?(1))
    refute(Dorm.exists?(-1))
  end

  def test_array
    assert(Article.exists?(['name = ?', 'Article One']))
    assert(!Article.exists?(['name = ?', 'Article -1']))
  end

  def test_hash
    assert(Article.exists?('name' => 'Article One'))
    assert(!Article.exists?('name' => 'Article -1'))
  end

  def test_cpk_id
    assert(Department.exists?(CompositePrimaryKeys::CompositeKeys.new([1,1])))
    assert(!Department.exists?(CompositePrimaryKeys::CompositeKeys.new([1,-1])))
  end

  def test_cpk_array_id
    assert(Department.exists?([1,1]))
    assert(!Department.exists?([1,-1]))
  end

  def test_cpk_array_condition
    assert(Department.exists?(['id = ? and location_id = ?', 1, 1]))
    assert(!Department.exists?(['id = ? and location_id = ?', 1, -1]))
  end

  def test_cpk_array_string_id
    assert(Capitol.exists?(['The Netherlands', 'Amsterdam']))
    assert(!Capitol.exists?(['The Netherlands', 'Paris']))
  end
end