$PBExportHeader$w_base.srw
forward
global type w_base from window
end type
end forward

global type w_base from window
integer width = 3378
integer height = 1408
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_base w_base

type variables
eon_appeon_resize  ieon_resize
end variables

forward prototypes
public subroutine wf_setflag ()
end prototypes
// Test Clonflict HttpClientTest
public subroutine wf_setflag ();// 设置各个控件的具体resize逻辑
//ieon_resize.of_setflag(aws,'1111')
//flag描述  1 1 1 1 分别对应x y width height
//x: 0/no   1/scale  2/fixtoright  
//y: 0/no   1/scale  2/fixtobottom 
//width: 0/no   1/scale  2/scalefixtoright  3/scalefixtoleft 4/scaletoright 5/scaletoleft
//height: 0/no   1/scale  2/scalefixtobottom  3/scalefixtotop 4/scaletobottom 5/scaletotop
end subroutine

event open;ieon_resize = create eon_appeon_resize
ieon_resize.of_init(this,true)
wf_setflag()
end event

on w_base.create
end on

on w_base.destroy
end on

event resize;ieon_resize.of_resize(this,newwidth,newheight,true)
end event
//234
