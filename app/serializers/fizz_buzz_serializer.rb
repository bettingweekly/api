class FizzBuzzSerializer < ActiveModel::Serializer # :nodoc:
  attributes :number,
             :marked,
             :result
end
