class GildedRose

  def initialize(items)
    @items = items
  end

  def update_sell_in_and_quality(item, sell_in_counter, quality_counter)
    item.sell_in -= sell_in_counter
    quality_counter = quality_counter * 2 if item.sell_in < 1
    if item.quality >= quality_counter
      item.quality -= quality_counter
    else
      item.quality = 0
    end
    item.quality = 50 if item.quality > 50
  end

  def update()
    @items.each do |item|
      if item.name == "Aged Brie"
        update_sell_in_and_quality(item, 1, -1)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in > 10
          update_sell_in_and_quality(item, 1, -1)
        elsif item.sell_in > 5
          update_sell_in_and_quality(item, 1, -2)
        elsif item.sell_in > 0
          update_sell_in_and_quality(item, 1, -3)
        else
          update_sell_in_and_quality(item, 1, item.quality)
        end
      elsif item.name == "Sulfuras, Hand of Ragnaros"
        update_sell_in_and_quality(item, 0, 0)
      elsif item.name == "Conjured"
        update_sell_in_and_quality(item, 1, 2)
      else
        update_sell_in_and_quality(item, 1, 1)
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
