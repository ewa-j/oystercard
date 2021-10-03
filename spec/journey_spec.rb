require "./lib/journey"

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it "starts a journey and returns entry station" do
    expect(subject.start(entry_station)).to eq entry_station
  end

  it "starts a journey and returns entry station" do
    expect(subject.finish(exit_station)).to eq exit_station
  end

  it "returns minimum fare if the journey is complete" do
    allow(subject).to receive(:is_complete?) { true }
    expect(subject.fare).to eq Journey::MINIMUM_FARE
  end

  it "returns penalty fare if the journey is not complete" do
    allow(subject).to receive(:is_complete?) { false }
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
end
