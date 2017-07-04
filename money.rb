
class Money

  attr_accessor :amount, :currency

  def initialize amnt, curr
    @amount = amnt
    @currency = curr
  end

  def self.conversion_rates from_conv_rate, to_conv_rates
    @@base_currency = from_conv_rate
    @@convert_rates = to_conv_rates
  end


  def inspect
    return "#{amount} #{currency}"
  end

  def convert_to to_curr
    if currency == @@base_currency
      conv = (amount * @@convert_rates[to_curr]).round(2)
      puts "#{conv} #{currency}" 
    else puts "can't convert"
    end

    return self.class.new(conv, currency)
  end

  def +(other)
    if self.class == other.class
      sum = @amount + (other.amount * @@convert_rates[other.currency]).round(2) if currency == @@base_currency
      sum = @amount + other.amount if currency == other.currency
    end
    puts "#{sum} #{currency}"

    return self.class.new(sum, currency)
  end

  def -(other)
    if self.class == other.class 
      minus = @amount - (other.amount * @@convert_rates[other.currency]).round(2) if currency == @@base_currency
      minus = @amount - other.amount if currency == other.currency
    end
    puts "#{minus} #{currency}"
    return self.class.new(minus, currency)
  end

  def /(value)
    div = @amount / value
    puts "#{div} #{currency}"
    return self.class.new(div, currency)
  end

  def *(value)
    mult = @amount * value
    puts "#{mult} #{currency}"
    return self.class.new(mult, currency)
  end

  def ==(other)
    if self.class == other.class
      if currency == other.currency && amount == other.amount
        return true
      else
        return false
      end
    end
  end

def >(other)
    if self.class == other.class 
      if amount > other.amount && other.currency == currency
        return true
      else
        if currency == @@base_currency && amount > (other.amount * @@convert_rates[other.currency]).round(2)
          return true
          else
            return false
        end
      end
    end
  end

  def <(other)
    if self.class == other.class 
      if amount < other.amount && other.currency == currency
        return true
      else
        if currency == @@base_currency && amount < (other.amount * @@convert_rates[other.currency]).round(2)
          return true
          else
            return false
        end
      end
    end
  end

end

# Instantiate money objects:
 
fifty_eur = Money.new(50, 'EUR')
 
#Get amount and currency:
 
puts fifty_eur.amount   # => 50
puts fifty_eur.currency # => "EUR"
puts fifty_eur.inspect  # => "50.00 EUR"
 
# Convert to a different currency (should return a Money
# instance, not a String):
 Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047
})

fifty_eur.convert_to('USD') # => 55.50 USD

# Arithmetics:
twenty_dollars = Money.new(20, 'USD')
fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD

# Comparisons (also in different currencies):
 
puts twenty_dollars == Money.new(20, 'USD') # => true
puts twenty_dollars == Money.new(30, 'USD') # => false

fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true
 
puts twenty_dollars > Money.new(5, 'USD')   # => true
puts twenty_dollars < fifty_eur             # => true
