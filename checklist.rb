class Checklist
  attr_accessor :id, :title, :completed
  def initialize(title:, completed: false)
    @title = title
    @completed = completed
    @id = 0
  end

  def to_json(_generator)
    { title: @title, completed: @completed }.to_json
  end

  def toggle
    @completed = !@completed
  end
end