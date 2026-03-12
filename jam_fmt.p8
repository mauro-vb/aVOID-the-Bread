pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- a-VOID the Bread
-- made by maurovb
function ccolors()
palt(0,false)
palt(12,true)
poke(0x5f2e,1)
local cmap={
}
for c in all(cmap) do
pal(c[1],c[2],1)
end
end
global=_ENV
_noop=function() end
function _init()
ccolors()
maplims={minx=0,maxx=52*8,miny=0,maxy=32*8}
startpx,startpy=maplims.maxx/2,maplims.maxy/2
debug_on=false
scene:load(ss)
end
function _update60()
routines_upd()
scene.current:upd()
if trans!=nil then
trans:upd()
end
end
function _draw()
scene.current:drw()
if trans!=nil then
trans:drw()
end
end
function lerp(from,to,t)
return from+(to-from)*t
end
function all_true(arr,cond)
for e in all(arr) do
if(not cond(e)) return false
end
return true
end
function rndrange(low,high)
return low+rnd(high-low)
end
function upd_group(group)
for e in all(group) do
if e.upd then
e:upd()
end
end
end
function drw_group(group)
for e in all(group) do
if e.drw then
e:drw()
end
end
end
function shuffle(tbl)
for i=#tbl,2,-1 do
local j=flr(rnd(i)+1)
tbl[i],tbl[j]=tbl[j],tbl[i]
end
return tbl
end
function split2d(s)
local arr=split(s,"|",false)
for k,v in pairs(arr) do
arr[k]=split(v)
end
return arr
end
function chance(proba)
proba=proba or .5
return rnd()<proba
end
function contains(t,val)
for v in all(t) do
if v==val then
return true
end
end
return false
end
function disto(_ENV,t)
local diffx=(x-t.x)/16
local diffy=(y-t.y)/16
local res=diffx*diffx+diffy*diffy
return sqrt(res)*16
end
amap=split" 2,7,4,8,1,5,3,6"
butarr=split"1,2,0,3,5,6,3,4,8,7,4,0,1,2,0"
dirx=split"-1,1, 0,0,-0.7, 0.7,0.7,-0.7"
diry=split" 0,0,-1,1,-0.7,-0.7,0.7, 0.7"
function cobblefix(_ENV,dir)
if lastdir!=dir and dir>=5 then
x=flr(x)+.5
y=flr(y)+.5
end
end
function getdir(_ENV,target)
local ddx=target.x-x
local ddy=target.y-y
local distance=sqrt(ddx*ddx+ddy*ddy)
return{x=ddx/distance,y=ddy/distance}
end
function setdir(_ENV,target)
local ddx=target.x-x
local ddy=target.y-y
local distance=sqrt(ddx*ddx+ddy*ddy)
dx=ddx/distance
dy=ddy/distance
end
function setcardinaldir(_ENV,p,nofix)
ang=atan2(p.x-x,y-p.y)
local si=flr((ang*8+.5)%8)+1
local dir=amap[si]
dx=dirx[dir]
dy=diry[dir]
if not nofix then
cobblefix(_ENV,dir)
end
lastdir=dir
end
function collides(_ENV,b)
if(y-sizey/2>b.y+b.sizey/2) return false
if(b.y-b.sizey/2>y+sizey/2) return false
if(x-sizex/2>b.x+b.sizex/2) return false
if(b.x-b.sizex/2>x+sizex/2) return false
return true
end
function mspr(s,x,y,fx,fy)
fx=fx or false
fy=fy or false
sspr(
s[1],s[2],
s[3],s[4],
x-s[5],y-s[6],
s[3],s[4],
fx,fy
)
end
function cycanim(age,arr,spd,inv)
local spd=spd or 1
local t=age\spd
if inv then t=#arr-1-t%#arr
else t=t%#arr
end
return arr[t+1]
end
function sorty(arr)
for i=1,#arr do
local j=i-1
local e=arr[i]
while j>=1 and e.y<arr[j].y do
arr[j+1]=arr[j]
j-=1
end
arr[j+1]=e
end
end
function hex2num(str)
return("0x"..str)+0
end
function load_stored_gfx(gfx)
index=0
for i=1,#gfx,2 do
cnt=hex2num(sub(gfx,i,i))
local col=hex2num(sub(gfx,i+1,i+1))
for j=1,cnt do
sset((index)%128,flr((index)/128),col)
index+=1
end
end
end
function restore_gfx()
reload(0x0,0x0,0x2000)
end
story_gfx=
"fcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfc9cf0f0f0306cf0f0f030fcbc10fefefe1e106c10fefefe1e10fcbc108e77fefe1e106c108efb8bfe10fcbc107e27161716171627fefe106c107e1bf7871bee10fcbc107e27161716171627fefe106c107e1bf7871bee10fcbc108e17161716171617fefe1e106c107e1b372017201720172027201730171bee10fcbc108e17161716171617fefe1e106c107e1b3710271027102710171017103710271bee10fcbc108e17161716171617fefe1e106c107e1b372017201710272027202710271bee10fcbc108e17161716171617fefe1e106c107e1b4710171027102710171017103710371bde10fcbc108e79fefe1e106c108e1b2720172017201710171017202710371bde10fcbc107e393f39fe1e707e106c108e1bf7871bde10fcbc106e395f39fe1f706e106c108e1b272027201720171017301720371bde10fcbc105e391f17102f101729fe3f605e106c108e1b27101710171027102710171017101710471bde10fcbc105e391f17102f101729ee10174f405e106c108e1b272027201710271017301720371bde10fcbc104e492f1c2f1c1f19fe10174f405e106c108e1b2710171017102710271017103710471bde10fcbc103e193e271c57194fae8f305e106c108e1b2710171017201720171017103720371bde10fcbc106e5712171c272e3f108e9f205e106c108e1bf7871bde10fcbc105eb7191e3f307e9f105e106c108e1bf7871bde10fcbc105e6712572e607e9f5e106c108e1bf7871bde10fcbc105e271e671e273e704eb04e106c108e1b2730172047202740371bde10fcbc105e271e671e274ef0703e106c108e1b5710271027103710771bde10fcbc105e271e671e275ef0702e106c108e1bf7871bde10fcbc105e271e671e276ef0701e106c108e1bf7871bde10fcbc105e171f1e671e277ef0601e106c108e1bf7871bde10fcbc105e2f1e671e2f9ef0401e106c108e1b572b372b271b272b171b271bde10fcbc106e1f1e602e1fbef0201e106c108e1b471b271b472b571b371bde10fcbc108e60eef0406c109e1bf7871bce10fcbc108e60eef0406c109e1bf7871bce10fcbc108e60eef0406c109e1b371017202710172037201710371bce10fcbc108e60eef0406c109e1b471057107710471bce10fcbc108e60eef0101e206c109e1bf7871bce10fcbcf0f0f0306cf0f0f030fcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfc8cf0f0f0306cf0f0f030fcbc10fe5e77fe4e106c10ce10f66610be10fcbc10fe4e27161716171627fe3e106c10be10f68610ae10fcbc10fe4e27161716171627fe3e106c10be1046f04610ae10fcbc10fe5e17161716171617fe4e106c10be103610f5103610ae10fcbc10fe5e17161716171617fe4e106c10be1026107514351b55102610ae10fcbc10fe5e17161716171617fe4e106c10be102610451b1514751b25102610ae10fcbc10fe5e17161716171617fe4e106c10be10261055141914651425102610ae10fcbc10fe5e79fe4e106c10be102610251415143914151425141925102610ae10fcbc10fe4e392f49fe3e106c10be102610351459141914151435102610ae10fcbc10fe3e394f49fe2e106c10be10363514191a191a14191a1924353610ae10fcbc10fe3e2917102f101739fe2e106c10be10463514191b391b1a1914254610ae10fcbc10fe2e3917102f101739fe2e106c10be20561514192a192a29145620ae10fcbc10fe2e396f39fe2e106c10be30f64630ae10fcbc10fe1e496f49fe1e106c10be70b670ae10fcbc10fe192e1987191e19fe1e106c10be1066b06610ae10fcbc10fe2e195712472e19fe106c10be2034e03430ae10fcbc10fe3ea719fe2e106c10be10161b29e61b19241610ae10fcbc10fe3e571247fe3e106c10bef0a0ae10fcbcf040374037f0406c10be10568456342610ae10fcbc10f434374437f434106c10be5014495430293420ae10fcbc10f4443714193719848224106c10be104614191b295436191b341610ae10fcbc10f4242d3f2d3f2df424106c10be50a4a0ae10ac1278127810d4422d3f2d3f2df424106c10be10f68610ae10ac127822681024926419141b191b491b19a284106c10bef0a0ae10ac12781218125810f4341b291b391b29f434106c10be10f58510ae10acf81810f454391b291bf444106c10be10f58510ae10acf81810f434193449241bf424106c10be10f58510ae10ac1278127810548244321b3219a49224106c10be10f58510ae10ac123812381238123810f4741bf484106c10be10f58510ae10ac322862283210f4f4f414106c10be10f58510ae10ac127e127ef0f0f0306cf0f0f030ac127e127efcfcfcfcfcfcfc7c127e127efcfcfcfcfcfcfc7c1e125e128efcfcfcfcfcfcfc7cfe1efcfcfcfcfcfcfc7c127e127efcfcfcfcfcfcfc7c123e123e122e124efc4cf0f0f030fcfcfc322e622e32fc4c10f8f8f81810fcfcfcfcfc5c10f8f8f81810fcfcfcfcfc5c10f8f8f81810fcfcfcfcfc5c10f8f8f81810fcfcfcfcfc5c109877f8f810fcfcfcfcfc5c108827161716171627f8e810fcfcfcfcfc5c108827161716171627f8529810fcfcfcfcfc5c109817161716171617e82249a210fcfcfcfcfc5c109817161716171617d822699210fcfcfcfcfc5c109817161716171617d812799210fcfcfcfcfc5c109817161716171617c814191b591b198210fcfcfcfcfc5c109879c814192b392b198210fcfcfcfcfc5c108889c814192b292b29424410fcfcfcfcfc5c1078792fc814591b497410fcfcfcfcfc5c10787917101fb814a97410fcfcfcfcfc5c10787917102fa814791b297410fcfcfcfcfc5c1078793fb814191b191b292b297410fcfcfcfcfc5c1078793fb814192b193b397410fcfcfcfcfc5c10681918692fc812a97210fcfcfcfcfc5c106819186917e8f22210fcfcfcfcfc5c106819186927f8f810fcfcfcfcfc5c1088273947f8e810fcfcfcfcfc5c1078373947f8e810fcfcfcfcfc5c1078473947f8d810fcfcfcfcfc5c10686719271837f8c810fcfcfcfcfc5c106827186728371f6df84810fcfcfcfcfc5c106827186748171fcdd810fcfcfcfcfc5c10682f1860c86dd810fcfcfcfcfc5c108880f8f810fcfcfcfcfc5c1088302830f8f810fcfcfcfcfc5cf0f0f030fcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfc"
#include data/myspr.txt
enstats={
split2d"15,.2|7,220|8,.12|35,650|9,.2",
split2d"18,.2|12,220|10,.12|42,600|12,.22",
split2d"20,.22|15,200|12,.14|48,550|15,.25",
split2d"23,.25|18,180|15,.16|55,500|18,.30",
split2d"27,.27|22,165|18,.18|63,455|22,.33",
split2d"30,.3|26,150|22,.2|72,410|26,.35",
split2d"35,.32|32,135|26,.21|82,375|30,.37",
split2d"40,.35|38,120|30,.23|92,340|34,.4",
split2d"47,.37|45,110|35,.25|103,300|38,.41",
split2d"53,.4|50,100|38,.27|112,260|42,.43",
split2d"57,.41|53,95|42,.28|118,220|46,.44",
split2d"60,.43|55,90|45,.3|125,180|50,.45",
}
class=setmetatable({
ancestors={},
extend=function(_ENV,tbl)
tbl=tbl or{}
tbl.__index=tbl
tbl.ancestors={}
for a in all(_ENV.ancestors) do
add(tbl.ancestors,a)
end
add(tbl.ancestors,_ENV)
setmetatable(tbl,{
__index=_ENV,
__call=tbl.__call or function(_ENV,tbl)
return _ENV:new(tbl)
end
})
return tbl
end,
new=function(_ENV,tbl)
tbl=tbl or{}
setmetatable(tbl,_ENV)
tbl.class=_ENV
tbl:init()
return tbl
end,
is=function(_ENV,klass)
return _ENV.class==klass or count(ancestors,klass)>0
end,
init=_noop
},{__index=_ENV})
class.__index=class
game_object=class:extend({
init=_noop,
upd=_noop,
drw=_noop,
destroy=_noop,
})
scene=game_object:extend({
load=function(_ENV,new_scene)
if new_scene!=current then
current=new_scene
current:init()
end
end
})
routines={}
function tween_wait(f,callback)
callback=callback or _noop
local wait=function()
for i=1,f do
yield()
end
end
return{animation=wait,callback=callback}
end
function tween(obj,k,v,f,transition,callback,pausable)
local initial_v=obj[k]
transition=transition or linear
callback=callback or _noop
animation=function()
for i=1,f do
obj[k]=lerp(initial_v,v,transition(i/f))
yield()
end
end
return{animation=animation,callback=callback,pausable=pausable}
end
function tween_factory(obj,k,v,f,transition,callback,pausable)
return function() return tween(obj,k,v,f,transition,callback,pausable) end
end
function dotween(obj,k,v,f,transition,callback,pausable)
local tw=tween(obj,k,v,f,transition,callback)
local co=cocreate(tw.animation)
add(routines,{co=co,callback=tw.callback,pausable=pausable})
end
function chaintweens(steps,final_callback,pausable)
final_callback=final_callback or _noop
local function chain()
for step in all(steps) do
if type(step)=="function"or not step[1] then
step={step}
end
local cos={}
for tw in all(step) do
tw=type(tw)=="function"and tw() or tw
add(cos,{
co=cocreate(tw.animation),
callback=tw.callback,
pausable=pausable
})
end
local running=true
while running do
running=false
for item in all(cos) do
if costatus(item.co)!="dead"then
running=true
assert(coresume(item.co))
end
end
if running then yield() end
end
for item in all(cos) do
item.callback()
end
end
final_callback()
end
add(routines,{
co=cocreate(chain),
callback=_noop,
pausable=pausable
})
end
function routines_upd()
for routine in all(routines) do
if costatus(routine.co)=="dead"then
routine.callback()
del(routines,routine)
else
assert(coresume(routine.co))
end
end
end
function linear(t)
return t
end
function smoothstep(t)
return t*t*(3-2*t)
end
function smootherstep(t)
return t*t*t*(t*(t*6-15)+10)
end
function overshoot(t)
if(t<.5) then
return(2.7*8*t*t*t-1.7*4*t*t)/2
else
t-=1
return 1+(2.7*8*t*t*t+1.7*4*t*t)/2
end
end
function enemy_upd(_ENV)
age+=1
local initx,inity=x,y
if state=="spawning"then
if spawn_delay>0 then
spawn_delay-=1
else state="active"
end
elseif state=="active"then
if not dummy then
if collides(_ENV,p) do
destroy(_ENV,false)
return
end
if hp<=0 then
destroy(_ENV,true)
end
end
enemy_ai(_ENV)
end
if paralize_t>0 then
paralize_t-=1
x=initx
y=inity
else
restric_movement(_ENV)
end
end
enemy=class:extend({
state="active",
dummy=false,
xp_drop=1,
dmg=20,
paralize_t=0,
init=function(_ENV)
if enemy_init!=nil then
enemy_init(_ENV)
end
age=0
initial_hp=hp
add(entities,_ENV)
end,
upd=enemy_upd,
col=7,
sizey=4,sizex=4,
enemy_ai=_noop,
destroy=function(_ENV,die)
del(entities,_ENV)
if die then
sfx(41)
if is(_ENV,bagel) then global.encount.BAGELS+=1
elseif is(_ENV,baguette) then global.encount.BAGUETTES+=1
elseif is(_ENV,loaf) then global.encount.LOAVES+=1 end
if(p!=nil) then p.xp+=xp_drop*p.xp_received end
else
sfx(23)
enhurt(p)
if(p!=nil) then p.hp-=dmg*p.dmg_received end
end
end,
x=64,y=64,
dx=0,
dy=0,
c=36,
debug=drw_collision_box,
drwhp=function(_ENV)
if hp<initial_hp then
local barwidth=13
local offy=8
local progress=lerp(0,barwidth,mid(0,hp/initial_hp,1))
local bx=x-barwidth/2
line(bx,y+offy,bx+barwidth,y+offy,15)
line(bx,y+offy,bx+progress,y+offy,11)
end
end
})
function loaf_ai(_ENV)
timer-=1
if(p==nil) return nil
setcardinaldir(_ENV,p,move_speed<=.3)
if timer<=0 then
rndspd=rndrange(-.1,.1)
timer=rndrange(60,90)
end
x+=move_speed*dx
y+=move_speed*dy
end
function loaf_drw(_ENV)
mspr(cycanim(age,anim,6),x,y,p.x>x)
drwhp(_ENV)
end
loaf=enemy:extend({
timer=0,
anim={myspr[21],myspr[22],myspr[23],myspr[24]},
drw=loaf_drw,
enemy_ai=loaf_ai,
enemy_init=function(_ENV)
hp=enstats[enstats_i][1][1]
move_speed=enstats[enstats_i][1][2]
end,
})
function bagel_ai(_ENV)
if(p==nil) return nil
setdir(_ENV,p)
local pdist=disto(_ENV,p)
local dist_thresh=50
if pdist>dist_thresh and last_pdist<dist_thresh and abs(rotation_dir)>.5 then
dotween(_ENV,"rotation_dir",-sgn(rotation_dir),90,quad)
else
local tangent_x=-dy*rotation_dir
local tangent_y=dx*rotation_dir
x+=move_speed*dx+orbit_speed*tangent_x
y+=move_speed*dy+orbit_speed*tangent_y
end
last_pdist=pdist
if x>=maplims.maxx or x<=0 or y>=maplims.maxy or y<=0 then
rotation_dir*=-1
end
end
function bagel_drw(_ENV)
ovalfill(x-7,y+1,x+5,y+6,2)
mspr(sprarr,x,y)
drwhp(_ENV)
local eyespos=cycanim(age,eyepositions,10,sgn(rotation_dir)==-1)
for pos in all(eyespos) do
pset(x+pos.x,y+pos.y,x<p.x and 11 or 0)
pset(1+x+pos.x,y+pos.y,x<p.x and 0 or 11)
end
end
bagel=enemy:extend({
rotation_timer=0,
eyepositions={
{{x=0,y=2},{x=-3,y=2}},
{{x=2,y=1},{x=4,y=0}},
{},
{{x=-7,y=0},{x=-5,y=1}},
},
sprarr=myspr[25],
drw=bagel_drw,
enemy_init=function(_ENV)
hp=enstats[enstats_i][3][1]
move_speed=enstats[enstats_i][3][2]
orbit_speed=move_speed*3
rotation_dir=chance() and 1 or-1
end,
last_pdist=100,
enemy_ai=bagel_ai
})
function baguette_dash(_ENV)
dashing=true
local chargex,chargey=(-dirtop.x*8),(-dirtop.y*8)
local chargef=20
local maxforce=60
local dashforce=mid(15,disto(_ENV,p),maxforce)+rndrange(-5,5)
local dashf=mid(40,dashspd-10*(dashforce/maxforce),dashspd)
local dashx=dirtop.x*dashforce
local dashy=dirtop.y*dashforce
chaintweens({
{
tween_factory(_ENV,"x",x+chargex,chargef,smoothstep),
tween_factory(_ENV,"y",y+chargey,chargef,smoothstep)
},
{
tween_factory(_ENV,"x",x+dashx,dashf,overshoot),
tween_factory(_ENV,"y",y+dashy,dashf,overshoot)
}
},function() dashing=false end,true)
end
function baguette_upd_visuals(_ENV)
local ang=atan2(p.x-x,p.y-y)
if(ang<.45 and ang>.3) or(ang<.95 and ang>.8) then
sprarr=sprarrs[1]
flipx=true
elseif(ang<.70 and ang>.55) or(ang<.2 and ang>.05) then
sprarr=sprarrs[1]
flipx=false
elseif(ang>.2 and ang<.3) or(ang>.7 and ang<.8) then
sprarr=sprarrs[2]
flipx=p.x>x
else
sprarr=sprarrs[3]
flipx=p.x>x
end
end
function baguette_ai(_ENV)
if(p==nil) return nil
if not dashing then
baguette_upd_visuals(_ENV)
end
dirtop=getdir(_ENV,p)
if timer>=0 then
if not(paralize_t>0) then
timer-=1
end
else
if disto(_ENV,p)<64 and collides(_ENV,scene.cam) then
timer=waitt+rnd(variationt)
baguette_dash(_ENV)
else
setcardinaldir(_ENV,p)
x+=move_speed*dx
y+=move_speed*dy
end
end
end
function baguette_drw(_ENV)
mspr(sprarr,x,y,flipx)
drwhp(_ENV)
end
baguette=enemy:extend({
dashspd=60,
move_speed=.5,
sprarr=myspr[26],
sprarrs={myspr[26],myspr[27],myspr[28]},
enemy_ai=baguette_ai,
drw=baguette_drw,
timer=120,
ai_state="wait",
variationt=50,
dashing=false,
enemy_init=function(_ENV)
hp=enstats[enstats_i][3][1]
waitt=enstats[enstats_i][2][2]
end,
})
function bun_ai(_ENV)
if(p==nil) return nil
setdir(_ENV,p)
local pdist=disto(_ENV,p)
local dist_thresh=30
if pdist>dist_thresh and last_pdist<dist_thresh and abs(rotation_dir)>.5 then
dotween(_ENV,"rotation_dir",-sgn(rotation_dir),90,quad)
else
local tangent_x=-dy*rotation_dir
local tangent_y=dx*rotation_dir
x+=move_speed*dx+orbit_speed*tangent_x
y+=move_speed*dy+orbit_speed*tangent_y
end
last_pdist=pdist
if x>=maplims.maxx or x<=0 or y>=maplims.maxy or y<=0 then
rotation_dir*=-1
end
end
function bun_drw(_ENV)
mspr(sprarr,x,y)
drwhp(_ENV)
for i=1,2 do
local oy=p.y>y and 3 or 2
local ox=p.x>x and-2 or-3
if i==2 then ox+=3 end
pset(x+ox,y+oy,0)
end
end
bun=enemy:extend({
rotation_dir=1,
sprarr=myspr[29],
drw=bun_drw,
enemy_init=function(_ENV)
hp=enstats[enstats_i][5][1]
move_speed=enstats[enstats_i][5][2]
orbit_speed=move_speed*1.2
end,
last_pdist=100,
enemy_ai=bun_ai
})
function oven_spawn(_ENV)
sfx(59)
for i=1,mid(1,difficulty/2,10) do
local en=rnd(enemies)
if#entities<300 then
en({
x=x+rndrange(-6,6),
y=y+10+rndrange(-4,4),
})
end
end
sprarr=myspr[30]
end
function oven_upd(_ENV)
if age%spawn_rate==0 then
sprarr=myspr[31]
spwn_timer=30
end
if sprarr==myspr[31] then
if spwn_timer<=0 then
oven_spawn(_ENV)
else
spwn_timer-=1
end
end
if hp<=0 then
destroy(_ENV)
end
end
oven=enemy:extend({
age=0,
state="active",
size="small",
enemies={bun,baguette,loaf,bagel},
xp_drop=3,
drw=function(_ENV)
age+=1
mspr(sprarr,x,y)
drwhp(_ENV)
end,
upd=oven_upd,
c=86,
destroy=function(_ENV)
del(entities,_ENV)
del(ovens,_ENV)
if(p!=nil) then p.xp+=xp_drop end
global.encount.OVENS+=1
end,
drw_indicator=function(_ENV)
if not collides(_ENV,cam) then
local margin=4
local sx=mid(cam.x-64+margin,x,cam.x+64-margin)
local sy=mid(cam.y-64+margin,y,cam.y+64-margin)
local size=flr(lerp(1,3,1-disto(_ENV,p)/300))
rectfill(sx-size,sy-size,sx+size,sy+size,(sprarr==myspr[31] and sin(age/10)>-.5) and 9 or 6)
if size>=1 then
rect(sx-size,sy-size,sx+size,sy+size,5)
end
end
end,
enemy_init=function(_ENV)
hp=enstats[enstats_i][4][1]
spawn_rate=enstats[enstats_i][4][2]
oven_spawn(_ENV)
sfx(19)
if size=="small"then
sizex,sizey=16,16
sprarr=myspr[30]
end
end
})
mycam=game_object:extend({
deadz=24,
sizex=128,sizey=128,
owner=nil,
init=function(_ENV)
minx=maplims.minx;maxx=maplims.maxx
miny=maplims.miny;maxy=maplims.maxy
x=owner.x
y=owner.y
end,
upd=function(_ENV)
if(owner==nil) return
local ox,oy=owner.x,owner.y
if abs(ox-x)>deadz then
x=mid(minx+64,ox-sgn(ox-x)*deadz,maxx-64)
end
if abs(oy-y)>deadz then
y=mid(miny+64,oy-sgn(oy-y)*deadz,maxy-64)
end
camera(x-64,y-64)
end,
})
function player_dash(_ENV)
if btnp(❎) and can_dash then
sfx(28)
dashing=true
can_dash=false
local trans=quad
if dx==0 and dy==0 then
if anim==anims.l_idle then dx=-1;dy=0
elseif anim==anims.r_idle then dx=1;dy=0
elseif anim==anims.d_idle then dx,dy=0,1
elseif anim==anims.u_idle then dx,dy=0,-1 end
end
local dashx,dashy=dx*dashforce,dy*dashforce
local dashf=10
dotween(_ENV,"x",x+dashx,dashf,trans)
dotween(_ENV,"y",y+dashy,dashf,trans,function() dashing=false;dasht=dash_cd end)
else
if dasht>0 then
dasht-=1
else
can_dash=has_dash
end
end
end
function player_hit(_ENV)
local function get_area(_ENV)
local area={}
area.y=y-4
if facing_dir=="u"then area.y=y-hitlen/2
elseif facing_dir=="d"then area.y=y+hitlen/2 end
area.x=x
if facing_dir=="l"then area.x=x-hitlen/2
elseif facing_dir=="r"then area.x=x+hitlen/2 end
if facing_dir=="u"or facing_dir=="d"then
area.sizex=hitwid
area.sizey=hitlen
else
area.sizex=hitlen
area.sizey=hitwid
end
rectfill(area.x-area.sizex/2,area.y-area.sizey/2,area.x+area.sizex/2,area.y+area.sizey/2,12)
area.hor=facing_dir=="l"or facing_dir=="r"
area.dir=facing_dir
return area
end
local area=get_area(_ENV)
hit_particles(area)
for en in all(entities) do
if(en:is(enemy) or en:is(oven)) and collides(area,en) then
if lifesteal then hp+=.5*en.hp end
if paralize then en.paralize_t=paralize_t end
en.hp-=hit_dmg
sfx(28)
enhit(en)
end
end
sfx(17)
end
function player_hit_upd(_ENV)
if hitting and(age\hitspd)%#anim+1==#anim then
hitting=false
hit(_ENV)
change_anim(_ENV,facing_dir.."_idle",facing_dir=="l",idlespd)
end
if hit_t>0 then
hit_t-=1
if hit_wait_t!=hit_wait then hit_wait_t=hit_wait end
else
if input_dir==0 then
if hit_wait_t>0 then
hit_wait_t-=1
else
hitting=true
hit_t=hit_cd
end
end
end
end
function player_move(_ENV)
if(dashing) return
input_dir=0
if btn(⬅️) then input_dir+=1 end
if btn(➡️) then input_dir+=2 end
if btn(⬆️) then input_dir+=4 end
if btn(⬇️) then input_dir+=8 end
input_dir=butarr[input_dir]
dx=dirx[input_dir];dy=diry[input_dir]
cobblefix(_ENV,input_dir)
local nx,ny=x+dx*mv_spd,y+dy*mv_spd
x=nx;y=ny
if input_dir!=0 then
if step_timer>0 then
step_timer-=1
else
sfx(age%2==0 and 37 or 38)
step_timer=20
end
end
player_dash(_ENV)
restric_movement(_ENV)
end
function change_anim(_ENV,name,fx,spd)
if anim!=anims[name] then
age=0
spd=spd or 10
aspd=spd
anim=anims[name]
flipx=fx
facing_dir=name[1]
end
end
function player_anim(_ENV)
if hitting then
if anim==anims.l_idle then
change_anim(_ENV,"l_hit",true,hitspd)
elseif anim==anims.r_idle then
change_anim(_ENV,"r_hit",false,hitspd)
elseif anim==anims.u_idle then
change_anim(_ENV,"u_hit",false,hitspd)
elseif anim==anims.d_idle then
change_anim(_ENV,"d_hit",false,hitspd)
end
else
if(lastdir==0) return
if input_dir==1 or input_dir==2 or input_dir>=5 then
local isleft=sgn(dx)==-1
local side=isleft and"l"or"r"
change_anim(_ENV,side.."_run",isleft,7)
elseif input_dir==3 then
change_anim(_ENV,"u_run")
elseif input_dir==4 then
change_anim(_ENV,"d_run",false)
else
if(lastdir==3) then
change_anim(_ENV,"u_idle",false,idlespd)
elseif(lastdir==4) then
change_anim(_ENV,"d_idle",false,idlespd)
else
local isleft=lastdir==1 or lastdir==5
local side=isleft and"l"or"r"
change_anim(_ENV,side.."_idle",isleft,idlespd)
end
end
end
end
function player_level_up(_ENV)
sfx(14)
local function get_upgrade(prev_upgs)
local new_upg=nil
local upg_type
repeat
new_upg=rnd(upgrades)
until new_upg
and new_upg:valid()
and not contains(prev_upgs,new_upg)
return new_upg
end
local ups={}
local upg
for i=1,3 do
upg=get_upgrade(ups)
add(ups,upg)
end
global.ui=upgrade_ui({upgrades=ups})
end
function player_upd_xp(_ENV)
local xp_required=level>#level_ups and level_ups[#level_ups] or level_ups[level]
if xp>=xp_required then
xp-=xp_required
level+=1
player_level_up(_ENV)
end
end
function player_upd(_ENV)
age+=1
player_move(_ENV)
player_hit_upd(_ENV)
player_anim(_ENV,input_dir)
player_upd_xp(_ENV)
hp=min(hp,maxhp)
lastdir=input_dir
end
function player_drw(_ENV)
ovalfill(x-4,y+3,x+4,y+6,2)
sprarr=cycanim(age,anim,aspd)
mspr(sprarr,x,y,flipx)
if debug_on then
debug(_ENV)
end
end
function player_debug(_ENV)
drw_collision_box(_ENV)
print(hitlen,x,y-20,0)
end
function player_init(_ENV)
butarr[0]=0
anim=anims.d_idle
hit_t=hit_cd
hit_wait_t=hit_wait
add(entities,_ENV)
end
player=game_object:extend({
mv_spd=.8,
dx=0,
dy=0,
sizex=6,
sizey=10,
anims={
d_idle={myspr[2],myspr[5]},
l_idle={myspr[3],myspr[47]},
r_idle={myspr[1],myspr[34]},
u_idle={myspr[4],myspr[17]},
d_run={myspr[5],myspr[6],myspr[7],myspr[8]},
r_run={myspr[9],myspr[10],myspr[11],myspr[12]},
l_run={myspr[13],myspr[14],myspr[15],myspr[16]},
u_run={myspr[17],myspr[18],myspr[19],myspr[20]},
d_hit={myspr[35],myspr[36],myspr[37],myspr[37]},
u_hit={myspr[38],myspr[39],myspr[40],myspr[40]},
r_hit={myspr[41],myspr[42],myspr[43],myspr[43]},
l_hit={myspr[44],myspr[45],myspr[46],myspr[46]},
},
idlespd=12,
hitspd=6,
age=0,
input_dir=0,
dash_cd=200,
dasht=0,
has_dash=false,
can_dash=false,
dashforce=28,
upgrades={
{trigger=function() p.has_dash=true end,valid=function() return not p.has_dash end,name="get a dash ヌえ🅾️",icon=myspr[51]},
{trigger=function() p.dash_cd-=50 end,valid=function() return p.has_dash and p.dash_cd>80 end,name="reduce dash cooldown",icon=myspr[51]},
{trigger=function() p.hit_cd=mid(5,p.hit_cd-20,100) end,valid=function() return p.hit_cd>10 end,name="reduce hit cooldown",icon=myspr[50]},
{trigger=function() p.hitlen=mid(25,p.hitlen*1.5,60);p.hitwid=mid(15,p.hitwid*1.5,35) end,valid=function() return p.hitlen<60 end,name="increase reach",icon=myspr[52]},
{trigger=function() p.hit_dmg+=5 end,valid=function() return true end,name="increase damage",icon=myspr[49]},
{trigger=function() p.xp_received*=1.5 end,valid=function() return p.xp_received<100 and p.level>10 end,name="receive more xp",icon=myspr[49],repeatable=true},
{trigger=function() p.hp=mid(1,p.hp+.35*p.maxhp,p.maxhp) end,valid=function() return p.hp!=p.maxhp end,name="heal",icon=myspr[53]},
{trigger=function() p.maxhp*=1.2 end,valid=function() return true end,name="increase max hp",icon=myspr[53]},repeatable=true,
{trigger=function() p.lifesteal=true end,valid=function() return not p.lifesteal and p.level>10 end,name="lifesteal",icon=myspr[52]},
{trigger=function() p.dmg_received*=.75 end,valid=function() return p.dmg_received>.3 end,name="reduce received damage",icon=myspr[48]},
{trigger=function() p.paralize=true end,valid=function() return not p.paralize end,name="stun hit enemies",icon=myspr[52]},
{trigger=function() p.paralize_t=mid(1,p.paralize_t+30,120) end,valid=function() return p.paralize and p.paralize_t<120 end,name="longer stun",icon=myspr[50]},
},
step_timer=20,
hit_cd=100,
hitting=false,
hit_wait=10,
hitlen=25,
hitwid=12,
hit_dmg=7,
hit=player_hit,
hp=100,
maxhp=100,
lifesteal=false,
paralize=false,
paralize_t=25,
dmg_received=1,
xp_received=1,
xp=0,
level=1,
level_ups=split"3,3,4,4,4,5,5,5,5,8,9,10,10,10,10,20,20,30,50,60,70,80,100,150,200,300,400,500,750,1000",
upd=player_upd,
drw=player_drw,
init=player_init,
debug=player_debug,
})
function spawn_oven()
local oven_pos
local function checkcol(ovenpos)
for oven in all(ovens) do
if collides(ovenpos,oven) then return true end
end
if ovenpos.x-ovenpos.sizex/2<maplims.minx then return true end
if ovenpos.x+ovenpos.sizex/2>maplims.maxx then return true end
if ovenpos.y-ovenpos.sizey/2<maplims.miny then return true end
if ovenpos.y+ovenpos.sizey/2>maplims.maxy then return true end
return collides(ovenpos,scene.cam)
end
repeat
oven_pos={
x=rndrange(16,maplims.maxx-16),
y=rndrange(16,maplims.maxy-16),
sizex=16,
sizey=16
}
until not checkcol(oven_pos)
add(ovens,oven({
x=oven_pos.x,
y=oven_pos.y
}))
end
function restric_movement(_ENV)
x=mid(0,x,maplims.maxx)
y=mid(0,y,maplims.maxy)
end
function game_loop(_ENV)
difficulty=max(difficulty,flr(t/1500)+flr(p.level/2.5))
local novens=mid(2,difficulty/5,4)
local oven_spawn_rate=flr(mid(600,900-difficulty*20+novens*180,1200))
global.enstats_i=mid(1,ceil(difficulty/3),#enstats)
if t%oven_spawn_rate==0 then
for n=1,novens do
if#ovens==0 then spawn_oven() end
if#ovens<8 then
spawn_oven()
end
end
end
if p.hp<=0 then end_game(_ENV) end
end
function end_game(_ENV)
over=true
transition({new_scene=end_screen})
end
function game_init(_ENV)
global.enstats_i=1
global.difficulty=0
over=false
restore_gfx()
t=0
global.encount={BAGELS=0,BAGUETTES=0,LOAVES=0,OVENS=0}
global.entities={}
global.p=player({x=startpx,y=startpy})
global.parts={}
global.ui=game_ui()
global.cam=mycam({owner=p})
global.paused=false
global.ovens={}
spawn_oven(true)
spawn_oven(true)
_upd=game_upd
_drw=game_drw
end
function game_upd(_ENV)
if(over) return
ui:upd()
if(paused) return
t+=1
upd_group(entities)
upd_group(parts)
sorty(entities)
cam:upd()
game_loop(_ENV)
end
function game_drw(_ENV)
cls(7)
map()
drw_group(entities)
drw_group(attacks)
if(over) return
drw_group(parts)
ui:drw()
end
game=scene:extend({
init=game_init,
upd=game_upd,
drw=game_drw,
})
function ss_init(_ENV)
global.cam=nil
pressed=false
_upd=ss_upd
_drw=ss_drw
global.cam=nil
x,y=startpx,startpy
mapx,mapy=rndrange(0,6),0
camera(startpx-64,startpy-64)
end
function ss_upd(_ENV)
if(pressed) return
if btnp(🅾️) or btnp(❎) then
pressed=true
transition({new_scene=story})
end
end
function ss_drw(_ENV)
map(mapx,mapy)
print("\^w\^t\^o040 A-VOID \nTHE BREAD",x-35,y-30,15)
print("\^o040PRESS 🅾️ / ❎",x-28,y,15)
end
ss=scene:extend({
init=ss_init,
upd=ss_upd,
drw=ss_drw,
})
function end_init(_ENV)
pressed=false
_upd=end_upd
_drw=end_drw
x=cam.x
y=cam.y
end
function end_upd(_ENV)
if(pressed) return
if btnp(❎) then
pressed=true
transition({new_scene=game})
elseif btnp(🅾️) then
pressed=true
transition({new_scene=ss})
end
end
function end_drw(_ENV)
map()
local strs={"BAGELS","BAGUETTES","LOAVES","OVENS"}
for e=1,#strs do
local tmp=strs[e]
local verb=tmp=="OVENS"and"DESTROYED "or"TOASTED "
print("\^o040"..verb..tostr(encount[tmp]).." VOID "..tmp,x-45,20+y+8*e,15)
end
print("\^w\^t\^o040GAME OVER",x-35,y-30,15)
print("\^o040rEACHED LVL "..tostr(p.level),x-28,y-15,15)
print("\^o040❎ AGAIN / 🅾️ QUIT",x-34,y,15)
end
end_screen=scene:extend({
init=end_init,
upd=end_upd,
drw=end_drw,
})
function dopart(_ENV)
if wait then
wait-=1
if wait<=0 then
wait=nil
if parentp then
x=parentp.x;y=parentp.y
if offsetx then
x+=offsetx
end
if offsety then
y+=offsety
end
end
end
else
age=age or 0
c=c or ctab[i]
if age==0 then
ox=x
oy=y
size=size or 1
ctabv=ctabv or 0
tospd=tospd or 1
elseif freezeat==age then
global.freeze_frames=freezeframes
end
age+=1
if age<=0 then return end
if ctab then
local ci=(age+ctabv)/maxage
ci=mid(1,flr(1+ci*#ctab),#ctab)
c=ctab[ci]
end
if tox then
x+=(tox-x)/(4/tospd)
end
if toy then
y+=(toy-y)/(4/tospd)
end
if rotspd then
rota=rota or 0
cdist=cdist or 8
rota+=rotspd
x=cx+sin(rota)*cdist
y=cy+cos(rota)*cdist
end
if sx then
if cx then
cx+=sx
else
x+=sx
end
if tox then
tox+=sx
end
if drag then
sx*=drag
end
end
if sy then
if cy then
cy+=sy
else
y+=sy
end
if toy then
toy+=sy
end
if drag then
sy*=drag
end
end
if tosize then
size+=(tosize-size)/(5/tospd)
end
if incrsize then
size+=incrsize
end
if age>=maxage or size<1 then
if onendf then onendf() end
if onend=="return"then
maxage+=32000
tox=ox
toy=oy
tosize=nil
incrsize=-0.3
elseif onend=="fade"then
maxage+=32000
tosize=nil
incrsize=-0.1-rnd(0.3)
else
del(parts,_ENV)
end
ctab=nil
onend=nil
end
end
end
particle=game_object:extend({
age=0,
maxage=0,
x=63,
y=63,
size=1,
ctabv=nil,
spd=1,
upd=dopart,
init=function(_ENV)
ox=x
oy=y
add(parts,_ENV)
if pinit then pinit(_ENV) end
end,
drw=function(_ENV)
if(wait) return
pdrw(_ENV)
end
})
function tweenp_init(_ENV)
add(global.parts,_ENV)
if tweens then
chaintweens(tweens,function()
del(global.parts,_ENV)
end)
end
end
tweenp=particle:extend({
upd=_noop,
init=tweenp_init,
})
function drw_circle(_ENV)
if border then
fillp(0xffff)
circfill(x,y,size/2+1,c)
fillp(0x0)
end
circfill(x,y,size/2,c)
end
circlep=particle:extend({
size=1,
border=false,
pdrw=drw_circle
})
rectp=particle:extend({
iwidth=2,
iheight=1,
border=false,
pinit=function(_ENV)
width=iwidth*size
height=iheight*size
end,
upd=function(_ENV)
width=size*iwidth
height=size*iheight
dopart(_ENV)
end,
drw=function(_ENV)
local w,h=width/2,height/2
rectfill(x-w,y-h,x+w,y+h,c)
if border then
fillp(0xffff)
rect(x-w,y-h,x+w,y+h,c)
fillp(0x0)
end
end
})
function hit_particles(a)
if debug_on then
particle:new({
x=a.x,
y=a.y,
sizex=a.sizex,
sizey=a.sizey,
c=12,
pdrw=function(_ENV)
rectfill(x-sizex/2,y-sizey/2,x+sizex/2,y+sizey/2,c)
end,
maxage=20,
})
end
local n=mid(20,a.sizex*a.sizey/10,150)
for i=1,n do
local t=i/(n+1)
local spread=.4
local angle=lerp(-spread,spread,t)
local reach_mult=a.hor and a.sizex/4 or a.sizey/4
local arc_r=a.hor and a.sizex/4 or a.sizey/4
local ox,oy
local basepos_mult=.2
if a.dir=="r"then
ox=a.x+cos(angle)*arc_r*basepos_mult
oy=a.y+sin(angle)*arc_r
elseif a.dir=="l"then
ox=a.x-cos(angle)*arc_r*basepos_mult
oy=a.y+sin(angle)*arc_r
elseif a.dir=="d"then
ox=a.x+sin(angle)*arc_r
oy=a.y+cos(angle)*arc_r*basepos_mult
elseif a.dir=="u"then
ox=a.x+sin(angle)*arc_r
oy=a.y-cos(angle)*arc_r*basepos_mult
end
local mid=(a.dir=="l"or a.dir=="r") and .6 or .5
local center=1-abs(t-mid)*2
local reach=(0.5+center*0.5)*reach_mult
local tsize=max(1,n/40)+center*3
local spd=3+center*2
local endx,endy=ox,oy
local endpos_mult=.05
if a.dir=="r"then
endx=ox+cos(angle)*reach
endy=oy+sin(angle)*reach*endpos_mult
elseif a.dir=="l"then
endx=ox-cos(angle)*reach
endy=oy+sin(angle)*reach*endpos_mult
elseif a.dir=="d"then
endx=ox+sin(angle)*reach*endpos_mult
endy=oy+cos(angle)*reach
elseif a.dir=="u"then
endx=ox+sin(angle)*reach*endpos_mult
endy=oy-cos(angle)*reach
end
local p=circlep({
x=ox,
y=oy,
c=7,
size=1,
upd=_noop,
})
chaintweens({
{
tween_factory(p,"size",tsize,spd,quint),
tween_factory(p,"x",endx,spd,quint),
tween_factory(p,"y",endy,spd,quint),
},
{
tween_factory(p,"size",0,spd/1.5,smootherstep),
}
},function()
del(global.parts,p)
end)
end
end
function enhurt(_ENV)
n=20
local c=142
circlep({
size=10,
c=7,
x=x,
y=y,
maxage=2
})
circlep({
size=10,
ctab={8,14},
x=x,
y=y,
maxage=4
})
for i=1,n do
circlep({
size=rnd(3),
c=231,
x=x,
y=y,
sx=rnd(),
sy=rnd(),
wait=6,
border=chance(.25),
maxage=rndrange(3,4),
onend="fade"
})
end
end
function enhit(_ENV)
n=10
circlep({
size=10,
c=7,
x=x,
y=y,
wait=0,
maxage=3
})
for i=1,n do
circlep({
size=rnd(3),
c=c,
x=x,
y=y,
sx=rnd(),
sy=rnd(),
wait=3,
border=chance(.25),
maxage=rndrange(10,15),
onend="fade",
})
end
end
cd_bar=game_object:extend({
barwidth=10,
barheight=1,
drw=function(_ENV)
x=p.x
y=p.y+9
local progress=lerp(0,barwidth,mid(0,1-p.hit_t/p.hit_cd,1))
local bx=x-barwidth/2
line(bx,y,bx+barwidth,y,0)
line(bx,y,bx+progress,y,7)
end
})
dash_bar=game_object:extend({
barwidth=6,
barheight=1,
drw=function(_ENV)
if p.has_dash then
x=p.x
y=p.y+11
local progress=lerp(0,barwidth,mid(0,1-p.dasht/p.dash_cd,1))
local bx=x-barwidth/2
line(bx,y,bx+barwidth,y,0)
line(bx,y,bx+progress,y,12)
end
end
})
xp_bar=game_object:extend({
barwidth=46,
barheight=3,
drw=function(_ENV)
x=cam.x
y=cam.y+50
progress=lerp(0,barwidth-2,mid(0,p.xp/p.level_ups[min(p.level,#p.level_ups)],1))
local bx=flr(x-barwidth/2)
rectfill(bx,y,bx+barwidth,y+barheight,barc)
rectfill(bx+1,y+1,bx+1+progress,y+barheight-1,12)
print("\^o040LVL ",bx-12,y-1,barc)
print("\^o040"..tostr(p.level),bx+barwidth+4,y-1,barc)
end
})
hp_bar=game_object:extend({
x=64,
y=108,
barwidth=60,
barheight=3,
drw=function(_ENV)
x=cam.x
y=cam.y+56
progress=lerp(0,barwidth-2,p.hp/p.maxhp)
local bx=flr(x-barwidth/2)
rectfill(bx,y,bx+barwidth,y+barheight,barc)
rectfill(bx+1,y+1,bx+barwidth-1,y+barheight-1,6)
rectfill(bx+1,y+1,bx+progress+1,y+barheight-1,14)
print("\^o040HP:",bx-12,y,barc)
end
})
game_ui=game_object:extend({
barc=15,
bars={},
init=function(_ENV)
add(bars,xp_bar({barc=barc}))
add(bars,hp_bar({barc=barc}))
add(bars,cd_bar())
add(bars,dash_bar())
end,
upd=function(_ENV)
upd_group(bars)
end,
drw=function(_ENV)
drw_group(bars)
for oven in all(ovens) do
oven:drw_indicator()
end
end,
})
upgrade_ui=game_object:extend({
selected=1,
init=function(_ENV)
age=0
buttons={}
x=scene.cam.x;y=scene.cam.y
global.paused=true
for part in all(parts) do
del(parts,part)
end
for tw in all(routines) do
if tw.pausable then del(routines,tw) end
end
global.routines={}
for i=1,#upgrades do
add(buttons,upgrade_button({x=-64+32*i,y=-10,upgrade=upgrades[i],selected=i==1}))
end
sbutt=buttons[selected]
end,
upd=function(_ENV)
age+=1
if btnp(➡️) then
sfx(8)
selected+=1
selected=selected>#buttons and 1 or selected
end
if btnp(⬅️) then
sfx(8)
selected-=1
selected=selected<1 and#buttons or selected
end
sbutt=buttons[selected]
for button in all(buttons) do
button.selected=sbutt==button
end
if btnp(🅾️) or btnp(❎) then
sfx(11)
sbutt:trigger()
upgrades={}
buttons={}
global.ui=game_ui
global.paused=false
end
end,
drw=function(_ENV)
if age<70 then
print("\^o040\^w\^t◆ lvl "..tostr(p.level).." ◆",x-42,y-50,
sin(age/12)>-.85 and 7 or 15)
end
drw_group(buttons)
rectfill(x-64,y+54,x+64,y+64,7)
print(sbutt.upgrade.name,x-2*#sbutt.upgrade.name,y+57,0)
end
})
upgrade_button=game_object:extend({
x=0,
y=0,
bc=0,
c=15,
upgrade=nil,
selected=false,
init=function(_ENV)
width=width or 24
height=height or 24
end,
drw=function(_ENV)
sx=cam.x+x
sy=cam.y+y
local bx=sx-width/2
local by=sy-width/2
if selected then
rectfill(bx-1,by-1,bx+width+1,by+height+1,7)
end
rectfill(bx,by,bx+width,by+height,bc)
rectfill(bx+1,by+1,bx+width-1,by+height-1,c)
mspr(upgrade.icon,sx,sy)
end,
trigger=function(_ENV)
upgrade:trigger()
end
})
transition=game_object:extend({
frames=30,
cols=split"8, 8, 8, 8, 14, 14, 14, 4, 4 ",
n=16,
spd=.3,
current_size=0,
fsize=8,
shrink=false,
trans=smootherstep,
init=function(_ENV)
sfx(0)
circles={}
global.trans=_ENV
for i=1,n do
for j=1,n do
local circle={x=(i-1)*128/(n-1),y=(j-1)*128/(n-1),r=0,c=rnd(cols)}
add(circles,circle)
local wait=rnd(15)
chaintweens({
tween_factory(circle,"r",rndrange(4,8),frames-wait,trans),
tween_wait(wait,function()
global.scene:load(new_scene)
end),
{
tween_factory(circle,"r",0,frames,trans),
}
},function() global.trans=nil end,false)
end
end
shuffle(circles)
end,
drw=function(_ENV)
for circle in all(circles) do
local r=circle.r
local x=peek2(0x5f28)+circle.x
local y=peek2(0x5f2a)+circle.y
if r>2 then
circfill(x,y,r+1,2)
end
circfill(x,y,r,circle.c)
end
end
})
function story_init(_ENV)
pressed=false
load_stored_gfx(story_gfx)
_upd=story_upd
_drw=story_drw
x,y=startpx,startpx-64
mapx,mapy=rndrange(0,6),0
local xsep=28
images={
{s=myspr[54],x=x-4,y=y-24,tx=x-xsep,ty=y-59},
{s=myspr[55],x=x-2,y=y-22,tx=x+xsep,ty=y-59},
{s=myspr[56],x=x,y=y-20,tx=x-xsep,ty=y-22},
{s=myspr[57],x=x+2,y=y-18,tx=x+xsep,ty=y-22},
{s=myspr[58],x=x+4,y=y-16,tx=x,ty=y+14}
}
frames=60
imgi=1
texts=split2d"\n❎/🅾️ to continue|looks like our poor,friendly baker is getting fired!|i guess she's got,nothing to loose now...|she decides to,bake one last batch...|she hears ominous sounds,coming from the oven...|the bread is alive!,and it is not friendly..."
end
function story_upd(_ENV)
if imgi>#images then
if(btnp(🅾️) or btnp(❎)) and not pressed then
pressed=true
transition({new_scene=game})
end
else
if btnp(🅾️) or btnp(❎) then
sfx(47)
dotween(images[imgi],"x",images[imgi].tx,frames,overshoot)
dotween(images[imgi],"y",images[imgi].ty,frames,overshoot)
imgi+=1
end
end
end
function story_drw(_ENV)
cls(2)
rectfill(x-64,y+34,x+128,y+128,c)
local text=texts[imgi] or texts[#texts]
for i=1,#text do
print(text[i],x-#text[i]/2*4,y+29+i*7,15)
end
for i=1,#images do
local img=images[#images+1-i]
mspr(img.s,img.x,img.y)
end
end
story=scene:extend({
init=story_init,
upd=story_upd,
drw=story_drw,
})
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
ccc0099999990ccccccccc0767670cccccccccc07676760cccccc00000000ccccc0999bb9bb9990cccc0000ccccccccc05ddd455554ddd500004442044400000
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
__label__
8882eeeeeee2eeeeeee2eeeeeee28888888288888882eeeeeee288888882eeeeeee2eeeeeee28888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee28888
8882eeeeeee2eeeeeee2eeeeeee28888888288888882eeeeeee288888882eeeeeee2eeeeeee28888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee28888
8882eeeeeee2eeeeeee2eeeeeee28888888288888882eeeeeee288888882eeeeeee2eeeeeee28888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee28888
888e2eeeee2e2eeeee2e2eeeee28888888888888888e2eeeee288888888e2eeeee2e2eeeee28888888888888888e2eeeee2e2eeeee2e2eeeee2e2eeeee288888
888eeeeeeeeeeeeeeeeeeeeeeee8888888888888888eeeeeeee88888888eeeeeeeeeeeeeeee8888888888888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88888
8882eeeeeee2eeeeeee2eeeeeee28888888288888882eeeeeee288888882eeeeeee2eeeeeee28888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee28888
8882eee2eee2eee2eee2eee2eee28882888288828882eee2eee288828882eee2eee2eee2eee28882888288828882eee2eee2eee2eee2eee2eee2eee2eee28882
222222ee222222ee222222ee2222228822222288222222ee22222288222222ee222222ee2222228822222288222222ee222222ee222222ee222222ee22222288
88828888888288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee28888
88828888888288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee28888
88828888888288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee28888
8888888888888888888888888888888888888888888e2eeeee2e2eeeee288888888e2eeeee288888888e2eeeee2e2eeeee2e2eeeee288888888e2eeeee288888
8888888888888888888888888888888888888888888eeeeeeeeeeeeeeee88888888eeeeeeee88888888eeeeeeeeeeeeeeeeeeeeeeee88888888eeeeeeee88888
88828888888288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee28888
88828882888288828882888288828882888288828882eee2eee2eee2eee288828882eee2eee288828882eee2eee2eee2eee2eee2eee288828882eee2eee28882
2222228822222288222222882222228822222288222222ee222222ee22222288222222ee22222288222222ee222222ee222222ee22222288222222ee22222288
eee2eeeeeee2eeeeeee2eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee288888882eeeeeee2888888828888888288888882eeeeeee2eeee
eee2eeeeeee2eeeeeee2eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee288888882eeeeeee2888888828888888288888882eeeeeee2eeee
eee2eeeeeee2eeeeeee2eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee288888882eeeeeee2888888828888888288888882eeeeeee2eeee
eeee2eeeee2e2eeeee2e2eeeee2e2eeeee288888888e2eeeee288888888e2eeeee2e2eeeee288888888e2eeeee2888888888888888888888888e2eeeee2e2eee
eeeeeeeeeeeeeeeeeeeeeeee0000000eeee88888888eeeeeeee88888888eeeeeeeeeeeeeeee88888888eeeeeeee888888888888888888888888eeeeeeeeeeeee
eee2eeeeeee2eeeeeee2ee00444444400ee288888882eeeeeee288888882eeeeeee2eeeeeee288888882eeeeeee2888888828888888288888882eeeeeee2eeee
eee2eee2eee2eee2eee2e0444444444440e288828882eee2eee288828882eee2eee2eee2eee288828882eee2eee2888288828882888288828882eee2eee2eee2
222222ee222222ee222204444422244444022288222222ee22222288222222ee222222ee22222288222222ee222222882222228822222288222222ee222222ee
888288888882eeeeeee2022444828444220288888882eeeeeee288888882888888828888888288888882eeeeeee2888888828888888288888882eeeeeee2eeee
888288888882eeeeeee2099224444422990288888882eeeeeee288888882888888828888888288888882eeeeeee2888888828888888288888882eeeeeee2eeee
888288888882eeeeeee2099992222299990288888882eeeeeee288888882888888828888888288888882eeeeeee2888888828888888288888882eeeeeee2eeee
88888888888eeeeeeee880999999999990888888888e2eeeee288888888000000000000888888888888e2eeeee2888888888888888888888888e2eeeee2eeeee
88888888888eeeeeeee882009999999002888888888eeeeeeee88888880666666666666088888888888eeeeeeee888888888888888888888888eeeeeeeeeeeee
888288888882eeeeeee2822200000002228288888882eeeeeee288888066555555555566088288888882eeeeeee2888888828888888288888882eeeeeee2eeee
888288828882ee2eeee2882222222222288288828882eee2eee288828065555555555556088288828882eee2eee2888288828882888288828882eee2eee2ee2e
22222288222222ee222222882222222822222288222222ee22222288206555954554555602222288222222ee222222882222228822222288222222ee222222ee
888288888882eeeeeee28888888288888882eeeeeee2eeeeeee2eeeee0655554444555560882eeeeeee28888888288888882eeeeeee288888882888888828888
888288888882eeeeeee28888888288888882eeeeeee2eeeeeee2eeeee0665549a9a955660882eeeeeee28888888288888882eeeeeee288888882888888828888
888288888882eeeeeee28888888288888882eee0000000eeeee2eeeee006654aa99a46600882eeeeeee28888888288888882eeeeeee288888882888888828888
88888888888e2eeeee28888888888888888ee00444444400ee2eeeeee050666666666605088eeeeeeee8888888888888888eeeeeeee888888888888888888888
88888888888eeeeeeee8888888888888888e0444444444440eeeeeeee055000000000055088eeeeeeee8888888888888888eeeeeeee888888888888888888888
888288888882eeeeeee2888888828888888044444222444440e2eeeee0555545044405550882ee0000008888888288888882eeeeeee288888882888888828888
888288828882eee2eee2888288828882888022444ee2444220e2ee2ee055d420244420550882e06767670882888288828882ee2eeee288828882888288828882
22222288222222ee2222228822222288222099224444422b002222ee205dd4202442bb05022220676767028822222288222222ee222222882222228822222288
888288888882eeeeeee2eeeeeee288888880999922222b0990e2eeeee05ddd40922b44200882e06767670888888288888882eeeeeee28888888288888882eeee
888228888882eeeeeee2eeeeeee2888888820999999999990ee2eeeee05dddd0992442bb0882e06767670088888288888882eeeeeee28888888288888882eeee
888282888882eeeeeee2eeeeeee2888888822009999999002ee2eeeeeebbbbbb09922b442082e06767679908888288888882eeeeeee28888888288888882eeee
88888888888e2eeeee2e2eeeee288888888e2220000000222eeeeeeeeee8888880992442bb0e20999999999088888888888e2eeeee28888888888888888e2eee
88888888888eeeeeeeeeeeeeeee88888888ee22222222222eeeeeeeeeee888888809922b4440e09fff99999088888888888eeeeeeee8888888888888888eeeee
888288888882eeeeeee2eeeeeee288888882eee2222222eeeee2eeeeeee288888880992444400907f07f9990888288888882eeeeeee28888888288888882eeee
888288828882eee2eee2eee2eee288828882eee2eee2ee2eeee2ee2eeee288828882099244400907f07f9990888288828882eee2eee28882888288828882eee2
22222288222222ee222222ee22222288222222ee222222ee222222ee2222228822222099220220ffffff999902222288222222ee2222228822222288222222ee
888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee28888888288000082e077777779990ee288888882eeeeeee2eeeeeee288888882eeee
888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee22888888228888882e07727777990eee288888882eeeeeee2eeeeeee288888882eeee
888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee28288888282888882e0f77777f90eeee288888882eeeeeee2eeeeeee288888882eeee
88888888888e2eeeee2e2eeeee2e2eeeee2eeeeeeeeeeeeeeeee2eeeee28888888888888888e2e07277700eeee288888888e2eeeee2e2eeeee288888888eeeee
88888888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8888888888888888eee2000002eeeeee88888888eeeeeeeeeeeeeeee88888888eeeee
888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee28888888288888882e220020022eeeee288888882eeeeeee2eeeeeee288888882eeee
888288828882eee2eee2eee2eee2eee2eee2ee2eeee2ee2eeee2eee2eee28882888288828882e222222222e2eee288828882eee2eee2eee2eee288828882ee2e
22222288222222ee222222ee222222ee222222ee222222ee222222ee222222882222228822222222222222ee22222288222222ee222222ee22222288222222ee
eee288888882eeeeeee2eeeeeee288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee28888888288888882eeeeeee2eeeeeee2eeee
eee288888882eeeeeee2eeeeeee288888882eeeeeee288888882288888822888888288888882eeeeeee2eeeeeee28888888288888882eeeeeee2eeeeeee2eeee
eee288888882eeeeeee2eeeeeee288888882eeeeeee28888888282888882828888828888888277777777777eeee28888888288888882eeeeeee2eeeeeee2eeee
ee288888888eeeeeeeee2eeeee288888888eeeeeeee88888888888888888888888888888888e2eeeee2e2eeeee28888888888888888e2eeeee2e2eeeee2eeeee
eee88888888eeeeeeeeeeeeeeee88888888eeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeee8888888888888888eeeeeeeeeeeeeeeeeeeee
eee288888882eeeeeee2eeeeeee288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee28888888288888882eeeee000000000e2eeee
eee288828882ee2eeee2eee2eee288828882ee2eeee288828882888288828882888288828882eee2eee2eee2eee28882888288828882eee2022222222202ee2e
22222288222222ee222222ee22222288222222ee22222288222222882222228822222288222222ee222222ee2222228822222288222222e029999222222022ee
8882eeeeeee2eeeeeee2eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee28888888288888882ee020b90b92222220888
8882eeeeeee2eeeeeee2eeeeeee288888882888888822888888228888882eeeeeee2eeeeeee288888882eeeeeee28888888228888882ee040b90b94444440888
8882eeeeeee2eeeeeee2eeeeeee288888882888888828288888282888882eeeeeee2eeeeeee288888882eeeeeee28888888282888882ee0499bb994444440888
888eeeeeeeeeeeeeeeeeeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeee88888888e2eeeee28888888888888888e2ee042bb422222208888
888eeeeeeeeeeeeeeeeeeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeee88888888eeeeeeee8888888888888888eeeeeeeeeeeeeeee88888
8882eeeeeee2eeeeeee2eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee28888888288888882eeeeeee2eeeeeee28888
8882ee2eeee2ee2eeee2ee2eeee288828882888288828882888288828882ee2eeee2ee2eeee288828882eee2eee28882888288828882eee2eee2ee2eeee28882
222222ee222222ee222222ee22222288222222882222228822222288222222ee222222ee22222288222222ee2222228822222288222222ee222222ee22222288
888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeee
888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeee
888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeee
88888888888e2eeeee288888888888888888888888888888888eeeeeeeee2eeeee2eeeeeeee88888888888888888888888888888888e2eeeee2e2eeeee2eeeee
88888888888eeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeeeeeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeeeeeeee
888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeee
888288828882eee2eee288828882888288828882888288828882ee2eeee2eee2eee2ee2eeee288828882888288828882888288828882eee2eee2eee2eee2ee2e
22222288222222ee22222288222222882222228822222288222222ee222222ee222222ee22222288222222882222228822222288222222ee222222ee222222ee
eee2eeeeeee2888888828888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee28888888288888882eeee
eee2eeeeeee2888888822888888228888882eeeeeee2eeeeeee2eeeeeee2eeeeeee228888882eeeeeee2eeeeeee2eeeeeee2eeeeeee22888888228888882eeee
eee2eeeeeee2888888828288888282888882eeeeeee2eeeeeee2eeeeeee2eeeeeee282888882eeeeeee2eeeeeee2eeeeeee2eeeeeee28288888282888882eeee
eeee2eeeee2888888888888888888888888eeeeeeeeeeeeeeeeeeeeeeeee2eeeee288888888e2eeeee2e2eeeee2e2eeeee2eeeeeeee8888888888888888e2eee
eeeeeeeeeee888888888888888888888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8888888888888888eeeee
eee2eeeeeee2888888828888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee28888888288888882eeee
eee2eee2eee2888288828882888288828882ee2eeee2ee2eeee2ee2eeee2eee2eee288828882eee2eee2eee2eee2eee2eee2ee2eeee28882888288828882eee2
222222ee222222882222228822222288222222ee222222ee222222ee222222ee22222288222222ee222222ee222222ee222222ee2222228822222288222222ee
eee2888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee2eeeeeee28888888288888882888888828888
eee2888888822888888228888882eeeeeee2eeeeeee228888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee2eeeeeee22888888228888882288888828888
eee2888888828288888282888882eeeeeee2eeeeeee282888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee2eeeeeee28288888282888882828888828888
ee2888888888888888888888888e2eeeee2eeeeeeee88888888eeeeeeeeeeeeeeeeeeeeeeee88888888e2eeeee2e2eeeee288888888888888888888888888888
eee888888888888888888888888eeeeeeeeeeeeeeee88888888eeeeeeeeeeeeeeeeeeeeeeee88888888eeeeeeeeeeeeeeee88888888888888888888888888888
eee2888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee2eeeeeee28888888288888882888888828888
eee2888288828882888288828882eee2eee2ee2eeee288828882ee2eeee2ee2eeee2ee2eeee288828882eee2eee2eee2eee28882888288828882888288828882
222222882222228822222288222222ee222222ee22222288222222ee222222ee222222ee22222288222222ee222222ee22222288222222882222228822222288
88828888888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee2eeeeeee28888
88828888888228888882eeeeeee288888882288888828888888228888882eeeeeee2eeeeeee288888882eeeeeee228888882eeeeeee2eeeeeee2eeeeeee28888
88828888888282888882eeeeeee288888882828888828888888282888882eeeeeee2eeeeeee288888882eeeeeee282888882eeeeeee2eeeeeee2eeeeeee28888
8888888888888888888eeeeeeee88888888888888888888888888888888eeeeeeeee2eeeee288888888e2eeeee288888888e2eeeee2e2eeeee2e2eeeee288888
8888888888888888888eeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeee88888888eeeeeeee88888888eeeeeeeeeeeeeeeeeeeeeeee88888
88828888888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee288888882eeeeeee2eeeeeee2eeeeeee28888
88828882888288828882ee2eeee288828882888288828882888288828882ee2eeee2eee2eee288828882eee2eee288828882eee2eee2eee2eee2eee2eee28882
2222228822222288222222ee22222288222222882222228822222288222222ee222222ee22222288222222ee22222288222222ee222222ee222222ee22222288
eee2eeeeeee288888882888888828888888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee28888
eee2eeeeeee228888882288888822888888288888882eeeeeee288888882288888822888888228888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee28888
eee2eeeeeee282888882828888828288888288888882eeeeeee288888882828888828288888282888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeeee28888
eeeeeeeeeee88888888888888888888888888888888eeeeeeee88888888888888888888888888888888eeeeeeeee2eeeee2e2eeeee2e2eeeee2eeeeeee555558
eeeeeeeeeee88888888888888888888888888888888eeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee566658
eee2eeeeeee288888882888888828888888288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeeeeee2eeeeeee2eeeeee566658
eee2ee2eeee288828882888288828882888288828882ee2eeee288828882888288828882888288828882ee2eeee2eee2eee2eee2eee2eee2eee2ee2eee566652
222222ee22222288222222882222228822222288222222ee22222288222222882222228822222288222222ee222222ee222222ee222222ee222222ee22555558
eee2888888828888888288888882eeeeeee2eeeeeee288888882eeeeeee28888888288888882eeeeeee2eeeeeee288888882eeeeeee2eeeeeee288888882eeee
eee2888888828888888228888882eeeeeee2eeeeeee288888882eeeeeee22888888228888882eeeeeee2eeeeeeefff888882eeeeeee2eeeeeee288888882eeee
eee2888888828888888282888882efeeefefefeeefffffffffffffffffffffffffffffffffffffffffffffffeee00f888882eeeeeee2eeeeeee288888882eeee
eee888888888888888888888888e2feeef2fefeeefccccccccccccccccccccccccccccccffffffffffffffffeeefff88888e2eeeee2eeeeeeee88888888eeeee
eee888888888888888888888888eefeeefffefeeefccccccccccccccccccccccccccccccffffffffffffffffeeef0088888eeeeeeeeeeeeeeee88888888eeeee
eee2888888828888888288888882e0ffe0f0e0ffefffffffffffffffffffffffffffffffffffffffffffffffeeefff888882eeeeeee2eeeeeee288888882eeee
eee2888288828882888288828882ee00ee02ee00eee288828882eee2eee28882888288828882eee2eee2ee2eeee000828882eee2eee2ee2eeee288828882ee2e
222222882222228822222288222222ee222222ee22222288222222ee2222228822222288222222ee222222ee22222288222222ee222222ee22222288222222ee
8882eeeeeee288888882eeeeeee2888888fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeeee288888882eeeeeee2eeeeeee2eeee
8882eeeeeee288888882eefefeeff88f88feeeeeeeeeeee66666666666666666666666666666666666666666666666feeee288888882eeeeeee2eeeeeee2eeee
8882eeeeeee288888882eefefef0f88088feeeeeeeeeeee66666666666666666666666666666666666666666666666feeee288888882eeeeeee2eeeee0000000
888eeeeeeee88888888e2efffefff88f88fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeeee88888888e2eeeee2eeee004455544
888eeeeeeee88888888eeef0fef00880888eeeeeeee88888888888888888888888888888888eeeeeeeeeeeeeeeeeeeeeeee88888888eeeeeeeeeee0444456544
8882eeeeeee288888882ee0e0e0288888882eeeeeee288888882888888828888888288888882eeeeeee2eeeeeee2eeeeeee288888882eeeeeee2e04444455544
8882ee2eeee288828882eee2eee288828882eee2eee288828882888288828882888288828882ee2eeee2ee2eeee2ee2eeee288828882eee2eee2e0224442ee44
222222ee22222288222222ee22222288222222ee22222288222222882222228822222288222222ee222222ee222222ee22222288222222ee2222209922444442

__map__
a0a0b0b0b1b1a0a0b0b0b0a0a0b0a0b0b0a0a0b0b0b0b0a0b0a0a0b0b0b0b0a0b0b0a0b1a1a0a0a0a0a1a1a1a1b1b1b1b1b1a1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0b0a0b0b1a0a0a0a0a0a0a0a0b0b0a0b0a0b0b0b0a0b0a0a0a0a0b0b0b0b0b0a0a0b0a1a1a1a1b1b1b1b1b1a1b1b1b1b1a1a0a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0b0a0a0b1b1b1b0b0b0b0a0b0a0b0b0a0b0a0a0a0b0b0a0a0a1b0b0b0b0b0b0a0b0b1b1a0a0b1b1b1a1b1b1a1b1b1b1a1a0a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0a0a0a1a1a1a0a0b1a0a0a0b0a0a0a0a0b0a0a0a0b0b1b1a1b0b0a1a0b0b0b0a1a1b1b1b1a1a1a0a1a1b1b1b1a1a0a0a0a1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0a1b0a0a1b0a1a0a0b0a0a0b1b0b1b1a0b1a0a0b1a0a0a0a0a1b1b0a1a1a0b0b0a0a1a0a1a1b1b1b1a1b1b1b1b1b1a0a0b1a1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0b1a0a1b0a0a1a1b0b0a0b0b1b1a0a0b0a0a0b0a0a0b0a1b0b0b1b0a0a1a0a0b0a1a0b1b1a1a1a1b1b1b1a1a1a1a1a1a1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0b0b1a0a1b0a0a0a0b0b0b0b1b1b0a1a1b0b0a0b0b0a0b1b1b0b0b0b1b0a0a0a0b1b0a1a1b1b1a1a1b1b1b1a1b1b1b1b1b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0a0a0a1a1a0a0b0a0b1b0a0b1a0a1a1a0b0b0a0a0b0b0b1b1a0a0a0b0b1b0b0b0b1b0b1a1a1b1a1b1b1b1a1a0a1a1a1b1b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0a0a1a1b1a0a0b1b1b1a0a0a1a1b1b1a0b0a0a1b0b1a0a0a0a0b0b0b1b0a0b0b1a0b1b1a1b1b1a1b1b1a0a0a1a1a0a1a1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0b1a0b0b1b1a0a0b0a0a0a0a0b1b0b1a0a0a0a0b0b0b1b1b0a0b1b0a1a0b0b0a0a0b1b1a1a1b1a1b1b1a0a1a1a0a1b1a1a1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0a0b0b0b0b1b1b1b0a0a1a1b1b1b1b0a1b0b0b0b1a1a1b0a0a0a0b1b0a0a0b0b0a0b1b1b1a1a1b1a1b1a1b1b1a1a1b1b1b1a1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b1b1b0a0a0a0b1b0a0a1a1b0b1a1b1b1b1a0b0b0a1a1a1a0a0b0b1b0a0a0a0b1a0a0b1b1a1b1b1b1a1b1b1b1a1a1b1b1b1b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b1b1a0a0b1b1b0a0a0a1b1a0a1a0a1b1b0a0b0a1b0b0b0a0b1b1b1a0a0a0a1a0a0b0b0b1a1b1a0b1b1b1b1a1a1b1b1b1b1b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b1a0a0a0b0b0b0b1b1a1a1a1a0b1a0a1a1a1b1b0b0b0b1a0b1b1b1b0b0b0b1b1b1b0a0b1a1a0a0a1a1b1b1a1b1b1b1a1b1b1b1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b1b0b0a0a0b0b0b1a0a0a1b0b1a0b0a1a1b0b1a1b0b1a0b1b1a0a0b0b0b0b1b1b0a0a0b1a1a1a0a0a1b1b1a1b1b1b1a1a1b1a1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0b0a0a0a1a1a1b1a0b0a0b0a0a0a1a1b1b1b1a0b0b1b1b1b0b1a0a0a0b0b1b0b1a0b1b1b1a1a1a1a1a1a1b1b1a1a1a1a1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b1b0a0a0a1a1a1a1a0b0b0a0b0a0b1b0b0a0a0a0a0b0a0b1b1b1b1a0a0a0b1b1a0b1a0b1a1a0a0b1b1a1a1b1b1a1a1b1a1b1b1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0a0a0a1a0b0b0a0b1b0a0a0a0a0b0b0b0a0a0a0a0a0b0a1b1b1b0a0b0b1b1b1b1a0a0b1b1a1a0a1a1a1b1b1a1a1b1b1b1a1b1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0a0b0a1b0b1b1a0b1a0a0a0b0b0b0a0b1b1b1b0b0b0a1b1a1b0a0b1b1b0b1b1b1b1a0b1b1b1a1a1b1b1b1b1b1b1a1b1b1b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a1b1b0b0b1b1b1b0a1a1b0a0b1a0a0a0b0b1a0a0b1a0b0a1a1a0a0b1b0b0b1b0a0a0b0a1b1a0a1b1b1b1b1b1a0b1b1b1b1b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a1a0a0b0b0a0a0b1a0a0a0b0b0a0a0b0b1b0b1a0a0a1b0b1b1a0b0a1a1a1b1a1a0b1b0a1a1a0b1b1b1b1b1a1a0a1a0a0a0b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0b0a0a1a1b0b1a0a0a1a0b0b0b0b0b1b1a0a0b0a1a0b1a1b0b0b0b0b1a1a0a0a0b1b0b1a1b1b1b1b1b1a1a0a1b1a1a0a0a0a1a100000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0b0a0a1a1a0a0b1a0a1b0b0b0b0b0a0a0a1a1a0b0b1b1a0a0a0b1b1a0b1b0b1b1b0b1b1b1b1a1b1a1a1a0a1b1b1a0a0a0b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0a0b0b0b0b0b0b0b1a0a1a1a1b0a0b0b0b0b0b1b0b0b1a0b0b1b1a0b1b1b1b0a1a1b1a1b1a1b1b1b1b1b1b1a1b1b1a0a0b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0a0b0b0b0b0b1b1b1b0a0b0b0a0b0b0b0a0a0a0b1b0b1a1b0a0b1b0b0a0a1a0a0a1b0b1b1a1a0a0b1b1b1a1b1b1b1b1a0a0a1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0b0b0b1b1b1b0b0b0b0a0b0b0b0b0a1a0b1a0a0b0b1b1b0a0b1b0a1a1a0a0b0b1a1b1b1a1a0a0a1a1b1b1a1b1a1b1b1a1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b0a0b1a0a0b0a0a0b0b0a0b0b0b1b1a1a1a0a0b0b0a0a0b0a0b0a1b1b1a1b0b0b1b0b1b1b1b1a0a0b1b1b1b1b1a1b1a1b1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b1b1b1a0a1a0a1a1b1b1b1b1b1b1b1a0a0b0a0a1b0b1b0a0a0a0a0b0b1b0b0a1a0a0b1b1a1b1b1b1b1b1b1a1a1a0a1b1b1a1b1b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b1b0a0b0b0a0a0a1a1b1b0b0b1b0b0b0b0a0a0a1b0b1b0b0a0a0a0b0b0a1a1b1a0a0a1b1b1a1b1b1a1b1a1b1a0a0b1b1b1a1a1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0b1a1b0b0b0b0a0a1b0b1b1a0a0b1a0a0b0b0a1b1b0a0a0a0a1b0b0b0a1b0b1a1a0a0b1b1a1a0a1b1b1b1b1a0a1a1b1b1b1b1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0a0b0b1b0b0b0b0b0b0b0a0a0b0b1b1b0b1b1a1b0b0a0b0b0b0b0a1b0b0a1a1b1a1a1b1a1a1a0a0b1b1b1a1a1b1b1b1a0b1a1a100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0a0b0b1a0b0b0a0a0a0a0a0b0b0b0b1b1b1a0a1b1b0b0b0b0a1a1b0b0a1a1a1b1b1a1b1b1b1b1b1a1b1b1b1b1a1b1b1b1a0a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0005000011574160741357418074155641a064165641b054185541d0541a7541f5441b044217441d544220441f744245342103426734220242772424014297140070400704007040070400704007040070400704
000800000f00013001170011800000000000000000000000000000000000000000000000000000000000000025700000000000000000000000000000000000000000000000000000000000000000000000000000
000300000c1000e101101011210113101141011510115105000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000006400084000d4000f4001a400214002240000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
000400000c5000f50114001180011b0011d0012000017000140000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
000300000c7000f001130011310500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00060000190011c0011f00122001280051f000220002200021000220001f0001f000220002200021000220001f0001f0002e0012e0002d0002e0002b0002b0002b0022b005000000000000000000000000000000
000200000c1040d1010e5010f50110001110011270113701147011570500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400002152526535005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
000300002f73534735000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003053534535044000440010400044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000180251f535260452a55512604176011b6011f601226012560128601296012b601296012760124601216011f6011c601186011560113601116010f6010e60500500005000050000500005000050000500
0002000019045000001e0450000023045000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00040000260452b035300253000500703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703
000400002474526745297452e7453074532745357453a7452400526005290052e0053000532005350053a00500000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000197070c700197070c7001c7070c7001c7070c7001e7070c700217070c700217070c700237070c700237070c700257070c700287070c7000c7000c700135000c600135000c600135050c605135050c605
00010000287070c700257070c700257070c700237070c700237070c700217070c700217070c7001e7070c7001c7070c7001c7070c70019707127050c700127050070000700007000070000700007000070000700
00020000016300d6311c63131631146310c63108631056310263501601016050c600116001a600006000060000600006000060000600006000060000600006000000000000000000000000000000000000000000
00020000052070060710207006071230700607123070160712307016070a107006070d107006070d107006070b007006070b007006070a007006070a707006070b707006070c707006070b107006070810700607
000400002763022630206201b6201661015610116100d6100b6100761005610036100261002610026100261001610016100161501600016000160001600000000000000000000000000000000000000000000000
00070000386003060025600206001c60019600176001560012600106000f6000d6000b6000a603086030760306603046030360303603006050060500605006050060500605006050060500605006050060500605
000200000c405152040f404186051640515204114040e6050d4050b20408405066040440502204014040060500404002040040500605000040000400004000040000400004000040000400004000040000400004
0002000012005112050f0050e2050d0050c2050b0050a205090050820507005062050500504205030050220501005012050400503205010050760506605066050560504605046050360502605016050160501605
000200001d0041320514005142051200515205110051620510005172050e0050a2050700508205050050800503005042050400503205010050760506605066050560504605046050360502605016050160501605
000200003f603232033a60121201346011e2012f601172012a60112201246010d2011e60109201186010520111601032010c60101201086050120504605002050260500605006000060500600006000060000600
0a0200000c303236050930520601063011b6010430116601023010f601013010a6010360104600036000260001600016000460003600026000160001600016000160004600036000260001600016000160001600
0005000032201376012a20133601222012e6011b2012560115201216010c2011d601092011960106201166010320112601022010e601012010a60100201086010020104601002010360100201026010020100601
000500001230311303103030f3030e3030e3030d3030d3030c3030c3030b3030b3030a3030a303093030930308303083030730307303063030630305303053030430304303033030330302303023030130301303
000100000c1000e0011100114001170011700014001120010f0010c10100100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000500000c406186060c406186060c406186060c406186060c406186060c406184060040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
0002000002205006000340500600052050060008405006000b205006000d405006001020500600124050060011205006000f405006000d2050060009405006000620500600054050060003205006000340500600
000200003f6042640525301242012340122301212013f6041f3050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000a4033b2010a1033b4010b003302010b303302010a1033b2010a4033b2010a0033b2010a1033b201091033a201091033a6010a4033b2010a1033b2010a7033b2010a3033b2010a1033b2010a6033b401
000100003b30039300363003470032700307002e7002b700297002670023700235000b20007200062000520003200022000120001200000000000000000000000000000000000000000000000000000000000000
00020000133051f3052b3053730537305003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000000
000100001d201202012f2012c2013e2013d2011d0001d0001d0001d0001d0001d0001d00000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
000100002b50329503265032550323501215011f5011c5011950118501165011450113501105010d5010b50108501075010550103501025010150102400023000130003400024000140001400024000240001400
000100000f12500000000000710500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000c13515003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004000014103007000c1000000000000000001010300700000000000000000000000b10300700000000000000000000000610300700000000000000000000000310300700000000000000000000000110300700
000200000c00006701037050070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
000c00000c30300300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
0005000011504160041350418004155041a004165041b004185041d0041a7041f5041b004217041d504220041f704245042100426704220042770424004297040070400704007040070400704007040070400704
000500000b00012701127050c00013701137050d00014701147050f00016701167050f00014705147010d00013705137010c00012705127010b0000a0050a70500000000000d0001400014005000000000000000
000300000c303236050930520601063011b6010430116601023010f601013010a6010360104600036000260001600016000460003600026000160001600016000160004600036000260001600016000160001600
00020000187051a5051c7051550517705195051270514505167050f50511705135050c7050e505107050060000600006000060000600006000060000600006000060000600006000060000600006000060000600
000600001c36311000103331031310303107031070513005306041070310705000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000f76010751117412f70013751157511674118731197212f7052f70032700037000070037700377002f7002f7002f7002f700007003370004700007000070000700007000070000700007000070000700
001000001c1031c1031c1031c1031b1031a1030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300002e3022b30128302263012330221301203021d3011b3021a3011930217301153021330112302103010e3020c3010b30209301073020630104302033010230201301013020030100300003000030000300
00010000352003750534100371003f10039100331001f1001f1001f1001f100231002a10034100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00090000013050130501305000002660021600196001260011607116070c60710607156071a6071e607206072260722607206001d6001c60018600156001560014600166001a6001c6001c600166000f60000000
000200001d3051d7051d3051370513305137050070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
000a00002470129701000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300001d60506303156002d60001600016000160002600026000360003600036000d60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000c0050c0050c005110050c0050c0050c00516005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
0007000023705287052d3021e105370021c0051330213302133021330213302133021330213302133021330213302133021330213302133021330213302133021320207002070022b0001f0001f0021f0021f002
000400002f3002f3002f3003430034300343003430034300343003430034300343003430034300343003430034300343003430500300003000030000300003000030000300003000030000300003000030000300
000200001d6051e605083010a4010b3010c4010d3010f40111301134011530117401193011b4011b3011d3011830510305163050f3050e3050d3050c3050b3050a30509305083050630505305043050000000000
000900001d62514625070250652502204006050550005500266002460023600216001f6001d6001c6001a60018600176001660015600146000030000300003000030000300003000030000300003000030000300
00020000071040f103163030b20332603216031c6031860315603136030e6030a60304600000000000000000000000b1010710105101031010110100000000000000000000000000000000000000000000000000
0012000015703047000500005700070000770009000097000b0000b7000c0000c7000c000180000c000180000c000180000c00018000210022100221002000000000000000000000000000000000000000000000
000600002330311000103030400010705107031070513005306041070310705000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000137071c507142071d707155071e107167071f507161071f707175072010718707215071910722707115071a107127071b50718100210001950022100140001d500151001e000165001f1001700020500
