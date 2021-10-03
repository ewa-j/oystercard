require "journey_log"
require "journey"

describe JourneyLog do
  let(:journey) { instance_double Journey, start: "Victoria", finish: "Victoria" }
  subject { described_class.new(journey) }
  let(:entry_station) { "Victoria" }
  let(:exit_station) { "Victoria" }

  it "starts new journey with an entry station" do
    expect(journey.start(entry_station)).to eq "Victoria"
    allow(subject).to receive(:start) { entry_station }
    #journey.start("Victoria")
    expect(subject.start).to eq entry_station
  end

  it "finished a journey with an exit station" do
    expect(journey.finish(exit_station)).to eq "Victoria"
    allow(subject).to receive(:finish) { exit_station }
    #journey.start("Victoria")
    expect(subject.finish).to eq exit_station
  end

  it "returns the empty list of journeys by default" do
    expect(subject.journeys).to eq []
  end
end
