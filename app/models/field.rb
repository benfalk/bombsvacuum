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

  has_many :locations

  after_create :create_field

  private

  #
  # Builds out the field based on the values that the field has by creating
  # a location for each coordinate that should exists in the field and then
  # randomly assigns the number of mines of locations to the field
  #
  def create_field

    height.times do |h|
      width.times do |w|
        locations.build( x_coordinate: h, y_coordinate: w, state: :covered ).save!
      end
    end

    locations.pluck(:id).sample(mines).each do |loc_id|
      locations.find_by(id: loc_id).update(has_mine: true)
    end

  end

end
