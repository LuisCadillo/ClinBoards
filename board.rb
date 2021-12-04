require_relative 'list'
class Board
  attr_accessor :id,:name, :description, :lists, :reset_crr_id
  def initialize(id: nil, name:, description:, lists: [])
    @id = set_id(id)
    @name = name
    @description = description
    @lists = create_list_instances(lists)
  end
  
  @@crr_id = 0
  def set_id(id)
    @id = @@crr_id += 1
  end

  def to_json(_generator)
    { id: @id, name: @name, description: @description, lists: @lists }.to_json
  end

  def details 
    [@id, @name, @description, compose_lists(@lists)]
  end
  def update(name:, description:)
    @name = name unless name.nil? || name.empty?
    @description = description unless description.nil? || name.empty?
  end

  private
  def compose_lists(lists)
    lists.map { |list| "#{list.name}(#{list.cards.size})" }.join(', ')
  end

  def self.reset_crr_id # to avoid creating infinite increasing IDs
    @@crr_id = 0
  end

  def create_list_instances(lists)
    lists.map do |list|
      List.new(list)
    end
  end
end