require ('spec_helper')
require ('city')

describe("City") do
  describe(".all") do
    it("will be empty at first") do
      expect(City.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves city to the database") do
      city = City.new({:id => nil, :name => "Seattle"})
      city.save()
      expect(City.all()).to(eq([city]))
    end
  end

  describe("#==") do
    it("is the same city if it has the same number and nickname") do
      city1 = City.new({:name => "Seattle", id: 3})
      city2 = City.new({:name => "Seattle", id: 3})
      expect(city1).to(eq(city2))
    end
  end

  describe(".find") do
    it("takes an id number as a parameter and returns the city object with that id.") do
    city1 = City.new({:name => "Seattle", id: nil})
    city1.save
    city2 = City.new({:name => "San Diego", id: nil})
    city2.save
    city3 = City.new({:name => "Atlanta", id: nil})
    city3.save
    city4= City.new({:name => "Portland", id: nil})
    city4.save
    expect(City.find(city2.id)).to(eq(city2))
    end
  end

  describe("#update") do
    it("lets you update a city in the database") do
      city = City.new({:name => "Seattle", id: nil})
      city.save()
      city.update({:name => "Portland"})
      found_city = City.find(city.id)
      expect(found_city.name()).to(eq("Portland"))
    end
  end

  describe("#delete") do
    it("lets you delete a city from the database") do
      city = City.new({:name => "Seattle", id: nil})
      city.save()
      city2 = City.new({:name => "Portland", id: nil})
      city2.save()
      city.delete()
      expect(City.all()).to(eq([city2]))
    end
  end
end
