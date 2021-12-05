require_relative 'store'
require 'terminal-table'

class ClinBoards
  def initialize
    @store = Store.new('store.json')
  end

  def start
    display_welcome
    action = ''
    until action == 'exit' 
      print_table(title: 'CLIn Boards',
                  headings: %w[ID Name Description List(#cards)],
                  rows: @store.generate_board_instances)  #To refresh the boards on each loop
      action, id = menu(name: ['Board'], first_options: ['create', 'show ID', 'update ID', 'delete ID'], out_message: 'exit')
      case action
      when "create" then create_board
      when 'show' then show_lists(id.to_i)
      when 'update' then update_board(id.to_i)
      when 'delete' then delete_board(id.to_i)
      end
    end
    display_goodbye
  end

  private
  def display_welcome
    puts "Welcome to CLIn Boards".center(90, '-')
  end
  def display_goodbye
    puts 'Thanks for using CLIn Boards'.center(90, '-')
  end

  def print_table(title:, headings:, rows:)
    table = Terminal::Table.new
    table.title = title
    table.headings = headings
    table.rows = rows.map(&:details)
    puts table
  end
  def menu(name:, first_options:, second_options: nil, out_message:)
    puts "#{name[0]} options: #{first_options.join(' | ')}"
    puts "#{name[1]} options: #{second_options.join(' | ')}" unless second_options.nil?
    puts out_message
    print '> '
    action, id = gets.chomp.split
    [action, id]
  end

  def board_form
    print 'Name: '
    name = gets.chomp
    print 'Description: '
    description = gets.chomp
    { name: name, description: description }
  end

  def list_form
    print 'Name: '
    name = gets.chomp
    { name: name }
  end

  def card_form(id, *options)
    unless options.empty?
      puts 'Select a list:'
      puts options.join(' | ')
      print '> '
      list = gets.chomp
    end
    print 'Title: '
    title = gets.chomp
    print 'Members: '
    members = gets.chomp.split(', ')
    print 'Labels: '
    labels = gets.chomp.split(', ')
    print 'Due Date: '
    due_date = gets.chomp

    return [list, {id: id, title: title, members: members, labels: labels, due_date: due_date}] unless options.empty?
    return {id: id, title: title, members: members, labels: labels, due_date: due_date}
  end

  def checklist_form
    print 'Title: '
    title = gets.chomp
    { title: title, completed: false}
  end

  def update_board(id)
    new_data = board_form
    @store.update_board(id, new_data)
  end

  def create_board
    new_data = board_form
    @store.create_board(new_data)
  end

  def delete_board(id)
    @store.delete_board(id)
  end

  def show_lists(board_id)
    action = ''
    until action == 'back'
      lists = @store.get_lists(board_id)
      @store.reorder_cards
      lists.each do |list|
        print_table(title: list.name,
                    headings: ['ID', 'Title', 'Members', 'Labels', 'Due Date', 'Checklist'],
                    rows: list.cards)
      end
      action, id = menu(name: ['List', 'Card'],
                        first_options: ['create-list', 'update-list LISTNAME', 'delete-list LISTNAME'], second_options: ['create-card', 'checklist ID', 'update-card ID', 'delete-card ID'],
                        out_message: 'back')
      case action
      when 'create-list' then create_list
      when 'update-list' then update_list(id)
      when 'delete-list' then delete_list(id)
      when 'create-card' then create_card
      when 'checklist' then show_checklist(id.to_i)
      when 'update-card' then update_card(id.to_i)
      when 'delete-card' then delete_card(id.to_i)
      end
    end
  end

  def create_list
    name = list_form
    @store.create_list(name)
  end

  def update_list(name)
    new_name = list_form[:name]
    @store.update_list(new_name: new_name, name: name)
  end

  def delete_list(name)
    @store.delete_list(name)
  end

  def create_card
    @store.create_card { |id, list| card_form(id, list) }
  end

  def update_card(id)
    new_data = card_form(id)
    @store.update_card(id, new_data)
  end

  def delete_card(id)
    @store.delete_card(id)
  end

  def show_checklist(card_id)
    action = ''
    until action == 'back'
      @store.reorder_checklist(card_id)
      checklist = @store.get_checklist(card_id)
      display_checklist(checklist)
      action, id = menu(name: ['Checklist'],
                        first_options: ['add', 'toggle INDEX', 'delete INDEX'],
                        out_message: 'back')
      case action
      when 'add' then add_task(card_id)
      when 'toggle' then toggle_task(id.to_i, card_id)
      when 'delete' then delete_task(id.to_i, card_id)
      end
    end
  end

  def add_task(card_id)
    new_data = checklist_form
    @store.add_task(card_id, new_data)
  end

  def toggle_task(check_id, card_id)
    @store.toggle_task(check_id, card_id)
  end

  def delete_task(check_id, card_id)
    @store.delete_task(check_id, card_id)
  end

  private
  def display_checklist(checklist)
    checklist.each do |item|
      puts "[#{item.completed ? 'x' : ' '}] #{item.id}. #{item.title}"
    end
    puts '-' * 90
  end
end

app = ClinBoards.new
app.start