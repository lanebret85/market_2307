class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    vendors_selling_item = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |inventory_item|
        if inventory_item.name == item.name
          vendors_selling_item << vendor
        end
      end
    end
    vendors_selling_item
  end
end