# Approach

### Session 01

**3 Jul 2019 14:04 - 3 Jul 2019 14:32**

**To do**
- Clone the project
- Write up spec
- Read existing code, make notes on what it does
- Refactor notes into model (CRC, flow)
- Make tests on existing code
- Refactor code to new model
- Ensure all tests are passing

**Done**
- Clone the project
- Write up spec
- Reading current code: Why three test files? texttest_fixture is for a different testing approach that I'm not using, so I'll ignore it for now. Maybe it will be useful after refactoring.
- Rspec not showing examples even though there are two test files. Initialising rspec to get a spec helper.
- Unsure of the testing file structure, so moved gilded_rose_spec into the spec file and required gilded_rose.rb in the spec_helper
- Changed the require_relative in the spec file, deleted the other one
- Why does the test expect "fixme"? No results by searching in gilded_rose.rb.
- The test is supposed to check update_quality does not change the name, so the expected string should be the same as the name argument when instancing the item. Changed the expect to "foo" and now the test passes.
- Commit

### Session 02

**3 Jul 2019 14:35 - 3 Jul 2019 15:00**

**To do**
- Read existing code, make notes on what it does
- Make tests on existing code
- Refactor notes into model (CRC, flow)
- Refactor code to new model
- Ensure all tests are passing

**Done**
- Tested in IRB to see behaviour:
    - Tried to require the gilded_rose.rb but won't load
    - Was requiring it wrong!
    - Removed requirement from spec helper because it was duplicated and couldn't be removed from gilded_rose_spec.rb
    - Recreated the test in IRB:
        ```
        > items = [Item.new("gruyer", 0, 0)]
        => [#<Item:0x00007fb327880ba8 @name="gruyer", @sell_in=0, @quality=0>]

        > GildedRose.new(items).update_quality()
        => [#<Item:0x00007fb327880ba8 @name="gruyer", @sell_in=-1, @quality=0>]
        ```
    From this I can see that an update will affect an item with a random name by decreasing its sell_in by 1.

    - Tested for item quality change in IRB:
        ```
        items = [Item.new("manchego", 10, 5)]
        2.6.0 :036 > GildedRose.new(items).update_quality()
        => [#<Item:0x00007fb327970220 @name="manchego", @sell_in=9, @quality=4>] 
        2.6.0 :037 > GildedRose.new(items).update_quality()
        => [#<Item:0x00007fb327970220 @name="manchego", @sell_in=8, @quality=3>] 
        2.6.0 :038 > GildedRose.new(items).update_quality()
        => [#<Item:0x00007fb327970220 @name="manchego", @sell_in=7, @quality=2>] 
        2.6.0 :039 > GildedRose.new(items).update_quality()
        => [#<Item:0x00007fb327970220 @name="manchego", @sell_in=6, @quality=1>] 
        2.6.0 :040 > GildedRose.new(items).update_quality()
        => [#<Item:0x00007fb327970220 @name="manchego", @sell_in=5, @quality=0>] 
        2.6.0 :041 > GildedRose.new(items).update_quality()
        => [#<Item:0x00007fb327970220 @name="manchego", @sell_in=4, @quality=0>] 
        ```
    From this I can see that item quality decreases by one but won't go past 0.
- Changed the priority of to do items

### Session 03

**3 Jul 2019 15:13 - 3 Jul 2019 16:8**

**To do**
- Read existing code, make notes on what it does
- Make tests on existing code
- Refactor notes into model (CRC, flow)
- Refactor code to new model
- Ensure all tests are passing

**Done**
- Re-read requirements file
- Added Sulfuras quality to spec
- Changed name test to check behaviour not state
- Wrote a passing test that checks update decreases sell_in and quality
- Wrote a passing test that checks item quality cannot decrease past 0
- Tested in IRB for quality decreasing twice as fast after reaching sell-by date:
    ```
    > items = [Item.new("gruyer", 0, 5)]
    2.6.0 :021 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb327923d30 @name="gruyer", @sell_in=-1, @quality=3>] 
    2.6.0 :022 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb327923d30 @name="gruyer", @sell_in=-2, @quality=1>] 
    2.6.0 :023 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb327923d30 @name="gruyer", @sell_in=-3, @quality=0>] 
    ```
- Wrote passing test for sell_in being decreased by 1
- Wrote passing test for quality decreasing by 2 if sell by has passed
- Asked colleagues about testing the code we aren't allowed to change, concluded by saying it is necessary for 100% test coverage and shouldn't be hard
- Researched matchers
- Asked mentor to confirm testing for state vs behaviour and feature vs unit
- Split tests into feature and unit files

### Session 04

**3 Jul 2019 16:27 - 3 Jul 2019 16:48**

**To do**
- Make tests on existing code
- Read existing code, make notes on what it does
- Refactor notes into model (CRC, flow)
- Refactor code to new model
- Ensure all tests are passing

**Done**
- Changed priority of to do list
- Tested Aged Brie behaviour in IRB:
    ```
    > items = [Item.new("Aged Brie", 10, 5)]
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=10, @quality=5>] 
    2.6.0 :002 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=9, @quality=6>] 
    2.6.0 :003 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=8, @quality=7>] 
    2.6.0 :004 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=7, @quality=8>] 
    2.6.0 :005 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=6, @quality=9>] 
    2.6.0 :006 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=5, @quality=10>] 
    2.6.0 :007 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=4, @quality=11>] 
    2.6.0 :008 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=3, @quality=12>] 
    2.6.0 :009 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=2, @quality=13>] 
    2.6.0 :010 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=1, @quality=14>] 
    2.6.0 :011 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=0, @quality=15>] 
    2.6.0 :012 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=-1, @quality=17>] 
    2.6.0 :013 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=-2, @quality=19>] 
    ```
    This showed that Aged Brie does go up in quality as it gets older.
- Wrote a passing test for Aged Brie
- Tested the quality limit in IRB:
    ```
    GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=-17, @quality=49>] 
    2.6.0 :029 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=-18, @quality=50>] 
    2.6.0 :030 > GildedRose.new(items).update_quality()
    => [#<Item:0x00007fb93513f8d0 @name="Aged Brie", @sell_in=-19, @quality=50>] 
    ```
    This showed that it cannot increase past 50.
- Wrote a passing test for quality limit