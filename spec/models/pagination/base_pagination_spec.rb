require 'rails_helper'

RSpec.describe Pagination::BasePagination, type: :model do
  let(:subject) { Pagination::BasePagination.new }

  describe 'Pagination::BasePagination class' do
    context '#page' do
      it 'should by default be set as 1' do
        expect(subject.page).to eq 1
      end
    end

    context '#page validation' do
      it 'must be greater than 0' do
        expect(subject.valid?).to be_truthy
        subject.page = -1
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:page][0]).to eq 'must be greater than 0'
      end
    end

    context '#per_page' do
      it 'should by default be set as 100' do
        expect(subject.per_page).to eq 100
      end
    end

    context '#per_page validation' do
      before(:each) { expect(subject.valid?).to be_truthy }

      it 'must be greater than 0' do
        subject.per_page = -1
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:per_page][0]).to eq 'must be greater than 0'
      end

      it 'must be less than or equal to 1000' do
        subject.per_page = 2000
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:per_page][0]).to eq 'must be less than or equal to 1000'
      end

      it 'must be an even number' do
        subject.per_page = 3
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:per_page][0]).to eq 'must be even'
      end
    end

    context '#page_and_per_page_must_be_less_than_or_equal_to' do
      it 'should return an error when the is greater than 100_000_000_000' do
        subject.page = 1_000_000_000
        subject.per_page = 102
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:limit_breached][0]).to eq "response items must be less than or equal to #{subject.limit}"
      end
    end

    context '#end_point' do
      it 'should return the end point which is calculated from page and per_page' do
        expect(subject.end_point).to eq 100
        subject.page = 2
        expect(subject.end_point).to eq 200
        subject.per_page = 10
        expect(subject.end_point).to eq 20
      end
    end

    context '#start_point' do
      it 'should return the start_point a an integer' do
        expect(subject.start_point).to eq 1
        subject.page = 4
        expect(subject.start_point).to eq 301
      end
    end

    context '#first_page' do
      it 'should return 1 for the starting page' do
        expect(subject.first_page).to eq 1
      end
    end

    context '#last_page' do
      it 'should return the last page number that will show records up to 100_000_000_000' do
        expect(subject.last_page).to eq 1_000_000_000
        subject.per_page = 2
        expect(subject.last_page).to eq 50_000_000_000
        subject.per_page = 500
        expect(subject.last_page).to eq 200_000_000
      end
    end

    context '#next_page' do
      it 'should return a value 1 higher than the current page' do
        expect((subject.next_page - subject.page) == 1).to be_truthy
        subject.page = 10
        expect((subject.next_page - subject.page) == 1).to be_truthy
      end

      it 'should return nil when the current page is the last page' do
        subject.page = 1_000_000_000
        expect(subject.next_page).to be_nil
      end
    end

    context '#prev_page' do
      it 'should return a value 1 less than the current page' do
        subject.page = 2
        expect((subject.prev_page - subject.page) == -1).to be_truthy
        subject.page = 10
        expect((subject.prev_page - subject.page) == -1).to be_truthy
      end

      it 'should return nil when current page is 1' do
        expect(subject.prev_page).to be_nil
      end
    end

    context '#url_builder' do
      it 'should create url based on provided input' do
        expect(subject.url_builder(10, 100, 'http://test.com')).to eq 'http://test.com?page=10&per_page=100'
      end
    end
  end
end
