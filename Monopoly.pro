?-
G_Flag=0, 
G_Question is bitmap_image("images\\Chance.bmp", _),
 window(size(1300, 650), title("Monopoly"), paint_indirectly).

win_func(paint) :-
 pen(3, rgb(0,0,0)),
 brush(rgb(0, 0, 0)),
 line(970,250, 970, 10, 10, 10, 10, 10),
 line(10, 10, 10, 600,970 ,600, 970, 10),
 line(970,100, 10, 100),
 line(970,500, 10, 500),
  line(820,10, 820, 600),
 line(160,10, 160, 600),
 %up
 line(730,10, 730, 100),
 line(230,10, 230, 100),
 line(660,10, 660, 100), %-70
 line(300,10, 300, 100), %+70
 line(590,10, 590, 100),
 line(370,10, 370, 100),
 line(520,10, 520, 100),
 line(440,10, 440, 100),
 %down
 line(730,500, 730, 600),
 line(230,500, 230, 600),
 line(660,500, 660, 600), %-70
 line(300,500, 300, 600), %+70
 line(590,500, 590, 600),
 line(370,500, 370, 600),
 line(520,500, 520, 600),
 line(440,500, 440, 600),
 %right
 line(970,460,820, 460),
 line(970,420, 820, 420),
 line(970,380, 820, 380), %-40
 line(970,340, 820, 340), %+40
 line(970,280, 820, 280),
 line(970,240, 820, 240),
 line(970,200, 820, 200),
 line(970,160, 820, 160),
 %left
 line(10,460,160, 460),
 line(10,420, 160, 420),
 line(10,380, 160, 380), %-40
 line(10,340, 160, 340), %+40
 line(10,280, 160, 280),
 line(10,240, 160, 240),
 line(10,200, 160, 200),
 line(10,160, 160, 160),
 
 brush(rgb(250,250,250)),
 ellipse(170, 110,350, 250), 
 draw_bitmap(200, 150,G_Question, _, _),
 ellipse(810, 490,650, 350), 
 draw_bitmap(730, 400,G_Question, _, _),

 
 brush(rgb(250, 50, 200)),
 round_rect(455,295,495,335,15,15),
 round_rect(505,295,545,335,15,15).
  
win_func(init):-
  G_Button := button( class(but_func), text("Throw dice"), pos(430,345), size(90,25) ).

win_func(paint):-
  pen(brush(rgb(250,250,250))),
  draw_points(6).

but_func(press):-
  G_Flag:=0,
  cursor(w),
  enable_window(G_Button, 0),
  %position(B,R,_),
  Z is 1+random(6),write(Z),
  pen(3,rgb(255,255,255)), write(a),
  brush(rgb(250, 50, 200)),
  round_rect(455,295,495,335,15,15),
  wait(0.6),
  brush(rgb(255,255,255)),
  pen(3,rgb(255,255,255)),
  draw_points(Z),
  (member4(R,S,_),(S>0, S+Z=<62;S=0, Z=6)->
    set(position(B,R,Z)),
    G_Flag:=1
  else
    answer(B,R),
    enable_window(G_Button, 1)
  ).
but_func(press):-
  beep.

draw_points(6) :-
  ellipse(461,311,469,319),
  ellipse(481,311,489,319),
  ellipse(461,323,469,331),
  ellipse(481,323,489,331),
  ellipse(461,299,469,307),
  ellipse(481,299,489,307).
draw_points(5) :- 
  ellipse(461,323,469,331),
  ellipse(481,323,489,331),
  ellipse(461,299,469,307),
  ellipse(481,299,489,307),
  ellipse(471,311,479,319).
draw_points(4) :- 
  ellipse(461,323,469,331),
  ellipse(481,323,489,331),
  ellipse(461,299,469,307),
  ellipse(481,299,489,307).
draw_points(3) :- 
  ellipse(461,323,469,331),
  ellipse(481,299,489,307),
  ellipse(471,311,479,319).
draw_points(2) :- 
  ellipse(461,323,469,331),
  ellipse(481,299,489,307).
draw_points(1) :-
  ellipse(471,311,479,319).


