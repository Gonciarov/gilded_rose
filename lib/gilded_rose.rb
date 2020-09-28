class GildedRose

  def initialize(items)
    @items = items
    @sell_in_counter = 1
    @aged_brie_quality_counter = -1
    @passes_quality_counter_normal = -1
    @passes_quality_counter_warm = -2
    @passes_quality_counter_hot = -3
    @passes_normal_days = (11..)
    @passes_warm_days = (6..10)
    @passes_hot_days = (1..5)
    @passes_expiration_day = 0
    @sulfuras_quality_counter = 0
    @conjured_quality_counter = 2
    @default_quality_counter = 1
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
      case item.name
        when "Aged Brie"
          quality_counter = @aged_brie_quality_counter
        when "Backstage passes to a TAFKAL80ETC concert"
          quality_counter = @passes_quality_counter_normal if @passes_normal_days.include?(item.sell_in)
          quality_counter = @passes_quality_counter_warm if @passes_warm_days.include?(item.sell_in) 
          quality_counter = @passes_quality_counter_hot if @passes_hot_days.include?(item.sell_in)
          quality_counter = item.quality if item.sell_in <= @passes_expiration_day
        when "Sulfuras, Hand of Ragnaros"
          quality_counter = @sulfuras_quality_counter
          @sell_in_counter = 0
        when "Conjured"
          quality_counter = @conjured_quality_counter
        else
          quality_counter = @default_quality_counter
      end
      update_sell_in_and_quality(item, @sell_in_counter, quality_counter)
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
