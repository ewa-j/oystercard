class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def is_complete?
    !!@entry_station and !!@exit_station
  end

  def fare
    is_complete? ? MINIMUM_FARE : PENALTY_FARE
  end
end
