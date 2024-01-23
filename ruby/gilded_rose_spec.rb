require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  it "does not change the name" do
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    expect(items[0].name).to eq "foo"
  end

  context 'when item is Conjured Mana Cake' do
      it 'decreases quality by 2 and sell_in by 1' do
        items = [Item.new('Conjured Mana Cake', 5, 10)]
        gilded_rose = GildedRose.new(items)

        gilded_rose.update_quality

        expect(items[0].quality).to eq(8)
        expect(items[0].sell_in).to eq(4)
      end

      it 'decreases quality by 4 and sell_in by 1 when sell_in is negative' do
        items = [Item.new('Conjured Mana Cake', -1, 10)]
        gilded_rose = GildedRose.new(items)

        gilded_rose.update_quality

        expect(items[0].quality).to eq(6)
        expect(items[0].sell_in).to eq(-2)
      end

      it 'does not decrease quality below 0' do
        items = [Item.new('Conjured Mana Cake', 5, 1)]
        gilded_rose = GildedRose.new(items)

        gilded_rose.update_quality

        expect(items[0].quality).to eq(0)
        expect(items[0].sell_in).to eq(4)
      end

      it 'does not decrease quality below 0 even when sell_in is negative' do
        items = [Item.new('Conjured Mana Cake', -1, 1)]
        gilded_rose = GildedRose.new(items)

        gilded_rose.update_quality

        expect(items[0].quality).to eq(0)
        expect(items[0].sell_in).to eq(-2)
      end
    end
end
