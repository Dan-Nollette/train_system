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
      id = city.fetch("id").to_i()
      cities.push(City.new({id: id, name: name}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first.fetch("id").to_i()
  end

  def == (other_city)
    self.name == other_city.name && self.id == other_city.id
  end

  def self.find(id)
    cities = City.all()
    found_city = nil
    cities.each do |city|
      if city.id == id
        found_city = city
      end
    end
    found_city
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete()
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end

end
