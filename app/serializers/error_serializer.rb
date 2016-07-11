module ErrorSerializer # :nodoc:
  def self.serialize(errors)
    return if errors.nil?

    json = {}

    new_hash = errors.to_hash(true).map do |key, value|
      value.map do |message|
        { id: key, title: message }
      end
    end.flatten

    json[:errors] = new_hash
    json
  end
end
