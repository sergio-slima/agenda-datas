unit UNotificacaoFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.ListBox;

type
  TFrameNotificacao = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    lblUsuario: TLabel;
    lblData: TLabel;
    lblTexto: TLabel;
    btnExcluir: TSpeedButton;
    btnAceitar: TSpeedButton;
    cloIcone: TCircle;
    procedure btnAceitarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses UDM, UPrincipal;

procedure TFrameNotificacao.btnAceitarClick(Sender: TObject);
var
  id_compromisso, id_notificacao : integer;
begin
  try
    // Descobre o compromisso
    DM.SqlNotificacoes.Active := False;
    DM.SqlNotificacoes.SQL.Clear;
    DM.SqlNotificacoes.SQL.Add('SELECT COMPROMISSO_ID FROM NOTIFICACAO');
    DM.SqlNotificacoes.SQL.Add('WHERE ID = :ID');
    DM.SqlNotificacoes.ParamByName('ID').Value := TSpeedButton(Sender).Tag;
    DM.SqlNotificacoes.Active := True;

    id_compromisso := DM.SqlNotificacoes.FieldByName('COMPROMISSO_ID').AsInteger;

    // atualiza compromisso
    DM.SqlNotificacoes.Active := False;
    DM.SqlNotificacoes.SQL.Clear;
    DM.SqlNotificacoes.SQL.Add('UPDATE COMPROMISSOS_CONVITE');
    DM.SqlNotificacoes.SQL.Add('SET STATUS = ''S''');
    DM.SqlNotificacoes.SQL.Add('WHERE COMPROMISSO_ID = :COMPROMISSO_ID');
    DM.SqlNotificacoes.SQL.Add('AND USUARIO = :USUARIO');
    DM.SqlNotificacoes.ParamByName('COMPROMISSO_ID').Value := id_compromisso;
    DM.SqlNotificacoes.ParamByName('USUARIO').Value := TSpeedButton(Sender).TagString;
    DM.SqlNotificacoes.ExecSQL;

    //  atualiza notificação
    DM.SqlNotificacoes.Active := False;
    DM.SqlNotificacoes.SQL.Clear;
    DM.SqlNotificacoes.SQL.Add('UPDATE NOTIFICACAO SET TIPO = ''T''');
    DM.SqlNotificacoes.SQL.Add('ID = :ID');
    DM.SqlNotificacoes.ParamByName('ID').Value := TSpeedButton(Sender).Tag;
    DM.SqlNotificacoes.ExecSQL;

    //Busca ultimo id notificacao
    id_notificacao := 0;
    DM.SqlNotificacoes.Active := False;
    DM.SqlNotificacoes.SQL.Clear;
    DM.SqlNotificacoes.SQL.Add('SELECT MAX(ID) AS ID FROM NOTIFICACAO');
    DM.SqlNotificacoes.Active := True;

    id_notificacao := DM.SqlNotificacoes.FieldByName('ID').AsInteger;
    id_notificacao := id_notificacao + 1;


    // Enviar notificação
    DM.SqlNotificacoes.Active := False;
    DM.SqlNotificacoes.SQL.Clear;
    DM.SqlNotificacoes.SQL.Add('INSERT INTO NOTIFICACAO(ID, COMPROMISSO_ID,');
    DM.SqlNotificacoes.SQL.Add('USUARIO_DE, USUARIO_PARA, DATA, TEXTO, TIPO, STATUS)');
    DM.SqlNotificacoes.SQL.Add('VALUES(:ID, :COMPROMISSO_ID, :USUARIO_DE,');
    DM.SqlNotificacoes.SQL.Add(':USUARIO_PARA, :DATA, :TEXTO, :TIPO, :STATUS)');
    DM.SqlNotificacoes.ParamByName('ID').Value := id_notificacao;
    DM.SqlNotificacoes.ParamByName('COMPROMISSO_ID').Value := id_compromisso;
//    DM.SqlNotificacoes.ParamByName('USUARIO_DE').Value := FormPrincipal.pusuario;
    DM.SqlNotificacoes.ParamByName('USUARIO_PARA').Value := TSpeedButton(Sender).TagString;
    DM.SqlNotificacoes.ParamByName('DATA').AsDate := Date;
 //   DM.SqlNotificacoes.ParamByName('TEXTO').Value := FormPrincipal.pusuario + ' aceitou seu convite.';
    DM.SqlNotificacoes.ParamByName('TIPO').Value := 'T';
    DM.SqlNotificacoes.ParamByName('STATUS').Value := 'N';
    DM.SqlNotificacoes.ExecSQL;

    TSpeedButton(Sender).Visible := False;
  except

  end;
end;

procedure TFrameNotificacao.btnExcluirClick(Sender: TObject);
var
  Item : TListBoxItem;
begin
  //  atualiza notificação
    DM.SqlNotificacoes.Active := False;
    DM.SqlNotificacoes.SQL.Clear;
    DM.SqlNotificacoes.SQL.Add('DELETE FROM NOTIFICACAO');
    DM.SqlNotificacoes.SQL.Add('WHERE ID = :ID');
    DM.SqlNotificacoes.ParamByName('ID').Value := TSpeedButton(Sender).Tag;
    DM.SqlNotificacoes.ExecSQL;

    // esconde item
    Item := TFrameNotificacao(
                                TRectangle(
                                            TLayout(
                                                      TLayout(TSpeedButton(Sender).Parent).Parent
                                                    ).Parent
                                            ).Parent
                              ).Parent as TListBoxItem;
    Item.Visible := False;

end;

end.
