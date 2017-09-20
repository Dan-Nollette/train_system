class City
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("name")
      id = train.fetch("id").to_i()
      cities.push(City.new({id: id, name: name}))
    end
    cities
  end
end
