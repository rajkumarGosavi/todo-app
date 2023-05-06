module repo

import todo

pub struct TodosStore {
pub mut:
	todos []todo.Todo
}

// should return proper error
pub fn (mut ts TodosStore) add_todo(td todo.Todo) {
	mut t := td
	t.id = ts.todos.len + 1
	ts.todos << t
}

// should return proper error
pub fn (mut ts TodosStore) remove_todo(id int) {
	ts.todos[id - 1].is_deleted = !ts.todos[id - 1].is_deleted
}

// should return proper error
pub fn (mut ts TodosStore) complete_todo(id int) {
	ts.todos[id - 1].is_completed = !ts.todos[id - 1].is_completed
}

pub fn (ts TodosStore) search_todo(txt string) []todo.Todo {
	mut results := []todo.Todo{}
	for td in ts.todos {
		if td.title.contains(txt) || td.description.contains(txt) {
			results << td
		}
	}

	return results
}

// should return proper error
pub fn (mut ts TodosStore) update_todo(td todo.Todo) {
	ts.todos[td.id - 1] = td
}

pub fn (ts TodosStore) get_all_todos() []todo.Todo {
	return ts.todos
}

fn (ts TodosStore) get_todo(id int) ?todo.Todo {
	if ts.todos.len >= id {
		return none
	}

	return ts.todos[id - 1]
}
