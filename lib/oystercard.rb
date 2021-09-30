class Oystercard

  attr_accessor :balance, :journeys, :entry_station, :exit_station, :current_journey
 
  LIMIT = 90
  MINIMUM = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journeys = []
    @journey = journey
    @current_journey = nil
  end

  def top_up(amount)
    raise "You cannot go beyond the limit of £#{LIMIT}." if amount+balance > LIMIT
    self.balance += amount
  end

  def touch_in(entry_station)
    raise "You do not have sufficient funds to make this journey" if balance < MINIMUM
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(entry_station)
    self.deduct(1)
    add_journey
  end

  def in_journey?
    entry_station == nil ? false : true
  end

  def add_journey
    @current_journey = {entry: @journey.entry_station, exit: @journey.exit_station}
    @journeys << current_journey
    clear_journey
  end

  def clear_journey
    journey = Journey.new
  end

  private
  def deduct(amount)
    self.balance -= amount
  end

end