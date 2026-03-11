pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- tool by lazy devs
function _init()
	palt(0, false)
	palt(12, true)
	load_stored_gfx(story_gfx)
 --- customize here ---
 #include data/myspr.txt
 file="data/myspr.txt"
 arrname="myspr"
 data=myspr
 reload(0x0,0x0,0x2000,"jam.p8")
 ----------------------

 debug={}
 msg={}

 _drw=draw_list
 _upd=update_list

 menuitem(1,"export",export)


 curx=1
 cury=1
 scrolly=0
 scrollx=0

 poke(0x5f2d, 1)
end

function _draw()
 _drw()

 if #msg>0 then
  bgprint(msg[1].txt,64-#msg[1].txt*2,80,14)
  msg[1].t-=1
  if msg[1].t<=0 then
   deli(msg,1)
  end
 end

 -- debug --
 cursor(4,4)
 color(8)
 for txt in all(debug) do
  print(txt)
 end
end

function _update60()
 dokeys()
 mscroll=stat(36)

 _upd()
end

function dokeys()
 if stat(30) then
  key=stat(31)
  if key=="p" then
   poke(0x5f30,1)
  end
 else
  key=nil
 end

end

--gfx import runtime begin.
--
--copy and paste this into your
--game cart.
--example usage after "end".
--

-- converts hex string
-- to actual number
function hex2num(str)
    return ("0x" .. str) + 0
end

--call this when you want to
--load your fullscreen
--graphics.
--this assumes a compressed
--format of <cnt>..<color>..
function load_stored_gfx(gfx)
    index = 0
    for i = 1, #gfx, 2 do
        cnt = hex2num(sub(gfx, i, i))
        local col = hex2num(sub(gfx, i + 1, i + 1))
        for j = 1, cnt do
            sset((index) % 128, flr((index) / 128), col)
            index += 1
        end
    end
end

--call this to go back to
--the original graphics stored
--on the cart.
--eg.after displaying title
--screen.
function restore_gfx()
    reload(0x0, 0x0, 0x2000)
end

--
--gfx import runtime end.
--
story_gfx =
"fcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfc9cf0f0f0306cf0f0f030fcbc10fefefe1e106c10fefefe1e10fcbc108e77fefe1e106c108efb8bfe10fcbc107e27161716171627fefe106c107e1bf7871bee10fcbc107e27161716171627fefe106c107e1bf7871bee10fcbc108e17161716171617fefe1e106c107e1b372017201720172027201730171bee10fcbc108e17161716171617fefe1e106c107e1b3710271027102710171017103710271bee10fcbc108e17161716171617fefe1e106c107e1b372017201710272027202710271bee10fcbc108e17161716171617fefe1e106c107e1b4710171027102710171017103710371bde10fcbc108e79fefe1e106c108e1b2720172017201710171017202710371bde10fcbc107e393f39fe1e707e106c108e1bf7871bde10fcbc106e395f39fe1f706e106c108e1b272027201720171017301720371bde10fcbc105e391f17102f101729fe3f605e106c108e1b27101710171027102710171017101710471bde10fcbc105e391f17102f101729ee10174f405e106c108e1b272027201710271017301720371bde10fcbc104e492f1c2f1c1f19fe10174f405e106c108e1b2710171017102710271017103710471bde10fcbc103e193e271c57194fae8f305e106c108e1b2710171017201720171017103720371bde10fcbc106e5712171c272e3f108e9f205e106c108e1bf7871bde10fcbc105eb7191e3f307e9f105e106c108e1bf7871bde10fcbc105e6712572e607e9f5e106c108e1bf7871bde10fcbc105e271e671e273e704eb04e106c108e1b2730172047202740371bde10fcbc105e271e671e274ef0703e106c108e1b5710271027103710771bde10fcbc105e271e671e275ef0702e106c108e1bf7871bde10fcbc105e271e671e276ef0701e106c108e1bf7871bde10fcbc105e171f1e671e277ef0601e106c108e1bf7871bde10fcbc105e2f1e671e2f9ef0401e106c108e1b572b372b271b272b171b271bde10fcbc106e1f1e602e1fbef0201e106c108e1b471b271b472b571b371bde10fcbc108e60eef0406c109e1bf7871bce10fcbc108e60eef0406c109e1bf7871bce10fcbc108e60eef0406c109e1b371017202710172037201710371bce10fcbc108e60eef0406c109e1b471057107710471bce10fcbc108e60eef0101e206c109e1bf7871bce10fcbcf0f0f0306cf0f0f030fcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfc8cf0f0f0306cf0f0f030fcbc10fe5e77fe4e106c10ce10f66610be10fcbc10fe4e27161716171627fe3e106c10be10f68610ae10fcbc10fe4e27161716171627fe3e106c10be1046f04610ae10fcbc10fe5e17161716171617fe4e106c10be103610f5103610ae10fcbc10fe5e17161716171617fe4e106c10be1026107514351b55102610ae10fcbc10fe5e17161716171617fe4e106c10be102610451b1514751b25102610ae10fcbc10fe5e17161716171617fe4e106c10be10261055141914651425102610ae10fcbc10fe5e79fe4e106c10be102610251415143914151425141925102610ae10fcbc10fe4e392f49fe3e106c10be102610351459141914151435102610ae10fcbc10fe3e394f49fe2e106c10be10363514191a191a14191a1924353610ae10fcbc10fe3e2917102f101739fe2e106c10be10463514191b391b1a1914254610ae10fcbc10fe2e3917102f101739fe2e106c10be20561514192a192a29145620ae10fcbc10fe2e396f39fe2e106c10be30f64630ae10fcbc10fe1e496f49fe1e106c10be70b670ae10fcbc10fe192e1987191e19fe1e106c10be1066b06610ae10fcbc10fe2e195712472e19fe106c10be2034e03430ae10fcbc10fe3ea719fe2e106c10be10161b29e61b19241610ae10fcbc10fe3e571247fe3e106c10bef0a0ae10fcbcf040374037f0406c10be10568456342610ae10fcbc10f434374437f434106c10be5014495430293420ae10fcbc10f4443714193719848224106c10be104614191b295436191b341610ae10fcbc10f4242d3f2d3f2df424106c10be50a4a0ae10fcbc10d4422d3f2d3f2df424106c10be10f68610ae10fcbc1024926419141b191b491b19a284106c10bef0a0ae10fcbc10f4341b291b391b29f434106c10be10f58510ae10fcbc10f454391b291bf444106c10be10f58510ae10fcbc10f434193449241bf424106c10be10f58510ae10fcbc10548244321b3219a49224106c10be10f58510ae10fcbc10f4741bf484106c10be10f58510ae10fcbc10f4f4f414106c10be10f58510ae10fcbcf0f0f0306cf0f0f030fcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcacf0f0f030fcfcfcfcfc5c10f8f8f81810fcfcfcfcfc5c10f8f8f81810fcfcfcfcfc5c10f8f8f81810fcfcfcfcfc5c10f8f8f81810fcfcfcfcfc5c109877f8f810fcfcfcfcfc5c108827161716171627f8e810fcfcfcfcfc5c108827161716171627f8529810fcfcfcfcfc5c109817161716171617e82249a210fcfcfcfcfc5c109817161716171617d822699210fcfcfcfcfc5c109817161716171617d812799210fcfcfcfcfc5c109817161716171617c814191b591b198210fcfcfcfcfc5c109879c814192b392b198210fcfcfcfcfc5c108889c814192b292b29424410fcfcfcfcfc5c1078792fc814591b497410fcfcfcfcfc5c10787917101fb814a97410fcfcfcfcfc5c10787917102fa814791b297410fcfcfcfcfc5c1078793fb814191b191b292b297410fcfcfcfcfc5c1078793fb814192b193b397410fcfcfcfcfc5c10681918692fc812a97210fcfcfcfcfc5c106819186917e8f22210fcfcfcfcfc5c106819186927f8f810fcfcfcfcfc5c1088273947f8e810fcfcfcfcfc5c1078373947f8e810fcfcfcfcfc5c1078473947f8d810fcfcfcfcfc5c10686719271837f8c810fcfcfcfcfc5c106827186728371f6df84810fcfcfcfcfc5c106827186748171fcdd810fcfcfcfcfc5c10682f1860c86dd810fcfcfcfcfc5c108880f8f810fcfcfcfcfc5c1088302830f8f810fcfcfcfcfc5cf0f0f030fcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfc"

-->8
--draw
function draw_edit()
 -- background
 fillp(0b11001100001100111100110000110011)
 rectfill(0,0,127,127,33)
 fillp(▒)
 line(63,0,63,127,13)
 line(0,63,127,63,13)
 fillp()

 draw_menu()

 -- draw sprite
 if selspr then
  wrapmspr(selspr,63,63)
 end

 -- blinking dot
 if (time()*2)%1<0.5 then
  pset(63,63,rnd({8,13,7,15}))
 end
end

function draw_list()
 fillp(0b11001100001100111100110000110011)
 rectfill(0,0,127,127,33)
 fillp(▒)
 line(63,0,63,127,13)
 line(0,63,127,63,13)
 fillp()

 draw_menu()

 -- draw sprite
 local mymnu=menu[cury][curx]
 if mymnu then
  wrapmspr(mymnu.cmdy,63,63)
 end

 if (time()*2)%1<0.5 then
  pset(63,63,rnd({8,13,7,15}))
 end
end

function draw_table()
 cls(2)
 draw_menu()
end

function draw_menu()

 --spr(0,0,0,16,16)

	if menu then
		for i=1,#menu do
		 for j=1,#menu[i] do
		  local mymnu=menu[i][j]
		  local c=mymnu.c or 13
		  if i==cury and j==curx then
		   c=7
		   if _upd==upd_type then
		    c=0
		   end
		  end

		  bgprint(mymnu.w,mymnu.x+scrollx,mymnu.y+scrolly,13)
		  bgprint(mymnu.txt,mymnu.x+scrollx,mymnu.y+scrolly,c)
		 end
		end
 end

 if _upd==upd_type then
  local mymnu=menu[cury][curx]

  local txt_bef=sub(typetxt,1,typecur-1)
  local txt_cur=sub(typetxt,typecur,typecur)
  local txt_aft=sub(typetxt,typecur+1)
  txt_cur=txt_cur=="" and " " or txt_cur

  if (time()*2)%1<0.5 then
   txt_cur="\^i"..txt_cur.."\^-i"
  end

  local txt=txt_bef..txt_cur..txt_aft
		bgprint(txt,mymnu.x+scrollx,mymnu.y+scrolly,7)
 end

end


-->8
--update
function update_edit()
 refresh_edit()

 if btnp(⬆️) then
  cury-=1
 end
 if btnp(⬇️) then
  cury+=1
 end
 cury=(cury-1)%#menu+1
 cury-=mscroll
 cury=mid(1,cury,#menu)

 if cury==1 then
  curx=1
  if btnp(⬅️) then
   selspr-=1
  elseif btnp(➡️) then
   selspr+=1
  end
  selspr=mid(1,selspr,#data)
 elseif cury==10 then
  curx=1
 else
  curx=2
 end

 if btnp(🅾️) then
  _drw=draw_list
  _upd=update_list
  refresh_list()
  cury=selspr
  curx=1
  scrolly=0
  scrollx=0
  return
 end

 if btnp(❎) then
  local mymnu=menu[cury][curx]
  if mymnu.cmd=="editval" then
   _upd=upd_type
 	 local s=tostr(data[mymnu.cmdy][mymnu.cmdx])
   if s=="[nil]" or s==nil then
    s=""
   end
   typetxt=s
   typecur=#typetxt+1
   typecall=enter_edit
  elseif mymnu.cmd=="delspr" then
			deli(data,selspr)
			selspr-=1
			if selspr==0 then
			 selspr=1
			end
			_drw=draw_list
			_upd=update_list
			refresh_list()
			cury=selspr
			curx=1
			scrolly=0
			scrollx=0
			return
  end
 end
end

function update_list()
 refresh_list()
 if btnp(⬆️) then
  cury-=1
 end
 if btnp(⬇️) then
  cury+=1
 end
 cury=(cury-1)%#menu+1
 cury-=mscroll
 cury=mid(1,cury,#menu)

 curx=1

 local mymnu=menu[cury][curx]
 if mymnu.y+scrolly>110 then
  scrolly-=4
 end
 if mymnu.y+scrolly<10 then
  scrolly+=4
 end
 scrolly=min(0,scrolly)

 if mymnu.x+scrollx>110 then
  scrollx-=2
 end
 if mymnu.x+scrollx<20 then
  scrollx+=2
 end
 scrollx=min(0,scrollx)

 if btnp(❎) then
  local mymnu=menu[cury][curx]
  if mymnu.cmd=="newline" then
   add(data,{0,0,0,0,0,0})
  elseif mymnu.cmd=="editspr" then
   selspr=mymnu.cmdy
   _upd=update_edit
   _drw=draw_edit
   scrolly=0
   scrollx=0
   refresh_edit()
   cury=1
  end
 end
end

function update_table()
 refresh_table()

 if btnp(⬆️) then
  cury-=1
 end
 if btnp(⬇️) then
  cury+=1
 end
 cury=(cury-1)%#menu+1
 cury-=mscroll
 cury=mid(1,cury,#menu)

 if btnp(⬅️) then
  curx-=1
 end
 if btnp(➡️) then
  curx+=1
 end
 if cury<#menu then
  curx=(curx-2)%(#menu[cury]-1)+2
 else
  curx=1
 end
 local mymnu=menu[cury][curx]
 if mymnu.y+scrolly>110 then
  scrolly-=4
 end
 if mymnu.y+scrolly<10 then
  scrolly+=4
 end
 scrolly=min(0,scrolly)

 if mymnu.x+scrollx>110 then
  scrollx-=2
 end
 if mymnu.x+scrollx<20 then
  scrollx+=2
 end
 scrollx=min(0,scrollx)

 if btnp(❎) then
  local mymnu=menu[cury][curx]
  if mymnu.cmd=="edit" then
   _upd=upd_type
   typetxt=tostr(mymnu.txt)
   typecur=#typetxt+1
   typecall=enter_table
  elseif mymnu.cmd=="newline" then
   add(data,{0})
  elseif mymnu.cmd=="newcell" then
   add(data[mymnu.cmdy],0)
  end
 end
end

function upd_type()
 if key then
  if key=="\r" then
   -- enter
   poke(0x5f30,1)
   typecall()
   return
  elseif key=="\b" then
   --backspace
   if typecur>1 then
    if typecur>#typetxt then
	    typetxt=sub(typetxt,1,#typetxt-1)
	   else
			  local txt_bef=sub(typetxt,1,typecur-2)
			  local txt_aft=sub(typetxt,typecur)
			  typetxt=txt_bef..txt_aft
	   end
	   typecur-=1
   end
  else
   if typecur>#typetxt then
    typetxt..=key
   else
		  local txt_bef=sub(typetxt,1,typecur-1)
		  local txt_aft=sub(typetxt,typecur)
		  typetxt=txt_bef..key..txt_aft
   end
   typecur+=1
  end
 end

 if btnp(⬅️) then
  typecur-=1
 end
 if btnp(➡️) then
  typecur+=1
 end
 typecur=mid(1,typecur,#typetxt+1)
end
-->8
--tools

function bgprint(txt,x,y,c)
 print("\#0"..txt,x,y,c)
end

function split2d(s)
 local arr=split(s,"|",false)
 for k, v in pairs(arr) do
  arr[k] = split(v)
 end
 return arr
end

function wrapmspr(si,sx,sy)
 if si==nil then
  bgprint("[nil]",sx-5*2+1,sy-2,14)
  return
 end
 if myspr[si]==nil then
  bgprint("["..si.."]",sx-5*2+1,sy-2,14)
  return
 end

 local ms=myspr[si]

 if ms[8] then
  --check for loops
  if ms[8]==si then
   bgprint("[loop]",sx-6*2+1,sy-2,14)
   return
  else
   if checkloop(ms,10) then
    bgprint("[loop]",sx-6*2+1,sy-2,14)
    return
   end
  end
 end
 mspr(si,sx,sy)
end

function checkloop(ms,depth)
 depth-=1
 if depth<=0 then
  return true
 end

 if ms==nil then
  return true
 end

 if ms[8] then
  return checkloop(myspr[ms[8]],depth)
 else
  return false
 end
end

function mspr(si,sx,sy)
 local ms=myspr[si]
 sspr(ms[1],ms[2],ms[3],ms[4],sx-ms[5],sy-ms[6],ms[3],ms[4],ms[7]==1)
 if ms[7]==2 then
  sspr(ms[1],ms[2],ms[3],ms[4],sx-ms[5]+ms[3],sy-ms[6],ms[3],ms[4],true)
 end

 if ms[8] then
  mspr(ms[8],sx,sy)
 end
end

function spacejam(n)
 local ret=""
 for i=1,n do
  ret..=" "
 end
 return ret
end
-->8
--i/o
function export()
 local s=arrname.."=split2d\""

 for i=1,#data do
  if i>1 then
   s..="|"
  end
  for j=1,#data[i] do
	  if j>1 then
	   s..=","
	  end
	  s..=data[i][j]
  end
 end

 s..="\""
 printh(s,file,true)
 add(msg,{txt="exported!",t=120})
 --debug[1]="exported!"
end
-->8
--ui
function refresh_edit()
 menu={}

 add(menu,{{
	 txt="< sprite "..selspr.." >",
	 w="",
	 cmd="sprhead",
	 x=2,
	 y=2
 }})

 local lab={"  x:","  y:","wid:","hgt:"," ox:"," oy:"," fx:","nxt:"}

	for i=1,8 do
	 local s=tostr(data[selspr][i])

	 if s==nil then
	  s="[nil]"
	 end

		add(menu,{
			{
			 txt=lab[i],
			 w="    ",
			 x=2,
			 y=3+i*7
			},{
			 txt=s,
			 w=spacejam(#s),
			 cmd="editval",
			 cmdy=selspr,
			 cmdx=i,
			 x=2+16,
			 y=3+i*7
			}
		})
 end

 add(menu,{{
	 txt="delete",
	 w="",
	 cmd="delspr",
	 x=2,
	 y=4+9*7
 }})
end

function refresh_list()
 menu={}
 for i=1,#data do
  local lne={}
  local linemax=#data[i]
  if i==cury then
   linemax+=1
  end
  add(lne,{
	  txt="spr "..i,
	  w="",
	  cmd="editspr",
	  cmdy=i,
	  x=2,
	  y=-4+6*i
  })
  add(menu,lne)
 end
 add(menu,{{
  txt=" + ",
  w="   ",
  cmd="newline",
  x=2,
  y=-4+6*(#data+1)+2,
 }})
end

function refresh_table()
 menu={}
 for i=1,#data do
  local lne={}
  local linemax=#data[i]
  if i==cury then
   linemax+=1
  end
  add(lne,{
	  txt=i,
	  w="   ",
	  cmd="",
	  x=4,
	  y=-4+8*i,
	  c=2
  })
  for j=1,linemax do
   if j==#data[i]+1 then
			 add(lne,{
			  txt="+",
			  w=" ",
			  cmd="newcell",
			  cmdy=i,
			  x=-10+14*(j+1),
			  y=-4+8*i,
			 })
		 else
		  add(lne,{
		   txt=data[i][j],
		   cmd="edit",
		   cmdx=j,
		   cmdy=i,
		   x=-10+14*(j+1),
		   y=-4+8*i,
		   w="   "
		  })
   end
  end
  add(menu,lne)
 end
 add(menu,{{
  txt=" + ",
  w="   ",
  cmd="newline",
  x=4,
  y=-4+8*(#data+1),
 }})
end

function enter_table()

 local mymnu=menu[cury][curx]
 local typeval=tonum(typetxt)
 if typeval==nil then
  if mymnu.cmdx==#data[mymnu.cmdy] and typetxt=="" then
   --delete cell
   deli(data[mymnu.cmdy],mymnu.cmdx)
   if mymnu.cmdx==1 then
    deli(data,mymnu.cmdy)
   end
   _upd=update_table
   return
  end
  typeval=0
 end

 data[mymnu.cmdy][mymnu.cmdx]=typeval
 _upd=update_table
 refresh_table()
end

function enter_edit()

 local mymnu=menu[cury][curx]
 local typeval=tonum(typetxt)

 if mymnu.cmdx==8 then
  if typeval!=nil then
   if data[mymnu.cmdy][7]==nil then
    data[mymnu.cmdy][7]=0
   end
  end
 end

 if typeval==nil then
  if mymnu.cmdx>=7 and mymnu.cmdx==#data[mymnu.cmdy] then
   deli(data[mymnu.cmdy],mymnu.cmdx)
  else
   data[mymnu.cmdy][mymnu.cmdx]=0
  end
 else
  data[mymnu.cmdy][mymnu.cmdx]=typeval
 end

 _upd=update_edit
 refresh_edit()
end
__gfx__
ccccc000000cccccccccc00000ccccccccccc00000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccc07676760cccccccc0676760ccccccccc0676760ccccccccc000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccc07676760cccccccc0676760ccccccccc0676760cccccccc07676760ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccc07676760cccccccc0676760ccccccccc0676760cccccccc07676760ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccc007676760cccccccc0676760ccccccccc0676760cccccccc07676760ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0997676760cccccccc0676760ccccccccc0676760ccccccc007676760ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c09999999990cccccccc0999990ccccccccc0999990cccccc0997676760ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c099999fff90ccccccc099fff990ccccccc099999990cccc09999999990ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000000000ccc
c0999f70f7090cccccc0970f0790ccccccc099999990cccc099999fff90ccccccccc000000000cccccccccccccccccccccccccccccccccccccc02222222220cc
c0999f70f7090ccccc09970f07990ccccc09999999990ccc0999f70f7090ccccccc02222222220cccccccccccccccccccccc000000000ccccc0299992222220c
09999ffffff0cccccc099fffff990ccccc09999999990ccc0999f70f7090cccccc0299992222220ccccc000000000cccccc02222222220ccc020b90b92222220
099977777770cccccc09777777790ccccc09999999990cc09999ffffff0cccccc020b90b92222220ccc02222222220cccc0299992222220cc040b90b94444440
c09977772770cccccc09777277790ccccc09999999990cc099977777770cccccc040b90b94444440cc0299992222220cc020b90b92222220c049999994444440
cc09f77777f0ccccccc0f77777f0ccccccc0f99999f0cccc09977772770cccccc049999994444440c020b90b92222220c040b90b94444440c049999994444440
ccc00777270ccccccccc0772770ccccccccc0799970cccccc09f77777f0ccccccc049bb944444440c040b90b94444440c0499bb994444440cc049bb944444440
ccccc00000ccccccccccc00000ccccccccccc00000cccccccc00777270cccccccc042bb42222220cc0499bb994444440cc042bb42222220ccc042bb42222220c
ccccc00c00ccccccccccc00c00ccccccccccc00c00cccccccccc00000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000cccccccccccccccccccccc
cccccccccccccccccccc00000ccccccccccc00000ccccccccccccccccccccccccccccccccccccccccccccccccc000cccccccc044290ccccccccccccccccccccc
ccccccccccccccccccc0676760ccccccccc0676760ccccccccccccccccccccccccccc0000000ccccccccccccc04440cccccc04442990cccccccccccccccccccc
ccccccccccccccccccc0676760ccccccccc0676760ccccccccccccccccccccccccc00444444400cccccccccc0244420ccccc02242990cccccccccccccccccccc
ccc00000ccccccccccc0676760ccccccccc0676760cccccccccc00000ccccccccc0444444444440cccccccc0bb24420ccccc0bb22990ccccccc00000000000cc
cc0676760cccccccccc0676760ccccccccc0676760ccccccccc0676760ccccccc044444222444440cccccc0244b2290ccccc04442990cccccc044b24b24b240c
cc0676760cccccccccc0676760ccccccccc0676760ccccccccc0676760ccccccc022444ccc444220ccccc0bb2442990ccccc02242990ccccc0444b24b24b2440
cc0676760ccccccccccc00000cccccccccccccccccccccccccc0676760ccccccc099224444422990cccc0244b22990cccccc0bb22990ccccc044424424424440
cc0676760cccccccccc0999990cccccccccc00000cccccccccc0676760ccccccc099992222299990ccc0bb2442990ccccccc04442990ccccc022222222222220
cc0676760ccccccccc099fff990cccccccc0999990ccccccccc0676760cccccccc0999999999990ccc0444b22990cccccccc02242990ccccc099999999999990
cc0999990cccccccc09970f0790c0ccccc099fff990cccccccc0999990ccccccccc00999999900cccc044442990ccccccccc0bb22990cccccc0999999999990c
c099fff990ccccccc09970f0799090cccc0970f0790ccccccc099fff990cccccccccc0000000cccccc04442990cccccccccc04442990ccccccc00000000000cc
c0970f0790cccccccc09fffff9990cccc09970f07990ccccc09970f07990ccccccccccccccccccccccc022990ccccccccccc04442990cccccccccccccccccccc
09970f07990cccccccc0fffff000ccccc099fffff990ccccc09970f07990cccccccccccccccccccccccc0000ccccccccccccc044290ccccccccccccccccccccc
099fffff990ccccccc077777770cccccc099fffff990cccc0907fffff990cccccccccccccccccccccccccccccccccccccccccc0000cccccccccccccccccccccc
09777777790ccccccc07f72770f0ccccc09977777990ccccc0f07727f70ccccccccccccccccccccccccccccccccccccccc000000000000cccc000000000000cc
c077727770ccccccccc07777700cccccc0977727770ccccccc00777770ccccccccccccccccccccccccccccccccccccccc06666666666660cc06666666666660c
c0f77777f0cccccccccc002770cccccccc0f77777f0cccccccc077200ccccccccccccccccccccccccccccccccccccccc06655555555556600665555555555660
cc0772770ccccccccccc00c00cccccccccc0772770cccccccccc00c00cccccccccccccccccccccccccccccccccc00ccc06555555555555600655555555555560
ccc00000cccccccccccccccccccccccccccc00000cccccccccccccccccccccccccccc0000000ccccccccccccc00440cc06555954554555600655595455455560
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00444444400ccccccccc00b24420c06555544445555600655554444555560
ccccccc000000ccccccccccccccccccccccccccccccccccccccccccccccccccccc0444f44444440cccccc00444b2290c0665549a9a9556600665549a9a955660
cccccc07676760ccccccccccccccccccccccccccccccccccccccccc00000ccccc0444ff444444440cccc04b24429990c006654aa99a46600006654aa99a46600
cccccc07676760cccccccccccccccccccccccccccccccccccccccc0767670cccc044444444444440ccc0b24b2299990c05066666666660500006666666666000
cccccc07676760cccccccccccccccccccccccccccccccccccccccc0767670cccc022444444444220cc044b42999900cc05500000000005500000000000000000
cccccc07676760cccccccccccccccccccccccccc000000cccccccc0767670cccc099224444422990c04422299990cccc05555455554555500666666666642260
cccccc07676760ccccccccccccccccccccccccc07676760ccccccc0767670cccc099992222299990c0429999900ccccc055d42666624d5500000000000044200
ccccc00000000cccccccccc00000ccccccccccc07676760ccccccc0767670cccc099999999999990cc0999900ccccccc05dd42666624dd500666222666644260
ccc0099999990ccccccccc0767670cccccccccc07676760cccccc00000000ccccc0999b09b09990cccc0000ccccccccc05ddd455554ddd500004442044400000
cc099999999990cccccccc0767670cccccccccc07676760ccccc0999999990ccccc009bb9bb900cccccccccccccccccc05dddddddddddd500664444644466660
c09099999fff990ccccccc0767670cccccccccc07676760cccc09999999990ccccccc0000000ccccccccccccccccccccc00000000000000c0000000000000000
cc0c999f70f7090ccccccc0767670ccccccccc099999990ccc0999999fff90cccccccccccccccccccccccccccccccccccccccccccccccccc0555555555555550
ccc9999f70f70090cccccc0767670cccccccc09999fff90cccc0999f70f7090ccccccccccccccccccccccccccccccccccccccccccccccccc0555555555555550
cc09999ffffff00cccccc099999990cccccc0999f70f700cccc0999f70f7090ccccccccccccccccccccccccccccccccccccccccccccccccc0555555555555550
c099900ffffff0ccccc009999fff90cccccc0999f70f700ccc09999ffffff0cccccccccccccccccccccccccccccccccccccccccccccccccc0555555555555550
09990077777770cccc09999f70f7090cccccc099ffffff0ccc099977777770ccccccccccccccccccccccccccccccccccccccccccccccccccc00000000000000c
c000c07777277f0cccc0999f70f7090ccccc0999777770cccc0999777727f0cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccc0f07777700ccccc0999ffffff0cccccc0999777720ccc09000f777770ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccc00777270ccccc099977777770ccccccc0997f7770cccc0ccc0777270ccccccccccccccccccccc000000000000000000000ccccccccccccccccccccccccc
cccccc0000000ccccc0999f77727f0cccccccc00777720ccccccccc00000ccccccccccccccccccccc06666666666666666666660cccccccccccccccccccccccc
cccccc00ccc00ccccc09000000000ccccccccccc00000ccccccccccc0000cccccccccccccccccccc0666666666666666666666660ccccccccccccccccccccccc
ccccccccccccccccccc0cc00ccc00cccccccccccc000cccccccccccccccccccccccccccccccccccc0666600000000000000066660ccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0666055555555555555506660ccccccccccccccccccccccc
cccccccccccccccccccc00000ccccccccccccccccccccccccccccccccccccccccccccccccccccccc0660555555545555555550660ccccccccccccccccccccccc
ccccccccccccccccccc0676760cccccccc00000ccccccccccc00000ccccccccccccccccccccccccc0660555555455555555550660ccccccccccccccccccccccc
ccccccccccccccccccc0676760ccccccc0676760ccccccccc0676760cccccccccccccccccccccccc0660555554945555554550660ccccccccccccccccccccccc
ccc00000ccccccccccc0676760ccccccc0676760ccccccccc0676760cccccccccccccccccccccccc0660554549994545549550660ccccccccccccccccccccccc
cc0676760cccccccccc0676760ccccccc0676760ccccccccc0676760cccccccccccccccccccccccc0660555499999494545550660ccccccccccccccccccccccc
cc0676760cccccccccc0676760ccccccc0676760ccccccccc0676760cccccccccccccccccccccccc066655549a9a49a9445556660ccccccccccccccccccccccc
cc0676760ccccccccccc00000ccccccccc00000cccccccccc0676760cccccccccccccccccccccccc0666655549a9999a945566660ccccccccccccccccccccccc
cc0676760cccccccccc0999990ccccccccccccccccccccccc0999990cccccccccccccccccccccccc0066666549aa9aa9946666600ccccccccccccccccccccccc
cc0676760ccccccccc099999990ccccccc00000ccccccccc099999990ccccccccccccccccccccccc0506666666666666666666050ccccccccccccccccccccccc
cc0999990cccccc0cc0999999990ccccc0999990ccccccc09999999990c0cccccccccccccccccccc0550000666666666660000550ccccccccccccccccccccccc
c099999990cccc09009999999990cccc099999990cccccc09999999990090ccccccccccccccccccc0555555000000000005555550ccccccccccccccccccccccc
c099999990ccccc099999999990ccccc099999990ccccccc099999999990cccccccccccccccccccc0555555555555555555555550ccccccccccccccccccccccc
09999999990cccc09999999990ccccc09999999990ccccccc09999999990cccccccccccccccccccc0555555d4ddddddd4d5555550ccccccccccccccccccccccc
09999999990ccccc09999999770cccc09999999990cccccc07799999990ccccccccccccccccccccc055555d42666666624d555550ccccccccccccccccccccccc
09999999990cccccc0f99997770cccc09999999990cccccc07779999f0cccccccccccccccccccccc055555d42666666624d555550ccccccccccccccccccccccc
09999999990ccccccc07777770ccccc09999999990ccccccc07777700ccccccccccccccccccccccc05555dd42000000024dd55550ccccccccccccccccccccccc
c0f99999f0ccccccccc077200ccccccc0f99999f0ccccccccc002770cccccccccccccccccccccccc05555ddd4ddddddd4ddd55550ccccccccccccccccccccccc
cc0799970ccccccccccc00c00cccccccc0799970cccccccccc00c00ccccccccccccccccccccccccc0555ddddddddddddddddd5550ccccccccccccccccccccccc
ccc00000cccccccccccccccccccccccccc00000ccccccccccccccccccccccccccccccccccccccccc0555ddddddddddddddddd5550ccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00000000000000000000000cccccccccccccccccccccccc
2888888828888888ccccccc00000ccccccccccccc00000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
2888888822888888cccccc0676760ccccccccccc0676760cccccc00000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
2888888828288888c00ccc0676760ccccccccccc0676760ccccc0676760ccccccccc00cccccccccccccccccccccccccccccccc000000cccccccccccccccccccc
88888888888888880dd0cc0676760ccccccccccc0676760ccccc0676760cccccccc0dd0cc000000ccccccccc000000ccccccc07676760ccccccccccccccccccc
88888888888888880dd0cc0676760ccccccccccc0676760ccccc0676760cccccccc0dd0c07676760ccccccc07676760cccccc07676760ccccccccccccccccccc
28888888288888880dd0cc0676760ccccccccccc0676760ccccc0676760cccccccc0dd0c07676760cccc00c07676760cccccc07676760ccccccccccccccccccc
28882888288828880dd0cc0999990ccccccccccc0999990ccccc0676760cccccccc0dd0c07676760ccc0dd007676760ccccc007676760ccccccccccccccccccc
2228822222288222c0dd0099fff990ccccccccc099fff990cccc0999990cccccccc0dd0007676760ccd0dd9dd676760cccc0997676760ccccccccccccccccccc
2eeeeeee2eeeeeeec0dd09970f0790ccccccccc0970f0790ccc099fff990ccccccc0dd0997676760cccdddddd676760ccc09999999990ccccccccccccccccccc
2eeeeeee2eeeeeeec0dd09970f07990ccccc0009970f07990cc0970f0790ccccccc0dd9999999990ccc0dd9dd999990ccc099999fff90ccccccccccccccccccc
2eeeeeee2eeeeeeecc00f99fffff990cc000dddd9fffff990c09970f07990cccccc0dd99999fff90ccc0dd9dd9fff90ccc0999f70f7090cccccccccccccccccc
e2eeeee2eeeeeeeecccc07777777790c0ddddd00777777790cc09fffff990cccccc0dd999f70f7090cd09dd9dd0f7090cc0999f70f7090cccccccccccccccccc
eeeeeeeeeeeeeeeeccccc0777277790c0ddd00dc77727770ccc0777777790cccccc0dff99f70f7090ccd9dd9dd0f7090c09999ffffff0ccccccccccccccccccc
2eeeeeee2eeeeeeecccccc0777f700ccc00ddcd077777770ccc077727777f0cccccc0f779ffffff0ccc09dddddffff0cc099997777770cccc00000cccccccccc
2eee2eee2ee2eeeecccccc077270cccccccc0dddf772770f0cc0777777000ccccccc097777777770ccc09dd97dd7770ccc099977777700000ddddd0ccccccccc
222ee222222ee222ccccccc00000cccccc00dddd000000c0cccc0fd270ccccccccccc099777727770ccc0ff77dd2770cccc0997777777ddddddddd0ccccccccc
ccccccccccccccccccccccc00000ccccc0ddd000000000cccccc0dd000cccccccccccc0907777707f0ccc0907ff777f0cccc00777277fdddd00000cccccccccc
ccccccccccccccccccccccc00c00ccccc0dd0cccc00c00cccccc0ddd00ccccccccccccc0000000c00ccccc000000000cccccc000000000000ccccccccccccccc
cccccccccccccccccccccccccc00cccccc00cccccccc00ccccccc0ddd0cccccccccccccc00cc00ccccccccc00cc00cccccccc00c00cccccccccc000ccc000ccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccc0ddd0cccccccccccccccccccccccccccccccccccccccccccccccccccccccc08880c08880cc
ccccccccccccccccccccccc00000ccccccccccccccccccccccccccc0dd0ccccccccccccccccccccccccccccccccccccccccccccccccccccccc0888880888880c
ccccc00000cccccccccccc0676760cccccccccccc00000cccccccccc00ccccccccccccccccccccccccccccccccccccccccccccccccccccccc088888808888880
cccc0676760ccccccccccc0676760ccccccccccc0676760cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc088888888888880
cccc0676760ccccccccccc0676760ccccccccccc0676760cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc088888888888880
cccc0676760cccccccccc00676760ccccccccccc0676760cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc088888888888880
cccc0676760ccccccccc0d0676760cccccccc00c0676760ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0888888888880c
cccc0676760cccccccc0dd0999990ccccccc0dd00676760ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0888888888880c
cccc0999990cccccccc0d099999990cccccc0dd00999990cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc08888888880cc
ccc099999990cccccccc00999999990cccccc0d099999990cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc088888880ccc
ccc0999999990ccccccc099999999900cccccc00999999990cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0888880cccc
cc09999999990ccccccc09999999990d0ccccc09999999990ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc08880ccccc
cc09999999990ccccccc09999999990dd0cccc09999999990cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000cccccc
c0f9999999990ccccccc09999999970ddd0ccc0999999990cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0999999997700ccccc0799999970c0dd0ccc0999999990cccc00000000ccccccccc00c00cccccccccccccccccccccccccccccccccccccccccccccc0ccccccc
ccc0999999777fd0cccc0f0799970ccc0dd0cc079999990cccc0dddddddd0ccccccc0bb0bb00cccccc000000000000ccccccccc000ccccccccccccc080cccccc
cccc079997000ddd0cccc0c00000ccccc0d0cc0f0799970ccc0dd000000dd0cccccc0bb0bb0b0ccccc000000000000ccc00000c0440000cccccccc08080ccccc
ccccc00000ccc0ddd0ccccc00c00cccccc0cccc0c00000cccc0d0dddddd0d0cccc000bb0bb0b0cccccc0eeee000e0ccccccccc04000440cccccccc08080ccccc
ccccc00c00cccc0ddd0cccc00cccccccccccccccc00ccccccc0d0dddddd0d0ccc0bb0bb0bb0b0cccccc0eeee0eee0cccc0000c0440000ccccccccc08080ccccc
cccccccc00ccccc0dd0ccccccccccccccccccccccccccccccc0d0dddddd0d0ccc0bb0bb0bb0b0ccccccc0eee0ee0ccccccccc04044440ccccccccc08080ccccc
cccccccccccccccc00cccccccccccccccccccccccccccccccc0d0dddddd0d0ccc0bb0bb0bb0b0ccccccc0ee0eee0ccccc000c0444440cccccccccc08080ccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0d0dddddd0d0ccc0bb000b00000cccccccc0e0ee0ccccccccc04444440cccccccccc08080ccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0d0dddddd0d0cccc00bbb0bbbb0cccccccc0e0ee0cccccc00c0444440ccccccccccc08080ccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0d0dddddd0d0cccc0bbbb0bbbbb0cccccc0eeeeee0ccccccc044444400cccccccccc08080ccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0dd0dddd0dd0cccc0bbbbb00bbb0cccccc0ee0eee0cccccc000444444400cccccccc08080ccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc0dd0dd0dd0cccccc0bbbbbbbb0cccccc0eeee0eee0ccccc0220004444440ccccc0c08080c0ccc
cccccccccccccccccccccccccccccccccccccccccccccccccccc0dd00dd0ccccccc0bbbbbbb0ccccccc00e000eee0cccccc022220000440cccccc0000000cccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccc0dddd0cccccccc0bbbbbb0ccccccc000000000ee0cccccc02222222000cccccccc000cccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccc0000ccccccccc00000000ccccccc000000000000ccccccc000000000ccccccccc000cccccc
__map__
0000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
