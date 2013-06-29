##
# == Overview
#
# Helper class to store a fields locations in memory providing
# more efficient seeks and calculations instead of having to
# perform a lot of costly queries against the database
#
class Field::Analyzer

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
    locations_surrounding_coordinates(location).map do |coordinates|
      @map[coordinates[0]][coordinates[1]]
    end
  end

  def has_mines_surrounding?(location)
    locations_around(location).any? { |l| l.has_mine? }
  end

  def mines_surrounding(location)
    locations_around(location).inject(0){ |sum,location| sum + (location.has_mine? ? 1 : 0)}
  end

  def uncover_strategy_from(location)
    uncovered = [location]
    queue = []
    queue << location unless has_mines_surrounding? location
    until queue.empty?
      location = queue.pop
      (locations_around(location)-uncovered).each do |location|
        location.state = 'uncovered'
        uncovered << location
        queue << location if location.mines == 0
      end
    end
    uncovered
  end

  #
  # returns all location coordinates around location given
  #
  def locations_surrounding_coordinates(location)

    possible_coordinates = possible_offsets.map do |offset|
      [(location.x_coordinate+offset[0]),(location.y_coordinate+offset[1])]
    end

    possible_coordinates.select do |coordinate|
      coordinate[0] > -1 && coordinate[0] < @field.height && coordinate[1] > -1 && coordinate[1] < @field.width
    end

  end

  private

  def possible_offsets
    [[-1,1],[-1,0],[-1,-1],[0,1],[0,-1],[1,1],[1,0],[1,-1]]
  end

end