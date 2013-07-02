require 'spec_helper'

describe Field do

  before :each do
    @field = Field.new width: 10, height: 10, mines: 10
  end

  it 'builds a new field base on conditions' do
    @field.valid?.should be(true)
  end

  it 'has a size, which is it\'s width * height' do
    @field.size.should eq(100)
  end

  describe 'after create' do

    before :each do
      @field.save
    end

    it 'has locations after created' do
      @field.locations.count.should eq(100)
    end

    it 'should x amount of locations with mines on locations' do
      @field.locations.where(has_mine: true).count.should eq(10)
    end

  end






end
