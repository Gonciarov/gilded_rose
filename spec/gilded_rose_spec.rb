require 'rspec'
require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq("foo")
    end

    it 'Once the sell by date has passed, Quality degrades twice as fast' do
      items = [Item.new("bread", 0, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(28)
    end

    it 'The Quality of an item is never negative' do
      items = [Item.new("bread", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end


    it "reduces Quality and Sell In value by 1 (if no exceptions)" do
      items = [Item.new("bread", 7, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(6)
      expect(items[0].quality).to eq(29)
    end

    it "increases Quality value for Aged Brie" do
      items = [Item.new("Aged Brie", 7, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(31)
    end

    it "has maximum Quality value" do
      items = [Item.new("Aged Brie", 7, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(50)
    end
    it "does not reduce Sell In or Quality value for Sulfur" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 7, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(7)
      expect(items[0].quality).to eq(40)
    end
    it "increases Quality value for passes when 11 days or more" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(11)
      expect(items[0].quality).to eq(41)
    end
    it "increases Quality value for passes by 2 when 10 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(8)
      expect(items[0].quality).to eq(42)
    end
    it "increases Quality value for passes by 3 when 5 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(43)
    end

    it "Quality value for passes is 0 after concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end

    end

end
