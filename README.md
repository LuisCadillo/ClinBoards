# CLIn Boards

In the age of productivity, is not a surprise the huge popularity of
Kanban-based applications such as Trello, Asana, KanbanFlow, and others. But for
a ruby student, there is not many offers on command-line apps that could offer a
really clean interface to work with boards and tasks.

## Introducing **CLIn Boards**!

With CLIn Boards you can create as many Boards as you like. Each board can have
as many lists and each list as many cards as you want. 💪🏼Your data is locally
stored so don't worry about losing any board update. 🎉

For this extended, the focus will be on the Happy Path but feel free to add some
validations where you see fit.

## Happy path

### Start the program

You can start the program by executing `ruby clin_boards.rb` but optionally, you
can pass an extra argument that represents the path to a filename for your CLIn
Boards store. This should be a JSON file: `ruby clin_boards some_file.json` If
no extra argument is provided, CLIn Boards would use `store.json` as a default
value.

When you start the app, a welcome message is displayed followed by the table
with all the boards you currently have. Each board has a name, description, and
list. The lists with the number of cards they contain are shown in the last
column.

Immediately after, the main menu is shown with the options `create`, `show ID`,
`update ID`, and `delete ID` follow in the next line by the `exit` option.

```
$ ruby clin_boards.rb
####################################
#      Welcome to CLIn Boards      #
####################################
+----+------------------------+---------------------------------------+--------------------------------------------------+
|                                                      CLIn Boards                                                       |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| ID | Name                   | Description                           | List(#cards)                                     |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| 1  | Extended - CLIn Boards | Task management for the last extended | Todo(3), In Progress(2), Code Review(1), Done(2) |
+----+------------------------+---------------------------------------+--------------------------------------------------+
Board options: create | show ID | update ID | delete ID
exit
> 
```

## Create a new board

When you type `create` the program ask you for a Name and a Description and then
create a new Board with no List yet. The program prints the updated Board table
and the main menu options.

```
> create
Name: Retrospective Meeting
Description: Meeting to reflect on our work
+----+------------------------+---------------------------------------+--------------------------------------------------+
|                                                      CLIn Boards                                                       |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| ID | Name                   | Description                           | List(#cards)                                     |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| 1  | Extended - CLIn Boards | Task management for the last extended | Todo(3), In Progress(3), Code Review(1), Done(1) |
| 2  | Retrospective Meeting  | Meeting to reflect on our work        |                                                  |
+----+------------------------+---------------------------------------+--------------------------------------------------+
Board options: create | show ID | update ID | delete ID
exit
> 
```

## Update a board

When you type `update ID` providing a valid ID (first column on the table), the
program will ask you for a Name and a Description. If a field is left blank, the
previous value shouldn't change. The program prints the updated Board table and
the main menu options.

```
> update 2
Name: Retrospective Meeting Reloaded!
Description: Even a greater meeting
+----+---------------------------------+---------------------------------------+--------------------------------------------------+
|                                                           CLIn Boards                                                           |
+----+---------------------------------+---------------------------------------+--------------------------------------------------+
| ID | Name                            | Description                           | List(#cards)                                     |
+----+---------------------------------+---------------------------------------+--------------------------------------------------+
| 1  | Extended - CLIn Boards          | Task management for the last extended | Todo(3), In Progress(3), Code Review(1), Done(1) |
| 2  | Retrospective Meeting Reloaded! | Even a greater meeting                |                                                  |
+----+---------------------------------+---------------------------------------+--------------------------------------------------+
Board options: create | show ID | update ID | delete ID
exit
>
```

## Delete a board

When you type `delete ID` providing a valid ID, the program deletes the
corresponding Board and prints the updated Board table and the main menu
options.

```
> delete 2
+----+------------------------+---------------------------------------+--------------------------------------------------+
|                                                      CLIn Boards                                                       |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| ID | Name                   | Description                           | List(#cards)                                     |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| 1  | Extended - CLIn Boards | Task management for the last extended | Todo(3), In Progress(3), Code Review(1), Done(1) |
+----+------------------------+---------------------------------------+--------------------------------------------------+
Board options: create | show ID | update ID | delete ID
exit
>
```

## Show a board details

When you type `show ID` with a valid ID, the program opens the corresponding
Board and displays one table for each of the Board lists. Each table (list)
shows their name and their corresponding cards (one per row).

The Checklist column shows the number of the completed items over the total
items. When 0/0 is presented it means that the card does not have any checklist
item.

