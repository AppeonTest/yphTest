$PBExportHeader$w_httpclient_memory.srw
forward
global type w_httpclient_memory from window
end type
type cb_4 from commandbutton within w_httpclient_memory
end type
type st_3 from statictext within w_httpclient_memory
end type
type hpb_1 from hprogressbar within w_httpclient_memory
end type
type cb_3 from commandbutton within w_httpclient_memory
end type
type cbx_3 from checkbox within w_httpclient_memory
end type
type cbx_2 from checkbox within w_httpclient_memory
end type
type cbx_1 from checkbox within w_httpclient_memory
end type
type st_2 from statictext within w_httpclient_memory
end type
type st_1 from statictext within w_httpclient_memory
end type
type cb_2 from commandbutton within w_httpclient_memory
end type
type cb_1 from commandbutton within w_httpclient_memory
end type
end forward

global type w_httpclient_memory from window
integer width = 1714
integer height = 736
boolean titlebar = true
string title = "HttpClient Memory Test"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
st_3 st_3
hpb_1 hpb_1
cb_3 cb_3
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_httpclient_memory w_httpclient_memory

type prototypes

end prototypes

type variables
eon_appeon_resize  ieon_resize
Long 		il_count
Boolean 	ib_continue = True
Boolean ib_debug = false
string is_ip
end variables

forward prototypes
public function string wf_gettimestamp ()
public function string wf_getrandom ()
end prototypes

public function string wf_gettimestamp ();Long 		ll_days, ll_Seconds, ll_microsecond
Double 	ll_Stamp
Date 		ld_Today
Time 		lt_Now

ld_Today = Today()
ll_days = DaysAfter ( Date(1970,1,1), ld_Today )

lt_Now = Now()
ll_Seconds = SecondsAfter ( Time ( 8,0,0 ), lt_Now )

ll_Stamp = ll_days * 24 * 60 * 60 + ll_Seconds


Return String ( ll_Stamp ) + Left ( String ( lt_now, "ffffff" ), 3 )
end function

public function string wf_getrandom ();Long 		ll_Random

ll_Random = Rand(32767)

Return String ( ll_Random )
end function

on w_httpclient_memory.create
this.cb_4=create cb_4
this.st_3=create st_3
this.hpb_1=create hpb_1
this.cb_3=create cb_3
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_4,&
this.st_3,&
this.hpb_1,&
this.cb_3,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_httpclient_memory.destroy
destroy(this.cb_4)
destroy(this.st_3)
destroy(this.hpb_1)
destroy(this.cb_3)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;ieon_resize = create eon_appeon_resize

ieon_resize.of_init(this,true)

is_ip = profilestring("config.ini","settings","Restful_http_PHP","") //PHP Restful
end event

event resize;ieon_resize.of_resize(this,newwidth,newheight,true)
end event

type cb_4 from commandbutton within w_httpclient_memory
integer x = 23
integer y = 496
integer width = 517
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "下载测试(1000+M)"
end type

event clicked;Long	ll_i, ll_cpu,li_FileNum,ll_rtn, ll_Code,ll_loop, flen, loops, i, ll_num, ll_postition, ll_Length, ll_Count
Blob lb_data,lb_temp, b
String ls_txt,ls_response, ls_Length

ib_continue = False

ghc_Client.ClearRequestHeaders()

//获取文件的大小
//ll_rtn = ghc_Client.sendrequest( "HEAD", "http://download.appeon.com/APB/2016/ebf/build_1128.00/unix/APB-2016-EBF1128-UNX-AP-001.zip" )
ll_rtn = ghc_Client.sendrequest( "HEAD", "https://api.appeon.com/test/data500.txt" )

ls_response = ghc_Client.GetResponseHeaders()
ls_Length = ghc_Client.GetResponseHeader( "Content-Length" )
ll_Length = Long ( ls_Length )
hpb_1.maxposition = ll_Length / 100000
hpb_1.position = 0

