require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/market'
require 'pry'

class MarketTest < Minitest::Test
  def setup
    @m = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3 = Vendor.new("Palisade Peach Shack")
    @vendor_3.stock("Peaches", 65)
  end

  def test_it_exists
    assert_instance_of Market, @m
  end

  def test_it_has_a_name
    assert_equal "South Pearl Street Farmers Market", @m.name
  end

  def test_it_starts_with_no_vendors_in_array
    assert_equal [], @m.vendors
  end

  def test_it_can_add_vendors
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)

    assert_equal [@vendor_1, @vendor_2, @vendor_3], @m.vendors
  end

  def test_it_returns_all_vendor_names
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)

    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, @m.vendor_names
  end

  def test_it_knows_vendors_that_sell_item
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)

    assert_equal [@vendor_1, @vendor_3], @m.vendors_that_sell("Peaches")
    assert_equal [@vendor_2], @m.vendors_that_sell("Banana Nice Cream")
  end

  def test_it_sorts_all_vendor_items
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)

    expected = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    assert_equal expected, @m.sorted_item_list
  end

  def test_it_knows_its_total_inventory
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)

    expected = ({"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25})
    assert_equal expected, @m.total_inventory
  end

  def test_it_can_sell_item_if_item_in_stock_for_a_vendor
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)

    refute market.sell("Peaches", 200)
    refute market.sell("Onions", 1)
    assert market.sell("Banana Nice Cream", 5)
  end

  def test_when_selling_items_it_reduces_vendor_stock
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)
    market.sell("Banana Nice Cream", 5)

    assert_equal 45, @vendor_2.check_stock("Banana Nice Cream")
  end

  def test_its_vendors_sell_in_the_order_they_were_added_to_market
    @m.add_vendor(@vendor_1)
    @m.add_vendor(@vendor_2)
    @m.add_vendor(@vendor_3)
    market.sell("Peaches", 40)

    assert_equal 0, @vendor_1.check_stock("Peaches")
    assert_equal 60, @endor_3.check_stock("Peaches")
  end

end
