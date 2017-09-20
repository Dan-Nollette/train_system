class Train
  attr_reader :id, :train_number, :nickname

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @train_number = attributes.fetch(:train_number)
    @nickname = attributes.fetch(:nickname)
  end


  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      train_number = train.fetch("train_number")
      nickname = train.fetch("nickname")
      id = train.fetch("id").to_i()
      trains.push(Train.new({id: id, train_number: train_number, nickname: nickname}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (train_number, nickname) VALUES ('#{self.train_number}', '#{self.nickname}') RETURNING id;")
    @id = result.first.fetch("id").to_i()
  end

  def == (other_train)
    self.train_number == other_train.train_number && self.nickname == other_train.nickname && self.id == other_train.id
  end

  def self.find(id)
    trains = Train.all()
    found_train = nil
    trains.each do |train|
      if train.id == id
        found_train = train
      end
    end
    found_train
  end

  def update(attributes)
    @nickname = attributes.fetch(:nickname)
    @train_number = attributes.fetch(:train_number)
    @id = self.id()
    DB.exec("UPDATE trains SET nickname = '#{@nickname}', train_number = '#{@train_number}' WHERE id = #{@id};")
  end

  def delete()
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end
end
