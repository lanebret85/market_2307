class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def check_stock(item)
    @inventory[item]
  end

  def potential_revenue
    inventory_value = 0
    @inventory.each do |item, quantity|
      inventory_value += (item.price * quantity)
    end
    inventory_value
  end
end