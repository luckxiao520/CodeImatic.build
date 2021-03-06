procedure BeforeZIPEvent;
begin
  Writeln('BeforeZIPEvent');
end;



Var
  FZipStringList: TStringList;
  I: Integer;
  FZipOptions: TZipOptions;
begin
   Output.log('Zip Sample');

  //Zip.BeforeZIPEvent:=@BeforeZIPEvent;

  Writeln('function ZipExtractFile');

  if not Zip.ExtractFile(wd + 'test.zip', 'test.txt', wd + 'data', NIL) then
     Output.LogError;

  Writeln('function ZipExtractAll');

  if not Zip.ExtractAll(wd + 'test.zip', wd + 'data', NIL) then
    Output.LogError;

  Writeln('function ZipBrowserList');

  Writeln('Files:');

  Try
    FZipStringList := TStringList.Create;

    if Zip.BrowserList(wd + 'test.zip',
        FZipStringList,
        true, NIL) then
      begin
        For I := 0 to FZipStringList.Count - 1 do
          Writeln(FZipStringList.strings[i]);

      end
     else
        Output.LogError;
  finally
    FZipStringList.Free;
  end;
  Writeln('function ZipCompress');

  Try
    FZipOptions := TZipOptions.Create;

    FZipOptions.ExcludedFile.Add('Test2.txt.txt');
    FZipOptions.Password := 'xyz';
    FZipOptions.Output := true;


    if not Zip.Compress(wd + 'test2.zip',
             wd + 'data', '*', FZipOptions) then
            Output.LogError;
  finally
    FZipOptions.Free;
  end;

  writeln('Working directory');


  writeln(wd);
end.
