unit uPSI_MessagesLog;
{
This file has been generated by UnitParser v0.7, written by M. Knight
and updated by NP. v/d Spek and George Birbilis. 
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ROPS are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok's conv utility

}
interface
 

 
uses
   SysUtils
  ,Classes
  ,uPSComponent
  ,uPSRuntime
  ,uPSCompiler
  ;
 
type 
(*----------------------------------------------------------------------------*)
  TPSImport_MessagesLog = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TMessagesLog(CL: TPSPascalCompiler);
procedure SIRegister_MessagesLog(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TMessagesLog(CL: TPSRuntimeClassImporter);
procedure RIRegister_MessagesLog(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   NovusLog
  ,MessagesLog
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_MessagesLog]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TMessagesLog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TNovusLogFile', 'TMessagesLog') do
  with CL.AddClassN(CL.FindClass('TNovusLogFile'),'TMessagesLog') do
  begin
  //  RegisterMethod('Constructor Create( AFilename : String; aOutputConsole : Boolean)');
    RegisterMethod('Procedure Log( AMsg : string)');
  //  RegisterProperty('Errors', 'Boolean', iptrw);
 //   RegisterProperty('Failed', 'Boolean', iptrw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_MessagesLog(CL: TPSPascalCompiler);
begin
  SIRegister_TMessagesLog(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure TMessagesLogFailed_W(Self: TMessagesLog; const T: Boolean);
begin Self.Failed := T; end;

(*----------------------------------------------------------------------------*)
procedure TMessagesLogFailed_R(Self: TMessagesLog; var T: Boolean);
begin T := Self.Failed; end;

(*----------------------------------------------------------------------------*)
procedure TMessagesLogErrors_W(Self: TMessagesLog; const T: Boolean);
begin Self.Errors := T; end;

(*----------------------------------------------------------------------------*)
procedure TMessagesLogErrors_R(Self: TMessagesLog; var T: Boolean);
begin T := Self.Errors; end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TMessagesLog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TMessagesLog) do
  begin
    RegisterVirtualConstructor(@TMessagesLog.Create, 'Create');
    RegisterMethod(@TMessagesLog.Log, 'Log');
    RegisterPropertyHelper(@TMessagesLogErrors_R,@TMessagesLogErrors_W,'Errors');
    RegisterPropertyHelper(@TMessagesLogFailed_R,@TMessagesLogFailed_W,'Failed');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_MessagesLog(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TMessagesLog(CL);
end;

 
 
{ TPSImport_MessagesLog }
(*----------------------------------------------------------------------------*)
procedure TPSImport_MessagesLog.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_MessagesLog(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_MessagesLog.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_MessagesLog(ri);
end;
(*----------------------------------------------------------------------------*)
 
 
end.
