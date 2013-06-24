##
# == Overview
#
# Helper class to store a fields locations in memory providing
# more efficient seeks and calculations instead of having to
# perform a lot of costly queries against the database
#
class Field::Map

  #
  # @param field Field
  #
  def initialize(field)
    @field = field
    @map = []
    @field.locations.each do |location|
      @map[location.x_coordinate] ||= []
      @map[location.x_coordinate][location.y_coordinate] = location
    end
  end

  #
  # @param location Location
  #
  def locations_around(location)

  end


  def locations_surrounding_coordinates(location)

    possible_coordinates = possible_offsets.map do |offset|
      [(location.x_coordinate+offset[0]),(location.y_coordinate+offset[1])]
    end

    possible_coordinates.select do |coordinate|
      coordinate[0] > -1 && coordinate[0] <= @field.width && coordinate[1] > -1 && coordinate[1] <= @field.height
    end

  end

  private

  def possible_offsets
    [[-1,1],[-1,0],[-1,-1],[0,1],[0,-1],[1,1],[1,0],[1,-1]]
  end

end