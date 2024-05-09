module main

import veb

pub struct Context {
	veb.Context
}

pub struct App {
}

@[get; post]
pub fn (app &App) index(mut ctx Context) veb.Result {
	echo := '-------- ${ctx.ip()} --------\n'
		+ '--- url\n'
		+ '${ctx.req.url}\n'
		+ '--- header\n'
		+ '${ctx.req.header.str().trim("\n")}\n'
		+ '--- data\n'
		+ '${ctx.req.data.trim("\n")}\n'
		+ '--------\n'
	println(echo)
	return ctx.text(echo)
}

fn main() {
	mut app := &App{}
	veb.run[App, Context](mut app, 8080)
}
