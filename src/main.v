module main

import veb
import os
import time

pub struct Context {
	veb.Context
}

pub struct App {
}

@[get; post]
pub fn (app &App) history(mut ctx Context) veb.Result {
	echo := 'STARTDELIM ------------------------------------------ ENDDELIM\n' +
		'-------------------- ${ctx.ip()} ----------------------\n' +
		'-------------------- date\n' + '${time.now()}\n' +
		'-------------------- header\n' + '${ctx.req.header.str().trim('\n')}\n' +
		'-------------------- data\n' + '${ctx.req.data.trim('\n')}\n' +
		'------------------------------------------\n'
	file_out := os.getenv_opt('ECHOLISTEN_HISTORY_ROUTE') or { '/tmp/echolisten_history_route' }
	mut f := os.open_append(file_out) or { return ctx.text(echo + 'ERR') }
	defer {
		f.close()
	}
	f.writeln(echo) or { return ctx.text(echo + 'ERR') }
	println('+1 ${ctx.ip()}')
	return ctx.text(echo)
}

@[get; post]
pub fn (app &App) history_result(mut ctx Context) veb.Result {
	file_out := os.getenv_opt('ECHOLISTEN_HISTORY_ROUTE') or { '/tmp/echolisten_history_route' }
	echo := os.read_file(file_out) or { return ctx.text('ERR') }
	return ctx.text(echo)
}

@[get; post]
pub fn (app &App) index(mut ctx Context) veb.Result {
	return ctx.text("If it is the author that curl'd it on your machine, it is intended as a joke. If it is someone else, the author will not sell/use the data given. Sorry.")
}

fn main() {
	mut app := &App{}
	veb.run[App, Context](mut app, 8080)
}
