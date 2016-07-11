class Favourite < ApplicationRecord # :nodoc:
  validates_presence_of :number
  validates_uniqueness_of :number
  validates_numericality_of :number,
                            greater_than: 0,
                            less_than_or_equal_to: 100_000_000_000
end
