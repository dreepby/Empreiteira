unit uClassConexaoBanco;

interface

uses
 System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI;

type
  TConexao = class(TFDConnection)
  private
    oObjetoWaitCursor: TFDGUIxWaitCursor;
    oObjetoMysqlLink: TFDPhysMySQLDriverLink;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TConexao }

constructor TConexao.Create(AOwner: TComponent);
begin
  inherited;

  DriverName := 'MySQL';
  Params.Database := 'Empreiteira';
  Params.UserName := 'root';
  Params.Password := '';
  LoginPrompt := False;
  Connected := True;

  oObjetoWaitCursor := TFDGUIxWaitCursor.Create(nil);
  oObjetoMysqlLink := TFDPhysMySQLDriverLink.Create(nil);
end;

destructor TConexao.Destroy;
begin
  if (Assigned(oObjetoWaitCursor)) then
    FreeAndNil(oObjetoWaitCursor);

  if (Assigned(oObjetoMysqlLink)) then
    FreeAndNil(oObjetoMysqlLink);

  inherited;
end;

end.
