import ui
import gg
import gx
import os

const (
	win_width   = 780
	win_height  = 385
	nr_cols     = 2
	cell_height = 25
	cell_width  = 100
	table_width = cell_width * nr_cols
)

struct Todo {
	title       string
	description string
}

[heap]
struct State {
mut:
	title       string
	description string
	todos       []Todo
	window      &ui.Window = unsafe { nil }
	label       &ui.Label
	txt_pos     int
	started     bool
	is_error    bool
}

fn main() {
	mut logo := os.resource_abs_path(os.join_path('../assets/img', 'logo.png'))
	$if android {
		logo = 'img/logo.png'
	}
	mut app := &State{
		todos: []
		label: ui.label(text: 'TODOS: 0')
	}
	window := ui.window(
		width: win_width
		height: win_height
		title: 'V UI Demo'
		// bg_color: gx.light_blue
		children: [
			ui.row(
				margin: ui.Margin{10, 10, 10, 10}
				widths: [200.0, ui.stretch]
				spacing: 30
				children: [
					ui.column(
						spacing: 13
						children: [
							ui.textbox(
								max_len: 50
								width: 200
								placeholder: 'Title'
								text: &app.title
								// is_focused: &app.started
								is_error: &app.is_error
								is_focused: true
							),
							ui.textbox(
								max_len: 150
								width: 200
								placeholder: 'Description'
								text: &app.description
								is_error: &app.is_error
							),
							ui.row(
								spacing: 65
								widths: ui.compact
								children: [
									ui.button(
										text: 'Add todo'
										on_click: app.btn_add_click
									),
									ui.button(
										text: '?'
										on_click: btn_help_click
									),
								]
							),
							ui.row(
								spacing: 5
								children: [
									app.label,
								]
							),
						]
					),
					ui.column(
						alignments: ui.HorizontalAlignments{
							center: [
								0,
							]
							right: [
								1,
							]
						}
						widths: [
							ui.stretch,
							ui.compact,
						]
						heights: [
							ui.stretch,
							100.0,
						]
						children: [
							ui.canvas(
								width: 400
								height: 275
								draw_fn: app.canvas_draw
							),
							ui.picture(
								width: 100
								height: 100
								path: logo
							),
						]
					),
				]
			),
			// ui.menu(
			// 	items: [ui.MenuItem{'Delete all users', menu_click},
			// 		ui.MenuItem{'Export users', menu_click}, ui.MenuItem{'Exit', menu_click}]
			// ),
		]
	)
	app.window = window
	ui.run(window)
}

// fn menu_click() {
// }

fn btn_help_click(b voidptr) {
	ui.message_box('Built with V UI')
}

fn (mut app State) btn_add_click(b &ui.Button) {
	// println('nr todos=$app.todos.len')
	// ui.notify('todo', 'done')
	// app.window.set_cursor(.hand)
	if app.title == '' {
		app.is_error = true
		return
	}
	new_todo := Todo{
		title: app.title // .text
		description: app.description // .text
	}
	app.todos << new_todo
	app.title = ''
	app.description = ''
	app.label.set_text('${app.todos.len}')
	// ui.message_box('$new_todo.title has been added')
}

fn (app &State) canvas_draw(gg_ &gg.Context, c &ui.Canvas) { // x_offset int, y_offset int) {
	x_offset, y_offset := c.x, c.y
	w, h := c.width, c.height
	x := x_offset
	gg_.draw_rect_filled(x - 20, 0, w + 120, h + 120, gx.white)

	gg_.draw_rect_empty(x, y_offset, table_width, cell_height, gx.gray)
	gg_.draw_line(x + cell_width, y_offset, x + cell_width, y_offset + cell_height, gx.gray)
	// gg_.draw_line(x + cell_width * 2, y_offset, x + cell_width, y_offset + cell_height, gx.gray)

	gg_.draw_text_def(x + 5, y_offset + 5, 'Title')
	gg_.draw_text_def(x + 5 + cell_width, y_offset + 5, 'Description')

	for i, todo in app.todos {
		y := y_offset + 20 + i * cell_height
		// Outer border
		gg_.draw_rect_empty(x, y, table_width, cell_height, gx.gray)
		// Vertical separators
		gg_.draw_line(x + cell_width, y, x + cell_width, y + cell_height, gx.gray)
		gg_.draw_line(x + cell_width * 2, y, x + cell_width * 2, y + cell_height, gx.gray)
		// Text values
		gg_.draw_text_def(x + 5, y + 5, todo.title)
		gg_.draw_text_def(x + 5 + cell_width, y + 5, todo.description)
	}
}
