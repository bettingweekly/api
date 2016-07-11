require 'rails_helper'

RSpec.describe FizzBuzz, type: :model do
  describe 'creating a new FizzBuzz object that
            inherits from Favourite Model and extends it' do
    it 'should create a new FizzBuzz object' do
      fizz_buzz = FizzBuzz.new
      expect(fizz_buzz.nil?).to be_falsey
    end

    it 'should have the following attributes
        :number, :marked, :created, :updated_at' do
      fizz_buzz = FizzBuzz.new
      expect(fizz_buzz.attributes.keys).to eq %w(number marked created_at updated_at)
    end

    it 'should have an attribute that can be
        accessed called result which is the fizz_buzz
        calculation' do
      fizz_buzz = FizzBuzz.new
      expect(fizz_buzz.result.nil?).to be_truthy
    end

    context '#execute function after initialize to
             determine fizz buzz result' do
      it 'should return fizz' do
        fizz_buzz = FizzBuzz.new(number: 3)
        expect(fizz_buzz.result).to eq 'fizz'
      end

      it 'should return buzz' do
        fizz_buzz = FizzBuzz.new(number: 5)
        expect(fizz_buzz.result).to eq 'buzz'
      end

      it 'should return fizzbuzz' do
        fizz_buzz = FizzBuzz.new(number: 15)
        expect(fizz_buzz.result).to eq 'fizzbuzz'
      end

      it 'should return the number' do
        fizz_buzz = FizzBuzz.new(number: 1)
        expect(fizz_buzz.result).to eq '1'
      end
    end
  end
end
