require 'oystercard'

describe Oystercard do

  let(:entry_station) { instance_double Oystercard, entry_station: "Kent House" }
  let(:exit_station) { instance_double Oystercard, exit_station: "Victoria" }
  
  it "has balance of 0 by default" do
    expect(subject.balance).to eq 0
  end 

  it "can top up" do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

  it "raises an error when topping up more than £90" do
    subject.balance = 70
    expect { subject.top_up(100) }.to raise_error "You cannot go beyond the limit of £#{Oystercard::LIMIT}."
  end

  it "reduces the balance" do
    subject.balance = 70
    # method to test private method in rspec
    subject.send(:deduct, 10)
    expect(subject.balance).to eq 60
  end

  it "returns true when the customer touches in" do
    subject.balance = 2
    subject.touch_in(:entry_station)
    expect(subject.in_use).to be_truthy
  end

  it "returns false when the customer touches out" do
    subject.touch_out(:exit_station)
    expect(subject.in_use).to be_falsy
  end

  it "deducts money for completed journey" do
    subject.balance = 5
    expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by(-1)
  end

  it "confirms when the customer is on a journey" do
    subject.balance = Oystercard::MINIMUM
    subject.touch_in(:entry_station)
    expect(subject.in_journey?).to be_truthy
  end

  it "confirms when the customer has finished their journey" do
    subject.touch_out(:exit_station)
    expect(subject.in_journey?).to be_falsy
  end

  it "raises an error if the balance is less than £1 on touch in" do
    subject.balance = 0
    expect { subject.touch_in(:entry_station) }.to raise_error "You do not have sufficient funds to make this journey"
  end

  it "returns touch in station" do
    subject.balance = 5
    subject.touch_in("Kent House")
    expect(subject.entry_station).to eq "Kent House"
  end

  it "returns exit station" do
    subject.touch_out("Victoria")
    expect(subject.exit_station).to eq "Victoria"
  end

  it "has an empty @journeys array by default" do
    expect(subject.journeys).to eq []
  end

  it "creates one journey after touch_in & touch_out" do
    subject.balance = 10
    subject.touch_in(:entry_station)
    subject.touch_out(:exit_station)
    expect(subject.journeys.length).to eq 1
  end
  
end