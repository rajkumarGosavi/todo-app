module repo

import todo

fn test_add_todo() {
	td := todo.Todo{
		description: 'desc'
		title: 'title1'
	}

	mut ts := TodosStore{
		todos: []todo.Todo{}
	}

	ts.add_todo(td)

	assert ts.todos.len == 1
	assert ts.todos[0].title == 'title1'

	td2 := todo.Todo{
		description: 'desc2'
		title: 'title2'
	}

	ts.add_todo(td2)

	assert ts.todos.len == 2
}

fn test_remove_todo() {
	td := todo.Todo{
		description: 'desc'
		title: 'title1'
	}

	mut ts := TodosStore{
		todos: []todo.Todo{}
	}

	ts.add_todo(td)

	ts.remove_todo(1)

	assert ts.todos[0].is_deleted == true
}

fn test_complete_todo() {
	td := todo.Todo{
		description: 'desc'
		title: 'title1'
	}

	mut ts := TodosStore{
		todos: []todo.Todo{}
	}

	ts.add_todo(td)

	ts.complete_todo(1)

	assert ts.todos[0].is_completed == true

	ts.complete_todo(1)

	assert ts.todos[0].is_completed == false
}

fn test_get_all_todos() {
	td := todo.Todo{
		description: 'desc'
		title: 'title1'
	}

	mut ts := TodosStore{
		todos: []todo.Todo{}
	}
	assert ts.get_all_todos().len == 0

	ts.add_todo(td)

	assert ts.get_all_todos().len == 1
	assert ts.todos[0].title == 'title1'
}

fn test_get_todo() {
	td := todo.Todo{
		description: 'desc'
		title: 'title1'
	}

	mut ts := TodosStore{
		todos: []todo.Todo{}
	}

	assert ts.todos.len == 0
	assert ts.get_todo(5) == none

	ts.add_todo(td)

	if gtd := ts.get_todo(1) {
		assert gtd.title == 'title1'
	}
}

fn test_update_todo() {
	td := todo.Todo{
		description: 'desc'
		title: 'title1'
	}

	mut ts := TodosStore{
		todos: []todo.Todo{}
	}

	ts.add_todo(td)

	mut td2 := ts.todos[0]
	td2.title = 'updated title'

	ts.update_todo(td2)

	assert ts.todos[0].title == td2.title
}
