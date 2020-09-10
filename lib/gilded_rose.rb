class GildedRose

  def initialize(items)
    @items = items
  end

  def aged_brie_update_quality(item)
    item.sell_in -= 1
    if item.quality < 50
      item.quality += 1
    end
  end

  def backstage_passes_update_quality(item)
    item.sell_in -= 1
    if item.sell_in < 1
      item.quality = 0
    elsif item.sell_in < 6
      item.quality += 3
    elsif item.sell_in < 11
      item.quality += 2
    else
      item.quality += 1
    end
  end

  def sulfuras_update_quality(item)
    #update nothing
  end

  def conjured_update_quality(item)
    item.sell_in -= 1
    if item.sell_in > 0
        item.quality -= 2 if item.quality > 1
    elsif item.sell_in < 1
      item.quality -= 4 if item.quality > 3
    end
  end

  def default_update_quality(item)
    item.sell_in -= 1
    if item.sell_in > 0
        item.quality -= 1 if item.quality > 0
    elsif item.sell_in < 1
      item.quality -= 2 if item.quality > 1
    end
  end


  def update_quality()
    @items.each do |item|

      if item.name == "Aged Brie"
        aged_brie_update_quality(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        backstage_passes_update_quality(item)
      elsif item.name == "Sulfuras, Hand of Ragnaros"
        sulfuras_update_quality(item)
      elsif item.name == "Conjured"
        conjured_update_quality(item)
      else
        default_update_quality(item)
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
