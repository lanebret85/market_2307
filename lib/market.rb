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

  def total_inventory
    market_inventory = Hash.new(0)
    items_sold = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |inventory_item|
        items_sold << inventory_item
      end
    end
    
    unique_items_sold = items_sold.uniq
    inventory_array = []
    
    unique_items_sold.each do |item|
      item_quantity = 0
      @vendors.each do |vendor|
        item_quantity += vendor.check_stock(item)
      end
      inventory_array << item_quantity
    end
    
    counter = 0
    unique_items_sold.each do |item|
      market_inventory[item] = {:quantity => inventory_array[counter], :vendors => vendors_that_sell(item)}
      counter += 1
    end

    market_inventory
  end

  def overstocked_items
    overstock = []
    total_inventory.each do |item, item_spec|
      if item_spec[:quantity] > 50 && item_spec[:vendors].count > 1
        overstock << item
      end
    end
    overstock
  end
end