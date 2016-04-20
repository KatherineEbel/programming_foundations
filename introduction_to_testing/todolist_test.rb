require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    assert(@list.size == 2)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert(@list.size == 2)
  end

  def test_done_question
    assert_equal(false, @list.done?)

  end

  def test_type_error_raised
    assert_raises(TypeError) { @list.add 1 }
    assert_raises(TypeError) { @list.add 'hi'}
  end

  def test_add_type_alias
    todo = Todo.new("Mow the lawn")
    @list << todo
    todos = @todos << todo
    assert_equal todos, @list.to_a
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at 4 }
    assert_equal(@todo1, @list.item_at(0))
  end

  def test_mark_done_title
    @list.mark_done "Buy milk"
    assert_equal(true, @todo1.done?)
  end

  def test_all_done
    @list.done!
    assert_equal(@list.to_s, @list.all_done.to_s)
  end

  def test_all_not_done
    list = @list.all_not_done
    assert_equal(list.to_s, @list.to_s)
  end

  def test_mark_done_at
    @list.mark_done_at 0
    @list.mark_done_at 1
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
    assert_raises(IndexError) { @list.mark_done_at 4 }
  end

  def test_mark_undone_at
    @list.done!
    @list.mark_undone_at 0
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_raises(IndexError) { @list.mark_undone_at 4 }
  end

  def test_mark_all_done
    @list.mark_all_done
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_mark_all_undone
    @list.done!
    undone = @list.mark_all_undone
    assert_equal(@list, undone)
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    todo = @list.remove_at 0
    assert_equal(2, @list.size)
    assert_equal(todo, @todo1)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_for_one_checked_item
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at 0
    assert_equal output, @list.to_s
  end

  def test_to_s_for_all_checked_items
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal output, @list.to_s
  end

  def test_each_is_iterating
    result = []
    @list.each { |todo| result << todo }
    assert_equal(@todos, result)
  end

  def test_each_returns_original_object
    list = @list.each { |todo| nil }
    assert_same(@list, list)
  end

  def test_select
    @todo1.done!
    list = TodoList.new @list.title
    list.add @todo1

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select { |todo| todo.done? }.to_s)
  end
end
