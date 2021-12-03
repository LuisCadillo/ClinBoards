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
                  rows: @store.parse_boards)  #To refresh the boards on each loop
      action, id = menu(name: ['Board'], first_options: ['create', 'show ID', 'update ID', 'delete ID'], out_message: 'exit')
      case action
      when "create" then create_board
      when 'show' then show_lists(id)
      when 'update' then update_board(id)
      when 'delete' then delete_board(id)
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
    [action, id.to_i]
  end

  def board_form
    print 'Name: '
    name = gets.chomp
    print 'Description: '
    description = gets.chomp
    { name: name, description: description }
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
    lists = @store.get_lists(board_id)
    action = ''
    until action == 'back'
      lists.each do |list|
        print_table(title: list[:name],
                    headings: ['ID', 'Title', 'Members', 'Labels', 'Due Date', 'Checklist'],
                    rows: @store.parse_cards(list[:cards]))
      end
      action, id = menu(name: ['List', 'Card'],
                        first_options: ['create-list', 'update-list LISTNAME', 'delete-list LISTNAME'], second_options: ['create-card', 'checklist ID', 'update-card ID', 'delete-card ID'],
                        out_message: 'back')
      case action
      when 'create-list' then create_list
      when 'update-list' then update_list(id)
      when 'delete-list' then delete_list(id)
      when 'create-card' then create_card
      when 'update-card' then update_card(id)
      when 'delete-card' then delete_card(id)
      end
    end
    # 1. select the correct board
    # 2. create tables for each of the lists (headers will be the same always)
  end
end

app = ClinBoards.new
app.start
