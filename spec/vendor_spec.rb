require "./lib/vendor"
require "./lib/item"

RSpec.describe Vendor do
  let(:vendor) { Vendor.new("Rocky Mountain Fresh") }
  let(:item1) { Item.new({name: "Peach", price: "$0.75"}) }
  let(:item2) { Item.new({name: "Tomato", price: "$0.50"}) }

  describe "initialize" do
    it "exists" do
      expect(vendor).to be_a(Vendor)
    end

    it "has readable attributes" do
      expect(vendor.name).to eq("Rocky Mountain Fresh")
    end
  end

  describe "#stock and #check_stock" do
    it "returns an empty hash for the inventory to start" do
      expect(vendor.inventory).to eq({})
    end

    it "returns 0 for an item that is not in stock" do
      expect(vendor.check_stock(item1)).to eq(0)
    end

    it "can check the inventory to see how much of what items is in stock and return the inventory on all items" do
      vendor.stock(item1, 30)

      expect(vendor.inventory).to eq({item1 => 30})

      vendor.stock(item1, 25)
      vendor.stock(item2, 12)

      expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
    end

    it "can add more stock of an item, check the inventory to see how much of an item is in stock, and return the amount of that item" do
      vendor.stock(item1, 30)

      expect(vendor.check_stock(item1)).to eq(30)

      vendor.stock(item1, 25)

      expect(vendor.check_stock(item1)).to eq(55)
    end
  end
end