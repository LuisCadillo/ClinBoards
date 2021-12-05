class Checklist
  attr_accessor :title, :completed
  def initialize(title:, completed: false)
    @title = title
    @completed = completed
    @id = set_id
  end

  def to_json(_generator)
    { title: @title, completed: @completed }.to_json
  end

  private
  @@crr_id = 0
  def set_id
    @id = @@crr_id += 1
  end

  def self.reset_crr_id # to avoid creating infinite increasing IDs
    @@crr_id = 0
  end
end