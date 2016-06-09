class Car
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  class << self
    def create(type)
      Car.new(type)
    end
  end
end
