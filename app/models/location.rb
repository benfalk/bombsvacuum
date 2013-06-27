##
# == Overview
#
# This is each spot that is found on the field
#
class Location < ActiveRecord::Base

  belongs_to :field

  validates_presence_of :field

  validates :state, :inclusion => { in: %w( covered uncovered flagged ) }

  validate :game_over?

  validate :prevent_change_from_uncovered

  scope :having_mines, -> { where( has_mine:true ) }

  scope :covered, ->{ where( state: :covered ) }

  #
  # given an x,y coordinate, it fetches the first location found matching
  # the given coordinate, this scope should normally be called within
  # the scope of a field's locations
  #
  scope :fetch_coordinate, -> (x=0,y=0){ where( x_coordinate: x,
                                             y_coordinate: y ).first }

  after_save do
    if uncovered? && has_mine?
      field.update!(state: 'lost')
    elsif uncovered?
      field.update!(state: 'playing')
    end
  end

  before_save do
    self.mines = mine_count if uncovered? && mines.nil?
  end

  #
  # terribly long potentially, but uncovers all surrounding locations
  # and chains along on others that have no surrounding mines
  #
  def chain_uncover!
    Field::Analyzer.new(field).uncover_strategy_from(self).tap do |locations|
      field.locations.
          where(id: locations.map(&:id)).
          update_all(state: :uncovered, updated_at: Time.now)
    end
  end

  #
  # determines if there are any mines in the proximity
  #
  def surrounding_mines?
    mine_count > 0
  end

  def uncovered?
    state == 'uncovered'
  end

  def changed_from_uncovered?
    state_changed? && state_was == 'uncovered'
  end

  def covered?
    state == 'covered'
  end

  def flagged?
    state == 'flagged'
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

    def prevent_change_from_uncovered
      if changed_from_uncovered?
        errors.add(:state, 'May not change from state of uncovered')
      end
    end

    def game_over? #:nodoc:
      if field.over?
        errors.add(:general, "Board is already #{field.state}")
      end
    end

    def x_proximity #:nodoc:
      (x_coordinate-1)..(x_coordinate+1)
    end

    def y_proximity #:nodoc:
      (y_coordinate-1)..(y_coordinate+1)
    end

end
