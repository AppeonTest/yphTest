$PBExportHeader$w_appeon_base.srw
forward
global type w_appeon_base from w_base
end type
type mle_output from multilineedit within w_appeon_base
end type
type cb_5 from commandbutton within w_appeon_base
end type
type cb_4 from commandbutton within w_appeon_base
end type
type cb_3 from commandbutton within w_appeon_base
end type
type mle_view from multilineedit within w_appeon_base
end type
type mle_dec from multilineedit within w_appeon_base
end type
type cb_2 from commandbutton within w_appeon_base
end type
type cb_1 from commandbutton within w_appeon_base
end type
type lb_1 from listbox within w_appeon_base
end type
type gb_1 from groupbox within w_appeon_base
end type
type gb_2 from groupbox within w_appeon_base
end type
type gb_3 from groupbox within w_appeon_base
end type
type gb_4 from groupbox within w_appeon_base
end type
end forward
// TestConflict HttpclientTest 2323237
global type w_appeon_base from w_base
integer width = 3579
integer height = 2972
string title = "Testcase"
windowstate windowstate = maximized!
event ue_runall ( )
mle_output mle_output
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
mle_view mle_view
mle_dec mle_dec
cb_2 cb_2
cb_1 cb_1
lb_1 lb_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_appeon_base w_appeon_base

type variables
string is_realfile,is_expfile

integer ii_index

string is_realvalue,is_testitems

string is_testpurpose

integer ix_or,iy_or,iw_or,ih_or
end variables

forward prototypes
public subroutine wf_setflag ()
public subroutine wf_output (string as_msg, boolean ab_clear)
public subroutine wf_init ()
public subroutine wf_additem (string as_testitem)
public subroutine wf_desc_mult (multilineedit amle)
public subroutine wf_scriptview (string as_script)
public subroutine wf_scriptexe (integer ai_item, boolean ab_execute)
public subroutine wf_saveresult (string as_result)
end prototypes

event ue_runall();
integer i

for i = 1 to lb_1.TotalItems()
     mle_view.text = ''
	 lb_1.selectitem(i)
	 wf_ScriptExe(i, false)
	 wf_ScriptExe(i, true)	
	 is_realvalue += mle_output.text
next

//将结果记录到txt中
wf_saveresult(is_realvalue)


end event

public subroutine wf_setflag ();//设置框架中控件的resize逻辑
//位置不变的控件
ieon_resize.of_setflag( mle_dec, "0000")
ieon_resize.of_setflag( gb_1, "0000")
//保持下间距向下延伸的控件
ieon_resize.of_setflag(gb_2,"0002")
ieon_resize.of_setflag(lb_1,"0002")
//位置向下移动,宽度向右延伸的控件
ieon_resize.of_setflag(gb_4,"0220")
ieon_resize.of_setflag(mle_output,"0220")
//大小不变，向下移动的控件
ieon_resize.of_setflag(cb_1,"1200")
ieon_resize.of_setflag(cb_2,"1200")
ieon_resize.of_setflag(cb_3,"1200")
ieon_resize.of_setflag(cb_4,"1200")
ieon_resize.of_setflag(cb_5,"1200")
//向右和想下延伸的控件
ieon_resize.of_setflag(mle_view,"0022")
ieon_resize.of_setflag(gb_3,"0022")
//右上方空白区域，客户自定义控件只向右延伸，即0020

end subroutine

public subroutine wf_output (string as_msg, boolean ab_clear);//Function : Wf_OutPut
//Argument : String   as_mess;   The Message you will output 
//				 Boolean  ab_clear;  Clear Flag
//Output   : None
//Designer : 
//Date     :
////////////////////////////////////////////////////////////////

If ab_clear Then
	mle_output.Text = ""
	ii_index = 0
End IF	

ii_index = ii_index + 1
mle_output.Text += as_msg+"~r~n"
end subroutine

public subroutine wf_init ();//设置测试点,多个测试点通过逗号分隔

is_testitems = "example1,example2"

//初始化结果集文件
is_expfile = "exp.txt"
is_realfile = "real.txt"

//清空运行值
is_realvalue = ""

//设置测试总体描述
is_testpurpose = ""

//setflag新加的控件可以在此resize


end subroutine

public subroutine wf_additem (string as_testitem);//将测试点加入到listbox
string ls_testcase[]
long ll_loop
ieon_resize.of_stringtoarray(as_testitem,ls_testcase,",")

for ll_loop = 1 to upperbound(ls_testcase)
	lb_1.additem(ls_testcase[ll_loop])
next
end subroutine

public subroutine wf_desc_mult (multilineedit amle);amle.text  = "1.Test Window : "
amle.text +=  Classname() + "~r~n" //This Must be the First output
amle.text += "2.Testing Purpose : " // This must include
amle.text +=  is_testpurpose+"~r~n" 

end subroutine

public subroutine wf_scriptview (string as_script);//You must Define this Function for view and Execute Script

//////////////////////////////////////////////////////////////////////
//Function: wf_scriptview  View a line Script
//Argument: String  as_mess a line Script
//Output:   none
//Designer:
//Date:
/////////////////////////////////////////////////////////////////////

mle_view.Text += as_script + "~r~n"

Return
end subroutine

