require "./lib/vendor"
require "./lib/item"

RSpec.describe Vendor do
  let(:vendor1) { Vendor.new("Rocky Mountain Fresh") }
  let(:vendor2) { Vendor.new("Ba-Nom-a-Nom") }
  let(:vendor3) { Vendor.new("Palisade Peach Shack") }
  let(:item1) { Item.new({name: "Peach", price: "$0.75"}) }
  let(:item2) { Item.new({name: "Tomato", price: "$0.50"}) }
  let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
  let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }

  describe "initialize" do
    it "exists" do
      expect(vendor1).to be_a(Vendor)
    end

    it "has readable attributes" do
      expect(vendor1.name).to eq("Rocky Mountain Fresh")
    end
  end

  describe "#stock and #check_stock" do
    it "returns an empty hash for the inventory to start" do
      expect(vendor1.inventory).to eq({})
    end

    it "returns 0 for an item that is not in stock" do
      expect(vendor1.check_stock(item1)).to eq(0)
    end

    it "can check the inventory to see how much of what items is in stock and return the inventory on all items" do
      vendor1.stock(item1, 30)

      expect(vendor1.inventory).to eq({item1 => 30})

      vendor1.stock(item1, 25)
      vendor1.stock(item2, 12)

      expect(vendor1.inventory).to eq({item1 => 55, item2 => 12})
    end

    it "can add more stock of an item, check the inventory to see how much of an item is in stock, and return the amount of that item" do
      vendor1.stock(item1, 30)

      expect(vendor1.check_stock(item1)).to eq(30)

      vendor1.stock(item1, 25)

      expect(vendor1.check_stock(item1)).to eq(55)
    end
  end

  describe "#potential_revenue" do
    it "can multiply price of each item by the stock of that item and add total prices together to get potential revenue of a vendor" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)

      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)

      vendor3.stock(item1, 65)

      expect(vendor1.potential_revenue).to eq(29.75)
      expect(vendor2.potential_revenue).to eq(345.00)
      expect(vendor3.potential_revenue).to eq(48.75)
    end
  end
end