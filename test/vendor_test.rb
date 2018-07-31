require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @v = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @v
  end

  def test_it_has_a_name
    assert_equal "Rocky Mountain Fresh", @v.name
  end

  def test_it_starts_with_empty_inventory_hash
    assert_equal ({}), @v.inventory
  end

  def test_it_can_check_stock
    assert_equal 0, @v.check_stock("Peaches")
  end

  def test_it_can_stock
    @v.stock("Peaches", 30)
    assert_equal 30, @v.check_stock("Peaches")

    @v.stock("Peaches", 25)
    assert_equal 55, @v.check_stock("Peaches")
  end

  def test_it_stores_inventory
    @v.stock("Peaches", 30)
    @v.stock("Peaches", 25)
    @v.stock("Tomatoes", 12)
    assert_equal ({"Peaches"=>55, "Tomatoes"=>12}), @v.inventory
  end

end
