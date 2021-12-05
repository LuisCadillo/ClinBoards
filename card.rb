require_relative 'checklist'
class Card
  attr_accessor :id, :update, :checklist
  def initialize(id: 0, title:, members:, labels:, due_date:, checklist:[])
    @id = id
    @title = title
    @members = members
    @labels = labels
    @due_date = due_date
    @checklist = create_checklist_instances(checklist)
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
    completed = @checklist.select { |item| item.completed }
    "#{completed.size}/#{@checklist.size}"
  end

  def create_checklist_instances(cheklists)
    cheklists.map do |cheklist|
      Checklist.new(cheklist)
    end
  end
end