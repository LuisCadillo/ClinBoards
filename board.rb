class Board
  attr_accessor :id,:name, :description, :reset_crr_id
  def initialize(id: nil, name:, description:, lists: [])
    @id = set_id(id)
    @name = name
    @description = description
    @lists = lists
  end
  
  @@crr_id = 0
  def set_id(id)
    @id = @@crr_id += 1
  end

  def self.reset_crr_id # to avoid creating infinite increasing IDs
    @@crr_id = 0
  end

  def to_json(_generator)
    { id: @id, name: @name, description: @description, lists: @lists }.to_json
  end

  def details 
    [@id, @name, @description, @lists.size]
  end
  def update(name:, description:)
    @name = name unless name.nil? || name.empty?
    @description = description unless description.nil? || name.empty?
  end
end