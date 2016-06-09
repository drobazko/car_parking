class Car
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def update(parking_handler)
    parking_handler.park!(self)
  end

  class << self
    def create(type)
      Car.new(type)
    end
  end
end