```
> show 1
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 1/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+-------------------+---------+-------------------+------------+-----------+
|                                  In Progress                                  |
+----+-------------------+---------+-------------------+------------+-----------+
| ID | Title             | Members | Labels            | Due Date   | Checklist |
+----+-------------------+---------+-------------------+------------+-----------+
| 4  | Create List class | Deyvi   | coding, challenge | 2020-11-19 | 2/3       |
| 5  | Create Card class | Wences  | coding            | 2020-11-19 | 1/4       |
+----+-------------------+---------+-------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+---------------+----------------------+--------+------------+-----------+
|                                    Done                                     |
+----+---------------+----------------------+--------+------------+-----------+
| ID | Title         | Members              | Labels | Due Date   | Checklist |
+----+---------------+----------------------+--------+------------+-----------+
| 7  | Clone Project | Diego                | prep   |            | 0/0       |
| 8  | Divide tasks  | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+---------------+----------------------+--------+------------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
> 
```

## Show card checklist

When you type `checklist ID` with a valid ID, the name of the card followed by
the checklist items is presented. Those items that are completed are displayed
with an `x`.

```
> checklist 1
Card: Check terminal-table gem
[x] 1. Add gem to gemfile
[ ] 2. Read documentation
[ ] 3. Make an example and share with the team
-------------------------------------
Checklist options: add | toggle INDEX | delete INDEX
back
> 
```

## Add a check item

If you type `add`, the program will ask you for a Title and then it will display
the checklist with the new check item added. It is added to the end of the list
with the next index available.

```
> add
Title: Ask if this feature is mandatory
Card: Check terminal-table gem
[x] 1. Add gem to gemfile
[ ] 2. Read documentation
[ ] 3. Make an example and share with the team
[ ] 4. Ask if this feature is mandatory
-------------------------------------
Checklist options: add | toggle INDEX | delete INDEX
back
> 
```

## Toggle a check item

When you type `toggle INDEX` with a valid Index, the check item in that index
switches its completed status. If the item was uncompleted it will change to
completed and vice versa.

```
> toggle 4
Card: Check terminal-table gem
[x] 1. Add gem to gemfile
[ ] 2. Read documentation
[ ] 3. Make an example and share with the team
[x] 4. Ask if this feature is mandatory
-------------------------------------
Checklist options: add | toggle INDEX | delete INDEX
back
> 
```

## Delete a check item

When you type `delete INDEX` with a valid Index, the chek item in that position
is deleted and the rest of the items takes the available positions.

```
> delete 2
Card: Check terminal-table gem
[x] 1. Add gem to gemfile
[ ] 2. Make an example and share with the team
[x] 3. Ask if this feature is mandatory
-------------------------------------
Checklist options: add | toggle INDEX | delete INDEX
back
> 
```

## Back to the board

If you type `back` you are redirected to the Board Detail view

```
> back
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 2/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+-------------------+---------+-------------------+------------+-----------+
|                                  In Progress                                  |
+----+-------------------+---------+-------------------+------------+-----------+
| ID | Title             | Members | Labels            | Due Date   | Checklist |
+----+-------------------+---------+-------------------+------------+-----------+
| 4  | Create List class | Deyvi   | coding, challenge | 2020-11-19 | 2/3       |
| 5  | Create Card class | Wences  | coding            | 2020-11-19 | 1/4       |
+----+-------------------+---------+-------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+---------------+----------------------+--------+------------+-----------+
|                                    Done                                     |
+----+---------------+----------------------+--------+------------+-----------+
| ID | Title         | Members              | Labels | Due Date   | Checklist |
+----+---------------+----------------------+--------+------------+-----------+
| 7  | Clone Project | Diego                | prep   |            | 0/0       |
| 8  | Divide tasks  | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+---------------+----------------------+--------+------------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
> 
```

## Create a card

Now with the rest of the card options. If you type `create-card` the program
will ask you to choose in which List the card should be created. It will display
the available List to the user. Then, it will ask for the Title, Members (one or
more separated by comma), Labels (one or more separated by comma), and Due Date.
Then, it will display all the Lists again with the card added to its
corresponding List.

