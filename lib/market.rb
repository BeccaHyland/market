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

  # def sorted_item_list
  #   #iterate over each vendor's inventory, shovel into list
  #   sorted = []
  #   @vendors.each do |vendor|
  #     inventory = vendor.inventory
  #     inventory.each do |item, amount|
  #       sorted[]
  #   end
  # end
end
