class Card
  attr_accessor :id, :update
  def initialize(id:, title:, members:, labels:, due_date:, checklist:[])
    @id = set_id(id)
    @title = title
    @members = members
    @labels = labels
    @due_date = due_date
    @checklist = checklist
  end

  @@crr_id = 0
  def set_id(id)
    @id = id || @@crr_id += 1
  end

  def details
    [@id, @title, @members.join(', '), @labels.join(', '), @due_date, show_checklist_progress]
  end

  def to_json(_generator)
    {id: @id, title: @title, members: @members, labels: @labels, due_date: @due_date, checklist: @checklist}.to_json
  end

  def update(id:, title:, members:, labels:, due_date:)
    @id = id
    @title = title
    @members = members
    @labels = labels
    @due_date = due_date
  end

  private
  def show_checklist_progress
    completed = @checklist.select { |item| item[:completed] }
    "#{completed.size}/#{@checklist.size}"
  end

  def self.reset_crr_id # to avoid creating infinite increasing IDs
    @@crr_id = 0
  end
end