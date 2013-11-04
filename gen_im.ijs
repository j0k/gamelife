NB. dumping result as images & creating result .gif file

load 'life1.ijs'
load 'viewmat'
load '~J0kutils/viewmatsave.ijs'
load '~J0kutils/boxcyc.ijs'
load 'task'

form =: > @: ('r<0>5.0'& (8!:0))
NB. http://www.jsoftware.com/help/dictionary/dx008.htm

mN =: (". ;. _2) 0 : 0		NB. deltaplane)
0 0 0 0 0 0 0
0 0 0 1 0 0 0
0 1 0 1 0 0 0
0 0 1 1 0 0 0
0 0 0 0 0 0 0
0 0 0 0 0 0 0
0 0 0 0 0 0 0
)
]m1     =: 3 : 'mN' f.


mats   =: ;/ lifenext^:(]`m1) i.3
NB. ]mats   =: ;/ lifenext^:(]`m1) i.3
NB. ┌─────────────┬─────────────┬─────────────┐
NB. │0 0 0 0 0 0 0│0 0 0 0 0 0 0│0 0 0 0 0 0 0│
NB. │0 0 0 1 0 0 0│0 0 1 0 0 0 0│0 0 0 1 0 0 0│
NB. │0 1 0 1 0 0 0│0 0 0 1 1 0 0│0 0 0 0 1 0 0│
NB. │0 0 1 1 0 0 0│0 0 1 1 0 0 0│0 0 1 1 1 0 0│
NB. │0 0 0 0 0 0 0│0 0 0 0 0 0 0│0 0 0 0 0 0 0│
NB. │0 0 0 0 0 0 0│0 0 0 0 0 0 0│0 0 0 0 0 0 0│
NB. │0 0 0 0 0 0 0│0 0 0 0 0 0 0│0 0 0 0 0 0 0│
NB. └─────────────┴─────────────┴─────────────┘


imnames =:(,&'.bmp') @: ('image_'&,) @: form each ;/i.#mats
NB. ┌───────────────┬───────────────┬───────────────┐
NB. │image_00000.bmp│image_00001.bmp│image_00002.bmp│
NB. └───────────────┴───────────────┴───────────────┘
            
     
r =: mats;<imnames
;`'' (boxcyc L:1) cross r
          
NB. ┌───────────────────────────┬───────────────────────────┬───────────────────────────┐
NB. │┌─────────────┬───────────┐│┌─────────────┬───────────┐│┌─────────────┬───────────┐│
NB. ││0 0 0 0 0 0 0│image_0.bmp│││0 0 0 0 0 0 0│image_1.bmp│││0 0 0 0 0 0 0│image_2.bmp││
NB. ││0 0 0 1 0 0 0│           │││0 0 1 0 0 0 0│           │││0 0 0 1 0 0 0│           ││
NB. ││0 1 0 1 0 0 0│           │││0 0 0 1 1 0 0│           │││0 0 0 0 1 0 0│           ││
NB. ││0 0 1 1 0 0 0│           │││0 0 1 1 0 0 0│           │││0 0 1 1 1 0 0│           ││
NB. ││0 0 0 0 0 0 0│           │││0 0 0 0 0 0 0│           │││0 0 0 0 0 0 0│           ││
NB. ││0 0 0 0 0 0 0│           │││0 0 0 0 0 0 0│           │││0 0 0 0 0 0 0│           ││
NB. ││0 0 0 0 0 0 0│           │││0 0 0 0 0 0 0│           │││0 0 0 0 0 0 0│           ││
NB. │└─────────────┴───────────┘│└─────────────┴───────────┘│└─────────────┴───────────┘│
NB. └───────────────────────────┴───────────────────────────┴───────────────────────────┘
save =: (1&{::) viewmatsave 0&{::
NB. save each ;`'' (boxcyc L:1) cross r

makegif  =: 1 : 0
	'animated.gif' u makegif y
:
	fieldv  =. u
	if. _1 = {.y do.
	       	max       =. ((100"0)`{:)@.(<:@#) y
 	  	mats    =. ;/ lifenext^:(]`fieldv) i. max
		inds    =. _1:`( ((0 2)&{)@:(0&,) )@.(# >: 2:) I. >:&2 +/ =/~ mats
		mats    =. (( {. + i.@({: - {.))`((i.#mats)"0)@.(_1 = {.) inds ) { mats
	else.
		mats    =. ;/ lifenext^:(]`fieldv) i.y	
	end.
	imnames =. (,&'.bmp') @: ('image_'&,) @: form each ;/i.#mats
	r       =. mats;<imnames
	boxes   =. ;`'' (boxcyc L:1) cross r
	save each boxes
	_1 fork_jtask_ 'cp image_00000.bmp image_000000.bmp'
	_1 fork_jtask_ 'cp image_00000.bmp image_000001.bmp'
	_1 fork_jtask_ 'cp image_00000.bmp image_000002.bmp'
	_1 fork_jtask_ 'convert -delay 20 -loop 0 *.bmp ',x
	_1 fork_jtask_ 'sleep 3; rm -f image_*'  NB._1 how to wait?
)


'anim.gif' m1 makegif 50		NB. create animated.gif from 50 bmps
'animsome.gif' m1 makegif _1 300	NB. create animated.gif gen 100 bmps & try to finde cycle

NB. load 'debug'			
NB. dbss 'makegif *:*'
NB. dbr 1
NB. dbr 0


NB. mN =: (". ;. _2) 0 : 0		NB. some
NB. 0 0 0 0 0 0 0 0 0
NB. 0 0 0 1 0 0 0 0 0
NB. 0 1 0 1 0 0 0 0 0
NB. 0 0 1 1 0 0 1 1 0
NB. 0 0 0 0 0 0 1 0 0
NB. 0 0 0 0 0 0 1 1 0
NB. 0 0 0 0 0 0 1 1 0
NB. 0 0 1 1 0 0 0 0 0
NB. 0 0 1 1 0 0 0 0 0
NB. 0 0 0 0 0 0 0 0 0
NB. )
NB. ]m1     =: 3 : 'mN' f.
NB. 'animsome.gif' m1 makegif _1 300 NB. animsome.gif gen 300 bmps & try to finde cycle