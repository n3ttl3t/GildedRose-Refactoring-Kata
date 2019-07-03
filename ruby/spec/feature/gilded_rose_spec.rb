require_relative "../../gilded_rose.rb"

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect{GildedRose.new(items).update_quality()}.not_to change{items[0].name}
    end

    it "decreases sell_in by 1" do
      items = [Item.new("foo", 10, 5)]
      expect{GildedRose.new(items).update_quality}.to change{items[0].sell_in}.by(-1)
    end
    
    it "decreases quality by 1 if sell_in is > 0" do
      items = [Item.new("foo", 10, 5)]
      expect{GildedRose.new(items).update_quality}.to change{items[0].quality}.by(-1)
    end

    it "decreases quality by 2 if sell_in is < 1" do
      items = [Item.new("foo", 0, 5)]
      expect{GildedRose.new(items).update_quality}.to change{items[0].quality}.by(-2)
    end

    it "cannot decrease quality past 0" do
      items = [Item.new("foo", 10, 1)]
      expect{GildedRose.new(items).update_quality}.to change{items[0].quality}.by(-1)
      expect{GildedRose.new(items).update_quality}.not_to change{items[0].quality}
    end

  end

end