```
> create-card
Select a list:
Todo | In Progress | Code Review | Done
> Todo
Title: Schedule standup meeting
Members: Diego, Wences, Deyvi
Labels: meetings
Due Date: 2020-11-20
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 2/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
| 9  | Schedule standup meeting | Diego, Wences, Deyvi | meetings    | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+-------------------+---------+-------------------+------------+-----------+
|                                  In Progress                                  |
+----+-------------------+---------+-------------------+------------+-----------+
| ID | Title             | Members | Labels            | Due Date   | Checklist |
+----+-------------------+---------+-------------------+------------+-----------+
| 4  | Create List class | Deyvi   | coding, challenge | 2020-11-19 | 2/3       |
| 5  | Create Card class | Wences  | coding            | 2020-11-19 | 1/4       |
+----+-------------------+---------+-------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+---------------+----------------------+--------+------------+-----------+
|                                    Done                                     |
+----+---------------+----------------------+--------+------------+-----------+
| ID | Title         | Members              | Labels | Due Date   | Checklist |
+----+---------------+----------------------+--------+------------+-----------+
| 7  | Clone Project | Diego                | prep   |            | 0/0       |
| 8  | Divide tasks  | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+---------------+----------------------+--------+------------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
> 
```

## Update a card

When you type `update-card ID` with a valid card ID, the program will ask for
the same attributes as the create-list option. If the selected List is different
from the original one, the card should be moved from the previous list to the
new one. The rest of the attributes should be displayed updated.

```
> update-card 9
Select a list:
Todo | In Progress | Code Review | Done
> In Progress
Title: Schedule standup meeting
Members: Diego, Wences, Deyvi
Labels: meetigns, important
Due Date: 2020-11-20
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 2/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+--------------------------+----------------------+---------------------+------------+-----------+
|                                             In Progress                                             |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| ID | Title                    | Members              | Labels              | Due Date   | Checklist |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| 4  | Create List class        | Deyvi                | coding, challenge   | 2020-11-19 | 2/3       |
| 5  | Create Card class        | Wences               | coding              | 2020-11-19 | 1/4       |
| 9  | Schedule standup meeting | Diego, Wences, Deyvi | meetigns, important | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+---------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+---------------+----------------------+--------+------------+-----------+
|                                    Done                                     |
+----+---------------+----------------------+--------+------------+-----------+
| ID | Title         | Members              | Labels | Due Date   | Checklist |
+----+---------------+----------------------+--------+------------+-----------+
| 7  | Clone Project | Diego                | prep   |            | 0/0       |
| 8  | Divide tasks  | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+---------------+----------------------+--------+------------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
> 
```

## Delete a card

If you type `delete-card ID` with a valid ID, the card with the corresponding ID
will be deleted and the board lists will be displayed again without the deleted
card.

```
> delete-card 7
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 2/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+--------------------------+----------------------+---------------------+------------+-----------+
|                                             In Progress                                             |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| ID | Title                    | Members              | Labels              | Due Date   | Checklist |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| 4  | Create List class        | Deyvi                | coding, challenge   | 2020-11-19 | 2/3       |
| 5  | Create Card class        | Wences               | coding              | 2020-11-19 | 1/4       |
| 9  | Schedule standup meeting | Diego, Wences, Deyvi | meetigns, important | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+---------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+--------------+----------------------+--------+------------+-----------+
|                                    Done                                    |
+----+--------------+----------------------+--------+------------+-----------+
| ID | Title        | Members              | Labels | Due Date   | Checklist |
+----+--------------+----------------------+--------+------------+-----------+
| 8  | Divide tasks | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+--------------+----------------------+--------+------------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
> 
```

## Create a list

If you type `create-list` the program should ask you for a Name and then create
a new List with that name. All the board Lists are displayed again showing the
new list at the end.

```
> create-list
Name: Delayed
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 2/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+--------------------------+----------------------+---------------------+------------+-----------+
|                                             In Progress                                             |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| ID | Title                    | Members              | Labels              | Due Date   | Checklist |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| 4  | Create List class        | Deyvi                | coding, challenge   | 2020-11-19 | 2/3       |
| 5  | Create Card class        | Wences               | coding              | 2020-11-19 | 1/4       |
| 9  | Schedule standup meeting | Diego, Wences, Deyvi | meetigns, important | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+---------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+--------------+----------------------+--------+------------+-----------+
|                                    Done                                    |
+----+--------------+----------------------+--------+------------+-----------+
| ID | Title        | Members              | Labels | Due Date   | Checklist |
+----+--------------+----------------------+--------+------------+-----------+
| 8  | Divide tasks | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+--------------+----------------------+--------+------------+-----------+
+----+-------+---------+--------+----------+-----------+
|                       Delayed                        |
+----+-------+---------+--------+----------+-----------+
| ID | Title | Members | Labels | Due Date | Checklist |
+----+-------+---------+--------+----------+-----------+
+----+-------+---------+--------+----------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
> 
```

## Update list

If you type `update-list LISTNAME` with a valid List Name, the program will ask
you for a new Name and update the corresponding list. All the board lists are
displayed again showing the updated name.

