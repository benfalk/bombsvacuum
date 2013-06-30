##
# == Overview
#
# This is the container that contains all the mines and locations
# that are interacted with
#
class Field < ActiveRecord::Base

  validates :height,
            :width,
            :mines,
            :numericality => { :integer => true, :greater_than_or_equal_to => 1 }

  validates :state,
            :inclusion => { in: %w( ready playing won lost ) },
            :allow_blank => true

  has_many :locations

  before_create :build_locations

  #
  # determines the size of the field, which is it's height * width
  #
  def size
    height * width
  end

  #
  # determines if the game is over or not based on it's state
  #
  def over?
    state == 'won' || state == 'lost'
  end

  private

  #
  # Builds out the field based on the values that the field has by creating
  # a location for each coordinate that should exists in the field and then
  # randomly assigns the number of mines of locations to the field
  #
  def build_locations

    height.times do |h|
      width.times do |w|
        locations.build( x_coordinate: h,
                         y_coordinate: w,
                         state: 'covered',
                         has_mine: false,
                         mines: 0         )
      end
    end

    analyzer = Field::Analyzer.new self

    locations.sample(mines).each do |loc|
      loc.has_mine = true
      analyzer.locations_around(loc).each { |area| area.mines += 1 }
    end

    self.state = 'ready'

  end

end
