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
	
	current_turn=black
end

function update_game()
	if (not game_over) do
		--game loop
		move_cursor(cursor)

		if (btnp(5)) then
			place_stone(cursor)
		end
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

function place_stone(cursor)

	--replace this with valid_placement(current_turn, cursor)
	--then use place_stone function to test for edges and
	--assign correct sprite to mapm then change turn

	--[[if (is_tile(empty,cursor.x,cursor.y)) then
		if (current_turn==black) then
			mset(cursor.x/8,cursor.y/8,22)
		else
			mset(cursor.x/8,cursor.y/8,26)
		end


		if (current_turn==black) then
			current_turn=white
		else
			current_turn=black
		end
	end]]

	stone_spr=get_stone_spr(cursor)

	if (valid_move(cursor)) then
		--if (current_turn==black) then
		--	  mset(cursor.x/8,cursor.y/8,22)
		--else
		--	  mset(cursor.x/8,cursor.y/8,26)
		--end

		mset(cursor.x/8,cursor.y/8,stone_spr)

		swap_turn()
	end

end

function valid_move(cursor)
	if (is_tile(empty,cursor.x,cursor.y)) return true
	
	--add to check for komi, etc

	return false
end

function swap_turn()
	if (current_turn==black) then
			current_turn=white
		else
			current_turn=black
		end
end

function get_stone_spr(cursor)
	x=cursor.x/8
	y=cursor.y/8

	stone_spr=0

	if (y==1) then --top border
		if (x==1) then
			stone_spr=5
		elseif (x==size) then
			stone_spr=7
		else
			stone_spr=6
		end
	elseif (y==size) then
		if (x==1) then --bottom border
			stone_spr=37
		elseif (x==size) then
			stone_spr=39
		else
			stone_spr=38
		end
	elseif (x==1) then --left border
		stone_spr=21
	elseif (x==size) then --right border
		stone_spr=23
	else
		stone_spr=22 --interior points
	end

	if (current_turn==white) then
		stone_spr+=4
	end

	return stone_spr

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
	
	--print("left="..tostr(is_tile(3,cursor.x,cursor.y)),0,120,8)
	print("cur.x="..cursor.x,48,2,8)
	print("cur.y="..cursor.y,84,2,8)

	print("turn="..current_turn,0,2,8)
end

__gfx__
00000000111111111111111111111111000000001111111111111111111111110000000011111111111111111111111100000000000000000000000000000000
000000001fffffffffffffffffffffff000000001ff000fffff000fffff000ff000000001ff777fffff777fffff777ff00000000000000000000000000000000
007007001fffffffffffffffffffffff000000001f00000fff00000fff00000f000000001f77777fff77777fff77777f00000000000000000000000000000000
000770001fffffffffffffffffffffff0000000010000000f0000000f00000000000000017777777f7777777f777777700000000000000000000000000000000
000770001fff55555555555555555fff000000001000000050000000500000000000000017777777577777775777777700000000000000000000000000000000
007007001fff5fffffff5fffffff5fff0000000010000000f0000000f00000000000000017777777f7777777f777777700000000000000000000000000000000
000000001fff5fffffff5fffffff5fff000000001f00000fff00000fff00000f000000001f77777fff77777fff77777f00000000000000000000000000000000
000000001fff5fffffff5fffffff5fff000000001ff000fffff000fffff000ff000000001ff777fffff777fffff777ff00000000000000000000000000000000
000000001fff5fffffff5fffffff5fff000000001fff5fffffff5fffffff5fff000000001fff5fffffff5fffffff5fff00000000000000000000000000000000
088888881fff5fffffff5fffffff5fff000000001ff000fffff000fffff000ff000000001ff777fffff777fffff777ff00000000000000000000000000000000
080000081fff5fffffff5fffffff5fff000000001f00000fff00000fff00000f000000001f77777fff77777fff77777f00000000000000000000000000000000
080000081fff5fffffff5fffffff5fff0000000010000000f0000000f00000000000000017777777f7777777f777777700000000000000000000000000000000
080000081fff55555555555555555fff000000001000000050000000500000000000000017777777577777775777777700000000000000000000000000000000
080000081fff5fffffff5fffffff5fff0000000010000000f0000000f00000000000000017777777f7777777f777777700000000000000000000000000000000
080000081fff5fffffff5fffffff5fff000000001f00000fff00000fff00000f000000001f77777fff77777fff77777f00000000000000000000000000000000
088888881fff5fffffff5fffffff5fff000000001ff000fffff000fffff000ff000000001ff777fffff777fffff777ff00000000000000000000000000000000
ffff5fff1fff5fffffff5fffffff5fff000000001fff5fffffff5fffffff5fff000000001fff5fffffff5fffffff5fff00000000000000000000000000000000
ffff5fff1fff5fffffff5fffffff5fff000000001ff000fffff000fffff000ff000000001ff777fffff777fffff777ff00000000000000000000000000000000
ffff5fff1fff5fffffff5fffffff5fff000000001f00000fff00000fff00000f000000001f77777fff77777fff77777f00000000000000000000000000000000
fff555ff1fff5fffffff5fffffff5fff0000000010000000f0000000f00000000000000017777777f7777777f777777700000000000000000000000000000000
555555551fff55555555555555555fff000000001000000050000000500000000000000017777777577777775777777700000000000000000000000000000000
fff555ff1fffffffffffffffffffffff0000000010000000f0000000f00000000000000017777777f7777777f777777700000000000000000000000000000000
ffff5fff1fffffffffffffffffffffff000000001f00000fff00000fff00000f000000001f77777fff77777fff77777f00000000000000000000000000000000
ffff5fff1fffffffffffffffffffffff000000001ff000fffff000fffff000ff000000001ff777fffff777fffff777ff00000000000000000000000000000000
__gff__
00292131002a2232002c24340000000000090111000a0212000c04140000000001494151004a4252004c4454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
