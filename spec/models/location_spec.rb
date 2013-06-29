require 'spec_helper'

describe Location do

  before :each do
    @field = Field.new height: 2, width: 2, mines: 4
    @field.save!
    @location = @field.locations.first
  end

  it 'tells you how many locations in proximity have mines' do
    @location.mine_count.should eq(4)
  end

  it 'has a scope to find a specific location by x/y coordinates' do
    location = @field.locations.fetch_coordinate(1,0)
    location.x_coordinate.should eq(1)
    location.y_coordinate.should eq(0)
  end

  it 'provides a scope of locations within proximity' do
    @location.locations_within_proximity.to_a.should eq(@field.locations.to_a)
  end

  it 'sets field state to lost if updated to uncovered and has a mine' do
    @location.update(state:'uncovered')
    @location.field.state.should eq('lost')
  end

  it 'prevents a state change from uncovered to any other state' do
    @location.has_mine = false
    @location.state = 'uncovered'
    @location.save!
    @location.state = 'covered'
    @location.valid?.should be(false)
  end

  it 'has a scope to find locations around it' do
    @location.locations_around.should_not include(@location)
    @location.locations_around.count.should eq(3)
  end




end
