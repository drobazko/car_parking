class ParkingPlaceForSedan < ParkingPlace
  def initialize
    @type = :sedan
  end

  def free_for?(car)
    free? && [:sedan, :disabled].include?(car.type)
  end
end