# Gilded rose

### Specification

**The current system** updates the inventory of an inn. The inn's goods degrade as they approach their sell-by date.

- All items have a SellIn value which denotes the number of days the innkeepers have to sell the item.
- All items have a Quality value which denotes how valuable it is.
- At the end of each day the system lowers both values of each item in stock.
- There are a few details/constraints to this system:
    - Once the sell by date has passed, Quality degrades twice as fast
    - The Quality of an item is never negative
    - **_"Aged Brie"_** actually increases in Quality the older it gets
    - The Quality of an item cannot increase past 50
    - **_"Sulfuras"_**, being a legendary item, never has to be sold and never decreases in Quality from 80
    - **_"Backstage passes"_**, like aged brie, increase in Quality as it's SellIn value approaches; Quality increases by 2 when there are 10 days left and by 3 when there are 5 days left, but quality drops to 0 when there are no days left

**The new feature** causes items flagged as 'conjured' to degrade in Quality twice as fast.

New code can be added and the UpdateQuality method can be changed, but the Item class and Items property cannot.

---


