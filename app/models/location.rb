##
# == Overview
#
# This is each spot that is found on the field
#
class Location < ActiveRecord::Base

  belongs_to :field

  validates_presence_of :field

  scope :having_mines, -> { where( has_mine:true ) }

  #
  # given an x,y coordinate, it fetches the first location found matching
  # the given coordinate, this scope should normally be called within
  # the scope of a field's locations
  #
  scope :by_coordinate, -> (x=0,y=0){ where( x_coordinate: x,
                                             y_coordinate: y ).first }

  #
  # determines if there are any mines in the proximity
  #
  def surrounding_mines?
    mine_count > 0
  end

  #
  # builds a scope of all locations that are within proximity, this
  # includes the instance location this is called on
  #
  def locations_within_proximity
    field.locations.where( x_coordinate: x_proximity,
                           y_coordinate: y_proximity )
  end

  #
  # finds the number of mines found in the proximity of this location
  #
  def mine_count
    locations_within_proximity.having_mines.count
  end

  private

  def x_proximity #:nodoc:
    (x_coordinate-1)..(x_coordinate+1)
  end

  def y_proximity #:nodoc:
    (y_coordinate-1)..(y_coordinate+1)
  end

end
