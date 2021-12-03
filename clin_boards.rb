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
                  rows: @store.boards)  #To refresh the boards on each loop
      action, id = menu('Board', ['create', 'show ID', 'update ID', 'delete ID' ])
      case action
      when "create" then create_board
      when 'show'
        puts 'show in progress'
      when 'update' then update_board(id)
      when 'delete'
        puts 'delete in progress'
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
  def menu(name, options)
    puts "#{name} options: #{options.join(' | ')}"
    puts 'exit'
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
end

app = ClinBoards.new
app.start