If cbx_1.Checked = false Then
	ghc_Client.autoreaddata = true
	ll_cpu = cpu()

	ll_rtn = ghc_Client.sendrequest( "GET", "http://download.appeon.com/APB/2016/ebf/build_1128.00/unix/APB-2016-EBF1128-UNX-AP-001.zip" )
	//ll_rtn = ghc_Client.sendrequest( "GET", "http://192.0.2.195/restful/APB2016EBF1128X32WINAP001.zip" )
	st_2.Text = "本次cpu：" + String ( (cpu() - ll_cpu) )
	ghc_Client.GetResponsebody( lb_data)
	flen = Len (lb_data)
	ll_num = FileOpen("APB-2016-EBF1128-UNX-AP-001.zip", StreamMode!, Write!, LockWrite!, Replace!)	
	If flen > 32765 Then
		If Mod(flen, 32765) = 0 Then
			loops = flen/32765
		ELSE
			loops = (flen/32765) + 1
		End If
	ELSE
		loops = 1
	End If
	
	FOR i = 1 to loops					
		b = BlobMid ( lb_data,32765 * ( i - 1) + 1, 32765 )
		FileWrite(ll_num, b)
	NEXT
	FileClose(ll_Num)

Else
	ghc_Client.autoreaddata = false
	//ll_rtn = ghc_Client.sendrequest( "GET", "http://download.appeon.com/APB/2016/ebf/build_1128.00/unix/APB-2016-EBF1128-UNX-AP-001.zip" )
	//ll_rtn = ghc_Client.sendrequest( "GET", "http://192.0.2.195/restful/APB2016EBF1128X32WINAP001.zip" )
	ll_rtn = ghc_Client.sendrequest( "GET", "https://api.appeon.com/test/data500.txt" )
	
	ll_loop = 1024 * 100
	
//	Do While ( ll_rtn = 1 )
//		ll_rtn = ghc_Client.ReadData( lb_temp, ll_loop)	
//		lb_data =  lb_data + lb_temp
//		hpb_1.position = ( Len ( lb_data )/100000)
//		
//		st_3.Text = "下载进度:" + String ( Len ( lb_data ) ) + "/" + ls_Length
//		yield()
//	Loop
	
	
//	st_2.Text = "本次cpu：" + String ( (cpu() - ll_cpu) )
//	flen = Len (lb_data)
//	ll_num = FileOpen("download1.zip", StreamMode!, Write!, LockWrite!, Replace!)	
//	If flen > 32765 Then
//		If Mod(flen, 32765) = 0 Then
//			loops = flen/32765
//		ELSE
//			loops = (flen/32765) + 1
//		End If
//	ELSE
//		loops = 1
//	End If
//	
//	FOR i = 1 to loops					
//		b = BlobMid ( lb_data,32765 * ( i - 1) + 1, 32765 )
//		FileWrite(ll_num, b)
//	NEXT
//	FileClose(ll_Num)
	//直接写到文件中
	ll_num = FileOpen("APB-2016-EBF1128-UNX-AP-001.zip", StreamMode!, Write!, LockWrite!, Replace!)	
	Do While ( ll_rtn = 1 )
		lb_temp = Blob("")
		ll_rtn = ghc_Client.ReadData( lb_temp, ll_loop)	
		FileWrite(ll_num, lb_temp)
		ll_Count  += Len ( lb_temp )
		hpb_1.position = ( ll_Count/100000)		
		st_3.Text = "下载进度:" + String (  ll_Count  ) + "/" + ls_Length
		lb_temp = Blob("")
		yield()
	Loop
	
	st_2.Text = "本次cpu：" + String ( (cpu() - ll_cpu) )
	//st_2.Text = "下载完成"
	
	FileClose(ll_Num)

End If

				

lb_data = Blob ("" )
lb_temp = Blob ("")


end event

type st_3 from statictext within w_httpclient_memory
integer x = 558
integer y = 552
integer width = 882
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "下载进度:"
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_httpclient_memory
integer x = 558
integer y = 480
integer width = 1074
integer height = 68
unsignedinteger maxposition = 44792
unsignedinteger position = 1
integer setstep = 1
end type

type cb_3 from commandbutton within w_httpclient_memory
integer x = 23
integer y = 392
integer width = 466
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "下载测试(42.7M)"
end type

event clicked;Long	ll_i, ll_cpu,li_FileNum,ll_rtn, ll_Code,ll_loop, flen, loops, i, ll_num, ll_postition, ll_Length
Blob lb_data,lb_temp, b
String ls_txt,ls_response, ls_Length

ib_continue = False

ghc_Client.ClearRequestHeaders()

