class JourneyLog
  attr_reader :journey, :journeys, :entry_station, :exit_station

  def initialize(journey = Journey.new)
    @journey = journey
    @current_journey = {}
    @journeys = []
  end

  def start
    @journey.entry_station
    @current_journey[:start] = @journey.entry_station
  end

  def finish
    @journey.exit_station
    @current_journey[:exit] = @journey.exit_station
  end

  def journeys
    @journeys
  end

  private

  def current_journey
    @journeys << current_journey
    @current_journey
  end
end
