class Market
  attr_reader   :name

  attr_accessor :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.has_key?(item)
    end
  end

  def sorted_item_list
    items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        items << item
      end
    end
    items.uniq.sort
  end

  def total_inventory
    total = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        total[item] += amount
      end
    end
    total
  end

  def sell(item, amount)
    unless !sellable?(item, amount)
      amount_to_sell = amount
      until amount_to_sell == 0
        vendor = get_vendor_with_item(item)
        if vendor.check_stock(item) < amount
          amount_to_sell -= vendor.inventory[item]
          vendor.inventory[item] = 0
        else
          vendor.inventory[item] -= amount_to_sell
          amount_to_sell = 0
        end
      end
    end
    sellable?(item, amount)
  end

  def get_vendor_with_item(item)
    @vendors.find do |vendor|
      vendor.check_stock(item) != 0
    end
  end

  def sellable?(item, amount)
    total_inventory[item] >= amount
  end

end
