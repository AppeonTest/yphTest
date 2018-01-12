$PBExportHeader$pbrestful.sra
$PBExportComments$Generated Application Object
forward
global type pbrestful from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type pbrestful from application
string appname = "pbrestful"
end type
global pbrestful pbrestful

on pbrestful.create
appname = "pbrestful"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on pbrestful.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

