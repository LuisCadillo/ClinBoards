require_relative 'card'
class List
  attr_accessor :name, :cards
  def initialize(id: nil, name:, cards: [])
    @id = set_id(id)
    @name = name
    @cards = create_card_instances(cards)
  end

  @@crr_id = 0
  def set_id(id)
    @id = id || @@crr_id += 1
  end

  def to_json(_generator)
    { id: @id, name: @name, cards: @cards }.to_json
  end

  private
  def create_card_instances(cards)
    cards.map do |card|
      Card.new(card)
    end
  end

  def self.reset_crr_id # to avoid creating infinite increasing IDs
    @@crr_id = 0
  end
end