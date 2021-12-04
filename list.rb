class List
  attr_accessor :name, :cards
  def initialize(id: nil, name:, cards: [])
    @id = id
    @name = name
    @cards = cards
  end

  def to_json(_generator)
    { id: @id, name: @name, cards: @cards }.to_json
  end
end