//获取文件的大小
ll_rtn = ghc_Client.sendrequest( "HEAD", "http://download.appeon.com/APB/2017/ga/APB-2017-DOC-AP-001.zip" )
ls_response = ghc_Client.GetResponseHeaders()
ls_Length = ghc_Client.GetResponseHeader( "Content-Length" )
ll_Length = Long ( ls_Length )
hpb_1.maxposition = ll_Length / 10000
hpb_1.position = 0

If cbx_1.Checked = false Then
	ghc_Client.autoreaddata = true
	ll_cpu = cpu()

	ll_rtn = ghc_Client.sendrequest( "GET", "http://download.appeon.com/APB/2017/ga/APB-2017-DOC-AP-001.zip" )
	st_2.Text = "本次cpu：" + String ( (cpu() - ll_cpu) )
	ghc_Client.GetResponsebody( lb_data)
	flen = Len (lb_data)
	ll_num = FileOpen("download.zip", StreamMode!, Write!, LockWrite!, Replace!)	
	If flen > 32765 Then
		If Mod(flen, 32765) = 0 Then
			loops = flen/32765
		ELSE
			loops = (flen/32765) + 1
		End If
	ELSE
		loops = 1
	End If
	
	FOR i = 1 to loops					
		b = BlobMid ( lb_data,32765 * ( i - 1) + 1, 32765 )
		FileWrite(ll_num, b)
	NEXT
	FileClose(ll_Num)

Else
	ghc_Client.autoreaddata = false
	ll_rtn = ghc_Client.sendrequest( "GET", "http://download.appeon.com/APB/2017/ga/APB-2017-DOC-AP-001.zip" )
	
	ll_loop = 1024 * 100
	
	Do While ( ll_rtn = 1 )
		ll_rtn = ghc_Client.ReadData( lb_temp, ll_loop)	
		lb_data =  lb_data + lb_temp
		hpb_1.position = ( Len ( lb_data )/10000)
		
		st_3.Text = "下载进度:" + String ( Len ( lb_data ) ) + "/" + ls_Length
		yield()
	Loop
	
	
	st_2.Text = "本次cpu：" + String ( (cpu() - ll_cpu) )
//	flen = Len (lb_data)
//	ll_num = FileOpen("download.zip", StreamMode!, Write!, LockWrite!, Replace!)	
//	If flen > 32765 Then
//		If Mod(flen, 32765) = 0 Then
//			loops = flen/32765
//		ELSE
//			loops = (flen/32765) + 1
//		End If
//	ELSE
//		loops = 1
//	End If
//	
//	FOR i = 1 to loops					
//		b = BlobMid ( lb_data,32765 * ( i - 1) + 1, 32765 )
//		FileWrite(ll_num, b)
//	NEXT
//	FileClose(ll_Num)
End If

				

lb_data = Blob ("" )
lb_temp = Blob ("")


end event

type cbx_3 from checkbox within w_httpclient_memory
integer x = 987
integer y = 68
integer width = 370
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "log"
end type

event clicked;if cbx_2.Checked Then
	ib_debug = true
Else
	ib_debug = false
End If
end event

type cbx_2 from checkbox within w_httpclient_memory
integer x = 571
integer y = 68
integer width = 370
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "debug"
end type

event clicked;if cbx_2.Checked Then
	ib_debug = true
Else
	ib_debug = false
End If
end event

type cbx_1 from checkbox within w_httpclient_memory
integer x = 87
integer y = 80
integer width = 430
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "AutoReadData"
boolean checked = true
end type

type st_2 from statictext within w_httpclient_memory
integer x = 503
integer y = 388
integer width = 827
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "本次cpu:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_httpclient_memory
integer x = 613
integer y = 280
integer width = 343
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "次数：0"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_httpclient_memory
integer x = 997
integer y = 260
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "停止"
end type

event clicked;ib_continue = False
end event

type cb_1 from commandbutton within w_httpclient_memory
integer x = 210
integer y = 260
integer width = 343
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "开始"
end type

event clicked;Long	ll_i, ll_cpu,li_FileNum


ib_continue = true

ghc_Client.ClearRequestHeaders()
ghc_Client.SetRequestHeader ( "Content-Type", "application/json" )