public subroutine wf_scriptexe (integer ai_item, boolean ab_execute);
//You need override the function

//////////////////////////////////////////////////////////////////////
//Function: wf_Script  View and Execute Script
//Argument: Int ai_item: SelectedItem;
//          Boolean ab_execute: Execute or View Flag
//Output:   none
//Designer:
//Date:
/////////////////////////////////////////////////////////////////////
String ls_item

If ai_item < 1 Then Return
ls_item = lb_1.text(ai_item)

If ab_execute Then 
	wf_output("-----Test Point:" + ls_item + "-----", True)
End If

Choose Case ls_item
	Case 'example1' //for example
		If ab_execute = True Then		
			date ld_now
			ld_now = today()
			wf_OutPut('today() = ' + string(ld_now,'yyyy-mm-dd'), False)
		Else
			wf_scriptview("date ld_now                                        ")
			wf_scriptview("ld_now = today()                                   ")
			wf_scriptview("wf_OutPut('today() = ' + string(ld_now,'yyyy-mm-dd'), False)      ")
		End If
	Case Else	
	 	MessageBox("Error","This Point Not Coding",Exclamation!)
End Choose

end subroutine

public subroutine wf_saveresult (string as_result);//将结果记录到real.txt中
long ll_file

filedelete(is_realfile)

ll_file = fileopen(is_realfile,textmode!,write!,shared!,replace!,encodingutf8!)

//filewriteex(ll_file,Blob ( as_result, encodingutf8!) )
filewriteex(ll_file, as_result )

fileclose(ll_file)
end subroutine

on w_appeon_base.create
int iCurrent
call super::create
this.mle_output=create mle_output
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.mle_view=create mle_view
this.mle_dec=create mle_dec
this.cb_2=create cb_2
this.cb_1=create cb_1
this.lb_1=create lb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_output
this.Control[iCurrent+2]=this.cb_5
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.mle_view
this.Control[iCurrent+6]=this.mle_dec
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.lb_1
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.gb_4
end on

on w_appeon_base.destroy
call super::destroy
destroy(this.mle_output)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.mle_view)
destroy(this.mle_dec)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.lb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;wf_init()

wf_additem(is_testitems)

wf_desc_mult(mle_dec)
end event

type mle_output from multilineedit within w_appeon_base
integer x = 41
integer y = 2476
integer width = 3461
integer height = 196
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;//ix_or = this.x
//iy_or = this.y
//iw_or = this.width
//ih_or = this.height
//
//this.move(lb_1.x,lb_1.y)
//this.resize( lb_1.width,lb_1.height)
//this.bringtotop = true
end event

event losefocus;//this.move(ix_or,iy_or)
//this.resize( iw_or,ih_or)
//this.bringtotop = true
end event

type cb_5 from commandbutton within w_appeon_base
integer x = 3035
integer y = 2724
integer width = 457
integer height = 132
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_4 from commandbutton within w_appeon_base
integer x = 2391
integer y = 2724
integer width = 457
integer height = 132
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clear"
end type

event clicked;mle_output.text = ""
mle_view.text = ""
end event

type cb_3 from commandbutton within w_appeon_base
integer x = 1687
integer y = 2724
integer width = 457
integer height = 132
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Execute"
end type

event clicked;IF not lb_1.selectedindex() > 0 THEN
	MessageBox("Warning","Please select a test item")
	return 
END IF
mle_view.text = ''
wf_Scriptexe(lb_1.selectedindex(),False)
wf_Scriptexe(lb_1.selectedindex(),True)
end event

type mle_view from multilineedit within w_appeon_base
integer x = 1650
integer y = 952
integer width = 1861
integer height = 1424
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type mle_dec from multilineedit within w_appeon_base
integer x = 18
integer y = 92
integer width = 1550
integer height = 748
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_appeon_base
integer x = 955
integer y = 2724
integer width = 457
integer height = 132
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "View Result"
end type

event clicked;string ls_pass

ls_pass = is_expfile +","+is_realfile

openwithparm(w_viewresult,ls_pass)
end event

type cb_1 from commandbutton within w_appeon_base
integer x = 192
integer y = 2724
integer width = 457
integer height = 132
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Auto Run"
end type

event clicked;parent.triggerevent( "ue_runall")
end event

type lb_1 from listbox within w_appeon_base
integer x = 18
integer y = 876
integer width = 1563
integer height = 1496
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//view Script
IF index > 0 THEN
	mle_view.text = ''
	mle_output.text = ''
	wf_Scriptexe(this.selectitem(index),False)
END IF
end event

event doubleclicked;//Execute Script
IF index > 0 THEN
	wf_Scriptexe(this.selectedindex(),True)
END IF
end event

type gb_1 from groupbox within w_appeon_base
integer width = 1600
integer height = 876
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Description"
end type

type gb_2 from groupbox within w_appeon_base
integer y = 796
integer width = 1600
integer height = 1600
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "TestItem"
end type

type gb_3 from groupbox within w_appeon_base
integer x = 1632
integer y = 848
integer width = 1897
integer height = 1552
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Script View"
end type

type gb_4 from groupbox within w_appeon_base
integer x = 9
integer y = 2396
integer width = 3515
integer height = 304
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "OutPut"
end type

