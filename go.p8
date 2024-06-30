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
	--not sure if i need anything here?
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
	cursor={x=8,y=8}

	--sprite flags
	empty=0
	black=1
	white=2

	left=3
	right=4
	top=5
	bottom=6

	make_board(size)
end

function update_game()
	if (not game_over) do
		--game loop
		move_cursor(cursor)
	end

end

function draw_game()
	cls(1)
	map(0,0,0,0,128,32)

	draw_cursor(cursor)

	--debug console
	draw_debug()
end

-->8
--board

function make_board(size)
	for x=1,size do
		for y=1,size do

			if (y==1) then --top border
				if (x==1) then
					mset(x,y,1)
				elseif (x==size) then
					mset(x,y,3)
				else
					mset(x,y,2)
				end
			elseif (y==size) then
				if (x==1) then --bottom border
					mset(x,y,33)
				elseif (x==size) then
					mset(x,y,35)
				else
					mset(x,y,34)
				end
			elseif (x==1) then --left border
				mset(x,y,17)
			elseif (x==size) then --right border
				mset(x,y,19)
			else
				mset(x,y,18) --interior points
			end

		end --for y
	end --for x
end--make_board

function move_cursor(cursor)
	if (btnp(0)) then
		if (not is_tile(left,cursor.x,cursor.y)) cursor.x-=8
	elseif (btnp(1)) then
		if (not is_tile(right,cursor.x,cursor.y)) cursor.x+=8
	elseif (btnp(2)) then
		if (not is_tile(top,cursor.x,cursor.y)) cursor.y-=8
	elseif (btnp(3)) then
		if (not is_tile(bottom,cursor.x,cursor.y)) cursor.y+=8
	end
end

function draw_cursor(cursor)
	spr(16,cursor.x,cursor.y)
end

-->8
--utilities

function is_tile(tile_type,x,y)
	tile=mget(x/8,y/8)
	has_flag=fget(tile,tile_type)
	return has_flag
end


function draw_debug()
	--print("size="..(board_size),0,120,8)
	print("left="..tostr(is_tile(3,cursor.x,cursor.y)),0,120,8)
	print("cur.x="..cursor.x,48,120,8)
	print("cur.y="..cursor.y,84,120,8)
end

__gfx__
00000000111111111111111111111111ffff5fffffff5fffffff5fff00000000ffffff5fffffffffffffffffffffffff00000000000000000000000000000000
000000001fffffffffffffffffffffffffff5ffffff000fffff777ff00000000ffffff5ff5555555555555555555555f00000000000000000000000000000000
007007001fffffffffffffffffffffffffff5fffff00000fff77777f00000000ff555f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000770001ffffffffffffffffffffffffff555fff0000000f777777700000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000770001fff55555555555555555fff55555555500000005777777700000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
007007001fff5fffffff5fffffff5ffffff555fff0000000f777777700000000ff5fff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fffffff5fffff00000fff77777f00000000ff55555ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fffffff5ffffff000fffff777ff00000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
088888881fff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
080000081fff5fffffff5fffffff5fff00000000000000000000000000000000ff555f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
080000081fff5fffffff5fffffff5fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
080000081fff55555555555555555fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
080000081fff5fffffff5fffffff5fff00000000000000000000000000000000ff5fff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
080000081fff5fffffff5fffffff5fff00000000000000000000000000000000ff55555ff5ffffffffffffffffffff5f00000000000000000000000000000000
088888881fff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fff00000000000000000000000000000000ffffff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fff00000000000000000000000000000000ff555f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fff55555555555555555fff00000000000000000000000000000000ff5f5f5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fffffffffffffffffffffff00000000000000000000000000000000ff5fff5ff5ffffffffffffffffffff5f00000000000000000000000000000000
000000001fffffffffffffffffffffff00000000000000000000000000000000ff55555ff5555555555555555555555f00000000000000000000000000000000
000000001fffffffffffffffffffffff00000000000000000000000000000000ffffff5fffffffffffffffffffffffff00000000000000000000000000000000
__gff__
0029213101020400000000000000000000090111000000000000000000000000004941510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
