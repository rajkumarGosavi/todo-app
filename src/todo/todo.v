module todo

pub struct Todo {
pub mut:
	id           int // for now it is mutable once moved to db it will be pub
	is_deleted   bool
	is_completed bool
	description  string
	title        string
}
