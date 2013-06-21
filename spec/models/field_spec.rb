require 'spec_helper'

describe Field do

  before :each do
    @field = Field.new width: 10, height: 10, mines: 10
  end

  it 'builds a new field base on conditions' do
    @field.valid?.should be(true)
  end

  describe 'after create' do

    it 'has locations after created' do
      @field.save
      @field.locations.count.should eq(100)
    end

    it 'should x amount of locations with mines on locations' do
      @field.save
      @field.locations.where(has_mine: true).count.should eq(10)
    end


  end






end
