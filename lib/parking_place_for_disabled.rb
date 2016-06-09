class ParkingPlaceForDisabled < ParkingPlace
  def initialize
    @type = :disabled
  end

  def free_for?(car)
    free? && car.type == @type
  end
end