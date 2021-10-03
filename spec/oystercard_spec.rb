require 'oystercard'
require 'journey'

describe Oystercard do

  let(:entry_station) { double Journey, :entry_station }
  let(:exit_station) { double Journey, :exit_station }
  let(:journey) { Journey.new }
  
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

  it "deducts penalty fare if not touched in" do
    subject.balance = 10
    expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by(-6)
  end

  it "raises an error if the balance is less than £1 on touch in" do
    subject.balance = 0
    expect { subject.touch_in(:entry_station) }.to raise_error "You do not have sufficient funds to make this journey"
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