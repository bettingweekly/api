require 'rails_helper'

RSpec.describe Favourite, type: :model do
  context '#create' do
    it 'should create a new Favourite object' do
      favourite = Favourite.new
      expect(favourite.nil?).to be_falsey
    end

    it 'should have the following attributes
        :number, :marked, :created, :updated_at' do
      favourite = Favourite.new
      expect(favourite.attributes.keys).to eq %w(number marked created_at updated_at)
    end

    it 'should raise an error when the number is blank' do
      favourite = Favourite.new
      expect(favourite.valid?).to be_falsey
      expect(favourite.errors[:number][0]).to eq "can't be blank"

      favourite.number = 1

      expect(favourite.valid?).to be_truthy
    end

    it 'should raise an error if the number is not unique' do
      Favourite.create(number: 1)
      favourite_two = Favourite.create(number: 1)

      expect(favourite_two.valid?).to be_falsey
      expect(favourite_two.errors[:number][0]).to eq "has already been taken"
    end

    it 'should raise an error if the number is less than 0' do
      favourite = Favourite.create(number: -1)
      expect(favourite.valid?).to be_falsey
      expect(favourite.errors[:number][0]).to eq "must be greater than 0"
    end

    it 'should raise an error if the number is greater than the limit 100000000000' do
      favourite = Favourite.create(number: 200_000_000_000)
      expect(favourite.valid?).to be_falsey
      expect(favourite.errors[:number][0]).to eq "must be less than or equal to 100000000000"
    end

    it 'should allow a new favourite to be created for the limit number' do
      favourite = Favourite.create(number: 100_000_000_000)
      expect(favourite.valid?).to be_truthy
      expect(favourite.errors[:number][0]).to eq "must be less than or equal to 100000000000"
    end
  end
end
