class Item
  attr_reader :name,
              :price

  def initialize(item_details)
    @name = item_details[:name]
    @price = item_details[:price][1..-1].to_f
  end
end