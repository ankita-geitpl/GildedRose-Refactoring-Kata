class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    # Iterate through each item in the inventory and update its quality, sell_in, and handle expiration
    @items.each do |item|
      update_item_quality(item)
      update_sell_in(item)
      handle_expired_item(item)
    end
  end

  private

 # Update the quality of an item based on its type
  def update_item_quality(item)
    case item.name
    when "Aged Brie"
      increase_quality(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      update_backstage_pass_quality(item)
    when "Sulfuras, Hand of Ragnaros"
      # Legendary item, no change in quality or sell_in
    when "Conjured Mana Cake"
      decrease_quality(item, 2)
    else
      decrease_quality(item)
    end
  end

  # Update the quality of Backstage passes based on its sell_in value
  def update_backstage_pass_quality(item)
    if item.sell_in > 10
      increase_quality(item)
    elsif item.sell_in > 5
      increase_quality(item, 2)
    elsif item.sell_in > 0
      increase_quality(item, 3)
    else
      item.quality = MIN_QUALITY
    end
  end

  # Update the sell_in value of an item, except for Sulfuras
  def update_sell_in(item)
    item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
  end


  # Handle the expiration of an item by adjusting its quality
  def handle_expired_item(item)
    return if item.sell_in >= 0

    case item.name
    when "Aged Brie"
      increase_quality(item, 0)
    when "Backstage passes to a TAFKAL80ETC concert"
      item.quality = MIN_QUALITY
    when "Sulfuras, Hand of Ragnaros"
      # Legendary item, no change in quality or sell_in
    when "Conjured Mana Cake"
      decrease_quality(item, 2)
    else
      decrease_quality(item)
    end
  end

  # Increase the quality of an item, with an optional amount parameter
  def increase_quality(item, amount = 1)
    item.quality = [item.quality + amount, MAX_QUALITY].min
  end

  # Decrease the quality of an item, with an optional amount parameter
  def decrease_quality(item, amount = 1)
    item.quality = [item.quality - amount, MIN_QUALITY].max
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
