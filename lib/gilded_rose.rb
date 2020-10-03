class GildedRose

  SELL_IN_COUNTER = 1
  AGED_BRIE_QUALITY_COUNTER = -1
  PASSES_QUALITY_COUNTER_NORMAL = -1
  PASSES_QUALITY_COUNTER_WARM = -2
  PASSES_QUALITY_COUNTER_HOT = -3
  PASSES_NORMAL_DAYS = (11..)
  PASSES_WARM_DAYS = (6..10)
  PASSES_HOT_DAYS = (1..5)
  PASSES_EXPIRATION_DAY = 0
  SULFURAS_QUALITY_COUNTER = 0
  CONJURED_QUALITY_COUNTER = 2
  DEFAULT_QUALITY_COUNTER = 1

  def initialize(items)
    @items = items
    @sell_in_counter = SELL_IN_COUNTER
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
          quality_counter = AGED_BRIE_QUALITY_COUNTER
        when "Backstage passes to a TAFKAL80ETC concert"
          quality_counter = PASSES_QUALITY_COUNTER_NORMAL if PASSES_NORMAL_DAYS.include?(item.sell_in)
          quality_counter = PASSES_QUALITY_COUNTER_WARM if PASSES_WARM_DAYS.include?(item.sell_in)
          quality_counter = PASSES_QUALITY_COUNTER_HOT if PASSES_HOT_DAYS.include?(item.sell_in)
          quality_counter = item.quality if item.sell_in <= PASSES_EXPIRATION_DAY
        when "Sulfuras, Hand of Ragnaros"
          quality_counter = SULFURAS_QUALITY_COUNTER
          @sell_in_counter = 0
        when "Conjured"
          quality_counter = CONJURED_QUALITY_COUNTER
        else
          quality_counter = DEFAULT_QUALITY_COUNTER
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
