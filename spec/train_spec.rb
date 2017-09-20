require ('spec_helper')
require ('train')

describe("Train") do
  describe(".all") do
    it("will be empty at first") do
      expect(Train.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves train to the database") do
      train = Train.new({:id => nil, :train_number => "D line", :nickname => "The D"})
      train.save()
      expect(Train.all()).to(eq([train]))
    end
  end

  describe("#==") do
    it("is the same train if it has the same number and nickname") do
      train1 = Train.new({:train_number => "Jane Doe", :nickname => "2", id: 3})
      train2 = Train.new({:train_number => "Jane Doe", :nickname => "2", id: 3})
      expect(train1).to(eq(train2))
    end
  end

  describe(".find") do
    it("takes an id number as a parameter and returns the train object with that id.") do
    train1 = Train.new({:train_number => "Jane Doe", :nickname => "1", id: nil})
    train1.save
    train2 = Train.new({:train_number => "John Doe", :nickname => "2", id: nil})
    train2.save
    train3 = Train.new({:train_number => "Jim Doe", :nickname => "3", id: nil})
    train3.save
    train4= Train.new({:train_number => "Joan Doe", :nickname => "4", id: nil})
    train4.save
    expect(Train.find(train2.id)).to(eq(train2))
    end
  end

  describe("#update") do
    it("lets you update trains in the database") do
      train = Train.new({:train_number => "John Doe", :nickname => "2", id: nil})
      train.save()
      train.update({:train_number => "Johnny", :nickname => "deuce"})
      found_train = Train.find(train.id)
      expect([found_train.train_number(), found_train.nickname]).to(eq(["Johnny", "deuce"]))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      train = Train.new({:train_number => "Joan Doe", :nickname => "4", id: nil})
      train.save()
      train2 = Train.new({:train_number => "John Doe", :nickname => "2", id: nil})
      train2.save()
      train.delete()
      expect(Train.all()).to(eq([train2]))
    end
  end
end
