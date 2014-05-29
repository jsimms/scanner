# This is a top-level class that does the following: Sets the price of an item, scan an item, and return total

=begin

  Todo:
  1. Add in bulk pricing
  2. Confirm bulk pricing is working

=end

class Terminal

  def initialize
    @subtotal = 0
    @pricing = {}
    @volumeDeals = {}
    @scannedItems = {}
    # Volume discounts?
    puts "Register is up and running."
  end

  def set_pricing(item,cost)
    @pricing[item] = cost
  end

  def see_pricing
    if @pricing.empty?
      puts "No pricing data yet, boss."
    end
    @pricing.each { |key, value| puts "#{key} = $#{value}" }
  end

  def scan(item)
    if @scannedItems.has_key?(item)
      @scannedItems[item] += 1
    else
      @scannedItems[item] = 1
    end
    puts "#{item} scanned succesfully."
  end

  def see_scanned
    if @scannedItems.empty?
      puts "Nothing's been scanned yet, boss."
    else
      puts @scannedItems.inspect
    end
  end

  def total
    subtotal = @scannedItems.keys.inject(0) {|cost, key| cost + @pricing[key]*@scannedItems[key]}
    applyDiscounts(subtotal)
  end

  def applyDiscounts(subtotal)
    aItemDiscount = (@scannedItems["A"] / 4)*1
    cItemDiscount = (@scannedItems["C"] / 6)*1.5
    finalCost = subtotal - aItemDiscount - cItemDiscount
  end

end

order = Terminal.new

order.set_pricing("A", 2.00)
order.set_pricing("B", 12.00)
order.set_pricing("C", 1.25)
order.set_pricing("D", 0.15)
order.see_pricing


#order.scan("A")
#order.scan("B")
#order.scan("C")
#order.scan("D")
#order.scan("A")
#order.scan("B")
#order.scan("A")
#order.scan("A")


# Pickup with working on getting applyDiscounts to work when A isn't present. 
order.scan("C")
order.scan("C")
order.scan("C")
order.scan("C")
order.scan("C")
order.scan("C")
order.scan("C")

#order.scan("A")
#order.scan("B")
#order.scan("C")
#order.scan("D")

puts order.total
