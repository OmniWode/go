pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--go

-------------------------------
-- core functions -------------
-------------------------------

function _init()
	state=0 -- title
	init_title()
end

function _update()
	if (state==0) update_title()
	if (state==1) update_game()
end

function _draw()
	if (state==0) draw_title()
	if (state==1) draw_game()
end

-------------------------------
-- title functions ------------
-------------------------------

function init_title()

end

function update_title()
	if (btnp(4)) then
		init_game(9)
	elseif (btnp(5)) then
		init_game(13)
	end
end

function draw_title()
	cls()
	print("welcome to go!",8,8,10)
	print("press ❎ (z) for 9x9",8,16,10)
	print("press 🅾️ (x) for 13x13",8,24,10)
end

-------------------------------
-- game functions -------------
-------------------------------

function init_game(size)
	state=1
	game_over=false
	board_size=size

	make_board(size)
end

function update_game()
	if (not game_over) do

	end

end

function draw_game()
	cls()
	map(0,0,0,0,128,32)

	--debug console
	draw_debug()
end

-->8
--board

function make_board(size)
	for r=1,size do
		for c=1,size do
			mset(r,c,18)
		end
	end
end

-->8
--utilities

function draw_debug()
	print("size="..(board_size),0,120,8)
end

__gfx__
00000000ffffffffffffffffffffffffffff5fffffff5fffffff5fff00000000ffffff5fffffffffffffffffffffffff00000000000000000000000000000000
00000000ffffffffffffffffffffffffffff5ffffff000fffff777ff00000000ffffff5ff5555555555555555555555f00000000000000000000000000000000
00700700ffffffffffffffffffffffffffff5fffff00000fff77777f00000000ff555f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00077000fffffffffffffffffffffffffff555fff0000000f777777700000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00077000ffff55555555555555555fff55555555500000005777777700000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00700700ffff5fffffff5fffffff5ffffff555fff0000000f777777700000000ff5fff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffff5fffffff5fffffff5fffffff5fffff00000fff77777f00000000ff55555ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffff5fffffff5fffffff5fffffff5ffffff000fffff777ff00000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
88888888ffff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
80000008ffff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
80000008ffff5fffffff5fffffff5fff00000000000000000000000000000000ff555f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
80000008ffff5fffffff5fffffff5fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
80000008ffff55555555555555555fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
80000008ffff5fffffff5fffffff5fff00000000000000000000000000000000ff5fff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
80000008ffff5fffffff5fffffff5fff00000000000000000000000000000000ff55555ff5ffffffffffffffffffff5f00000000000000000000000000000000
88888888ffff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffff5fffffff5fffffff5fff00000000000000000000000000000000ff555f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffff5fffffff5fffffff5fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffff55555555555555555fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffffffffffffffffffffffff00000000000000000000000000000000ff5fff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
00000000ffffffffffffffffffffffff00000000000000000000000000000000ff55555ff5555555555555555555555f00000000000000000000000000000000
00000000ffffffffffffffffffffffff00000000000000000000000000000000ffffff5fffffffffffffffffffffffff00000000000000000000000000000000
__gff__
0009090901020400000000000000000000090109000000000000000000000000000909090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
