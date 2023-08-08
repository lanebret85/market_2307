require "./lib/item"
require "./lib/vendor"
require "./lib/market"

RSpec.describe Market do
  let(:market) { Market.new("South Pearl Street Farmers Market") }

  describe "initialize" do
    it "exists" do
      expect(market).to be_a(Market)
    end

    it "has readable attributes" do
      expect(market.name).to eq("South Pearl Street Farmers Market")
    end
  end

  describe "#add_vendor" do
    it "returns an empty array of vendors to start" do
      expect(market.vendors).to eq([])
    end

    it "can add vendors to its list of vendors and return the list" do
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor3 = Vendor.new("Palisade Peach Shack")

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    end
  end

  describe "#vendor_names" do
    it "can return a list of vendor names as string elements" do
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor3 = Vendor.new("Palisade Peach Shack")

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe "#vendors_that_sell" do
    it "can return a list of vendors that sell a particular item" do
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor3 = Vendor.new("Palisade Peach Shack")

      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: "$0.50"})
      item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)

      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)

      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end
  end

  describe "#total_inventory" do
    it "can return the quantities of all items sold at the market and the vendors who sell those items" do
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor3 = Vendor.new("Palisade Peach Shack")

      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: "$0.50"})
      item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)

      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)

      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expected = {item1 => {:quantity => 100, :vendors => [vendor1, vendor3]},
                  item2 => {:quantity => 7, :vendors => [vendor1]},
                  item3 => {:quantity => 25, :vendors => [vendor2]},
                  item4 => {:quantity => 50, :vendors => [vendor2]}}

      expect(market.total_inventory).to eq(expected)
    end
  end
end