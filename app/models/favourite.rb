class Favourite < ApplicationRecord # :nodoc:
  validates_presence_of :number
  validates_uniqueness_of :number
  validates_numericality_of :number,
                            greater_than: 0,
                            less_than_or_equal_to: 100_000_000_000
  scope :in_range_and_marked, -> (start_point, end_point) { where(number: start_point...end_point + 1, marked: true) }
end
