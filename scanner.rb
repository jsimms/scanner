=begin

  Todo:
  1. Create a separate class for grocery items
  2. Terminal class creates grocery items, including bulk deals
  3. Create method that allows a string of items to be scanned all at once rather than individually
  4. Create order class? So the terminal can have some sort of history?
  5. Sinatra app & Rack/Rspec tests... 

=end

class Terminal

  def initialize
    @subtotal = 0
    @pricing = {}
    @scannedItems = {}
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
    finalCost = subtotal
    if @scannedItems.has_key?("A")
      aItemDiscount = (@scannedItems["A"] / 4)*1
      finalCost = finalCost - aItemDiscount
    end
    if @scannedItems.has_key?("C")
      cItemDiscount = (@scannedItems["C"] / 6)*1.5
      finalCost = finalCost - cItemDiscount
    end
    finalCost
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

#order.scan("C")
#order.scan("C")
#order.scan("C")
#order.scan("C")
#order.scan("C")
#order.scan("C")
#order.scan("C")

order.scan("A")
order.scan("B")
order.scan("C")
order.scan("D")

puts order.total
