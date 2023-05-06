module repo

import todo

pub type TodosStore = []todo.Todo

// should return proper error
pub fn (mut ts TodosStore) add_todo(td todo.Todo) {
	mut t := td
	t.id = ts.len + 1
	ts << t
}

// should return proper error
pub fn (mut ts TodosStore) remove_todo(id int) {
	ts[id - 1].is_deleted = !ts[id - 1].is_deleted
}

// should return proper error
pub fn (mut ts TodosStore) complete_todo(id int) {
	ts[id - 1].is_completed = !ts[id - 1].is_completed
}

pub fn (ts TodosStore) search_todo(txt string) []todo.Todo {
	mut results := []todo.Todo{}
	for td in ts {
		if td.title.contains(txt) || td.description.contains(txt) {
			results << td
		}
	}

	return results
}

// should return proper error
pub fn (mut ts TodosStore) update_todo(td todo.Todo) {
	ts[td.id - 1] = td
}

pub fn (ts TodosStore) get_all_todos() []todo.Todo {
	return ts
}

fn (ts TodosStore) get_todo(id int) ?todo.Todo {
	if ts.len >= id {
		return none
	}

	return ts[id - 1]
}
