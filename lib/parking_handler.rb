class ParkingHandler
  attr_reader :places

  DEFAULT_QUANTITY = { sedan_number: 5, disabled_number: 3, truck_number: 2 }
  TYPES = [:sedan, :disabled, :truck]

  def initialize(args = {})
    @places = TYPES.map{|t| Array.new(args["#{t}_number".to_sym] || DEFAULT_QUANTITY["#{t}_number".to_sym]) { eval("ParkingPlaceFor#{t.to_s.capitalize}.new") } }.flatten
  end

  def park!(car)
    index = free_place_index(car)
    raise 'No free parking places for your car found' unless index
    @places[index].park(car)
  end

  def number_of_free(type)
    @places.select{|p| p.free? && p.type == type}.size
  end

  def places_by_type(type)
    @places.each_with_index.map{|p, i| {index: i, place: p}}.select{|p| p[:place].type == type}
  end

  def free_place_by_index!(number)
    @places[number].free!
  end

  class << self
    def random_init
      parking = ParkingHandler.new
      (1..DEFAULT_QUANTITY.values.sum).each{ |i| parking.park!(Car.create(TYPES[rand(0..2)])) rescue 'Error' }
      parking
    end
  end

  private

  def free_place_index(car)
    @places.each_index.select{|i| @places[i].free_for?(car)}.first
  end
end