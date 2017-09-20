require ('spec_helper')
require ('city')

describe("City") do
  describe(".all") do
    it("will be empty at first") do
      expect(City.all()).to(eq([]))
    end
  end
end
