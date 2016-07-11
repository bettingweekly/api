class FizzBuzz < Favourite # :nodoc:
  after_initialize :execute
  attr_accessor :result

  def execute
    return if number.nil?
    @result = case
                when number.multiple_of?(3) && number.multiple_of?(5)
                  'fizzbuzz'
                when number.multiple_of?(3)
                  'fizz'
                when number.multiple_of?(5)
                  'buzz'
                else
                  number.to_s
              end
  end
end
