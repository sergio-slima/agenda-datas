unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uDWConstsData, uRESTDWPoolerDB, uDWAbout,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.DApt;

type
  TDM = class(TDataModule)
    SqlUsuarios: TRESTDWClientSQL;
    SqlCompromissos: TRESTDWClientSQL;
    SqlCalendario: TRESTDWClientSQL;
    SqlConvites: TRESTDWClientSQL;
    SqlBuscaUsuarios: TRESTDWClientSQL;
    SqlNotificacoes: TRESTDWClientSQL;
    SqlGetNotificacao: TRESTDWClientSQL;
    RESTDWDataBase: TRESTDWDataBase;
    Conexao: TFDConnection;
    QryEventos: TFDQuery;
    QryTipos: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
   //  uRESTDWPoolerDB, , uDWConstsData, uDWAbout
var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
