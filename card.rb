class Card
  def initialize(id:, title:, members:, labels:, due_date:, checklist:)
    @id = id
    @title = title
    @members = members
    @labels = labels
    @due_date = due_date
    @checklist = checklist
  end

  def details
    [@id, @title, @members.join(', '), @labels.join(', '), @due_date, show_checklist_progress]
  end

  private
  def show_checklist_progress
    completed = @checklist.select { |item| item[:completed] }
    "#{completed.size}/#{@checklist.size}"
  end
end