li_FileNum = FileOpen("log.txt",LineMode!, Write!, LockWrite!, Append!, EncodingUtf8!)
Do While ( True )
	Yield()
	If Not ib_continue Then		
		Exit
	End If
	il_count ++
	
	st_1.Text = "次数：" + String ( il_Count )
	ll_cpu = cpu()
	
	String 	ls_txt, ls_Body, ls_response
	Blob 		lb_data, lb_temp
	Long 		ll_Code, ll_loop, ll_rtn
	
	
	if ib_debug Then
		debugbreak()
	End If
	
	
	
//	ghc_Client.ClearRequestHeaders()
	ghc_Client.TimeOut = 10
	If cbx_1.Checked = true Then
		ghc_Client.autoreaddata = true
	Else
		ghc_Client.autoreaddata = false
	End If
	ghc_Client.ClearRequestHeaders()
	ghc_Client.SetRequestHeader ( "Content-Type", "application/json" )
	ghc_Client.SetRequestHeader ( "Pragma", "no-cache" )
	ghc_Client.SetRequestHeader ( "User-Agent", "Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko" )
	
	//appeon web
	ghc_Client.sendrequest( "GET", "https://www.appeon.com" )
	ghc_Client.Getresponseheaders( )
	ghc_Client.GetResponsebody( ls_Body)	
	ll_Code = ghc_Client.GetResponseStatusCode()
	ls_txt = ghc_Client.GetResponseStatusText()
	
	//login
	ghc_Client.sendrequest( "GET", "https://www.appeon.com/user/login?destination=node/252" )
	ghc_Client.Getresponseheaders( )
	ghc_Client.GetResponsebody( ls_Body)	
	ll_Code = ghc_Client.GetResponseStatusCode()
	ls_txt = ghc_Client.GetResponseStatusText()
	
//	//getemployees
//	ghc_Client.sendrequest( "GET", "http://webapi.appeon.com/employee/getemployees" )
//	ghc_Client.Getresponseheaders( )
//	ghc_Client.GetResponsebody( ls_Body)	
//	ll_Code = ghc_Client.GetResponseStatusCode()
//	ls_txt = ghc_Client.GetResponseStatusText()
	
//	st_2.Text = String ( ll_Code  ) + " " + ls_txt
	
//	//getemployees https
//	ghc_Client.sendrequest( "GET", "http://192.0.2.195/restful/book.txt" )
//	ghc_Client.Getresponseheaders( )
//	ghc_Client.GetResponsebody( ls_Body)	
//	ll_Code = ghc_Client.GetResponseStatusCode()
//	ls_txt = ghc_Client.GetResponseStatusText()
	
//	st_2.Text = String ( ll_Code  ) + " " + ls_txt
	
	//get jpg	
	ll_rtn = ghc_Client.sendrequest( "GET", is_ip + "/restful/login_btn.jpg" )
	ghc_Client.Getresponseheaders( )
	ghc_Client.GetResponsebody( lb_data)	
	ll_Code = ghc_Client.GetResponseStatusCode()
	ls_txt = ghc_Client.GetResponseStatusText()
	
	If cbx_3.Checked = true Then
		FileWriteEx(li_FileNum, String (il_Count) +"次" +String ( now() ) +  "SendRequest begin")
	End If
	//SetProfileString("log.ini", "Log", String (il_Count) +"次" +String ( now()) + "SendRequest begin", "SendRequest begin")


	//get bmp
	ll_rtn = ghc_Client.sendrequest( "GET", is_ip + "/restful/pic3m.bmp" )
	
	ls_response = ghc_Client.Getresponseheaders( )
	ll_Code = ghc_Client.GetResponseStatusCode()
	ls_txt = ghc_Client.GetResponseStatusText()
	
	If cbx_3.Checked = true Then
		FileWriteEx(li_FileNum, String (il_Count) +"次" +String ( now() ) + "ReadData begin")
	End If
	
	ll_loop = 1024 * 100
	Do While ( ll_rtn = 1 )	
		
		ll_rtn = ghc_Client.ReadData( lb_temp, ll_loop)	
		
		lb_data =  lb_data + lb_temp	
		//Yield()
	Loop
	
	st_2.Text = "本次cpu：" + String ( cpu() - ll_cpu ) + "size:" + String (Len (lb_data) )
	
	lb_data = Blob ("" )
	lb_temp = Blob ("")
	ls_Body = ""
	ls_response = ""
	ll_Code = 0
	ls_txt = ""

Loop 

FileClose(li_FileNum)
end event

