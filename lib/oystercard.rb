class Oystercard

  attr_accessor :balance, :in_use, :entry_station
 
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @in_use = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "You cannot go beyond the limit of £#{LIMIT}." if amount+balance > LIMIT
    self.balance += amount
  end

  def touch_in(station)
    raise "You do not have sufficient funds to make this journey" if balance < MINIMUM
    self.in_use = true
    @entry_station = station
  end

  def touch_out
    self.in_use = false
    self.deduct(1)
  end

  def in_journey?
    entry_station == nil ? false : true
    self.in_use #? true : false
  end

  private
  def deduct(amount)
    self.balance -= amount
  end

end