```
> update-list Delayed
Name: Super Delayed           
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 2/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+--------------------------+----------------------+---------------------+------------+-----------+
|                                             In Progress                                             |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| ID | Title                    | Members              | Labels              | Due Date   | Checklist |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| 4  | Create List class        | Deyvi                | coding, challenge   | 2020-11-19 | 2/3       |
| 5  | Create Card class        | Wences               | coding              | 2020-11-19 | 1/4       |
| 9  | Schedule standup meeting | Diego, Wences, Deyvi | meetigns, important | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+---------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+--------------+----------------------+--------+------------+-----------+
|                                    Done                                    |
+----+--------------+----------------------+--------+------------+-----------+
| ID | Title        | Members              | Labels | Due Date   | Checklist |
+----+--------------+----------------------+--------+------------+-----------+
| 8  | Divide tasks | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+--------------+----------------------+--------+------------+-----------+
+----+-------+---------+--------+----------+-----------+
|                    Super Delayed                     |
+----+-------+---------+--------+----------+-----------+
| ID | Title | Members | Labels | Due Date | Checklist |
+----+-------+---------+--------+----------+-----------+
+----+-------+---------+--------+----------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
>
```

## Delete list

If you type `delete-list LISTNAME` with a valid List Name, the corresponding
list will be deleted and the board lists will be displayed again without the
deleted list.

```
> delete-list Super Delayed
+----+--------------------------+----------------------+-------------+------------+-----------+
|                                            Todo                                             |
+----+--------------------------+----------------------+-------------+------------+-----------+
| ID | Title                    | Members              | Labels      | Due Date   | Checklist |
+----+--------------------------+----------------------+-------------+------------+-----------+
| 1  | Check terminal-table gem | Diego, Deyvi, Wences | investigate | 2020-11-19 | 2/3       |
| 2  | Create Manager class     |                      | Coding      | 2020-11-20 | 0/0       |
| 3  | Create JSON store        |                      | Coding      | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+-------------+------------+-----------+
+----+--------------------------+----------------------+---------------------+------------+-----------+
|                                             In Progress                                             |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| ID | Title                    | Members              | Labels              | Due Date   | Checklist |
+----+--------------------------+----------------------+---------------------+------------+-----------+
| 4  | Create List class        | Deyvi                | coding, challenge   | 2020-11-19 | 2/3       |
| 5  | Create Card class        | Wences               | coding              | 2020-11-19 | 1/4       |
| 9  | Schedule standup meeting | Diego, Wences, Deyvi | meetigns, important | 2020-11-20 | 0/0       |
+----+--------------------------+----------------------+---------------------+------------+-----------+
+----+--------------------+---------+-------------------+------------+-----------+
|                                  Code Review                                   |
+----+--------------------+---------+-------------------+------------+-----------+
| ID | Title              | Members | Labels            | Due Date   | Checklist |
+----+--------------------+---------+-------------------+------------+-----------+
| 6  | Create Board class | Diego   | coding, challenge | 2020-11-19 | 3/3       |
+----+--------------------+---------+-------------------+------------+-----------+
+----+--------------+----------------------+--------+------------+-----------+
|                                    Done                                    |
+----+--------------+----------------------+--------+------------+-----------+
| ID | Title        | Members              | Labels | Due Date   | Checklist |
+----+--------------+----------------------+--------+------------+-----------+
| 8  | Divide tasks | Diego, Wences, Deyvi | prep   | 2020-11-19 | 0/0       |
+----+--------------+----------------------+--------+------------+-----------+
List options: create-list | update-list LISTNAME | delete-list LISTNAME
Card options: create-card | checklist ID | update-card ID | delete-card ID
back
>
```

## Back to boards

If you type `back` you will return to the main menu where a table with all the
boards is displayed along with the main menu options.

```
> back
+----+------------------------+---------------------------------------+--------------------------------------------------+
|                                                      CLIn Boards                                                       |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| ID | Name                   | Description                           | List(#cards)                                     |
+----+------------------------+---------------------------------------+--------------------------------------------------+
| 1  | Extended - CLIn Boards | Task management for the last extended | Todo(3), In Progress(3), Code Review(1), Done(1) |
+----+------------------------+---------------------------------------+--------------------------------------------------+
Board options: create | show ID | update ID | delete ID
exit
>
```

## Exit the program

If you type `exit` the program will show a goodbye message and then exit.

```
> exit
####################################
#   Thanks for using CLIn Boards   #
####################################
$ 
```
