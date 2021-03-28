unit UNotificacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  UNotificacaoDados, Data.DB;

type
  TFormNotificacao = class(TForm)
    lbxNotificacao: TListBox;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    procedure imgVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNotificacao: TFormNotificacao;

implementation

{$R *.fmx}

uses UNotificacaoFrame, UDM, UPrincipal;

procedure CriarFrame(n : TNotificacao);
var
  f : TFrameNotificacao;
  item : TListBoxItem;
begin
  item := TListBoxItem.Create(nil);
  item.Text := '';
  item.Height := 120;
  item.Align := TAlignLayout.Client;
  item.Tag := n.id;
  item.Selectable := False;

  f := TFrameNotificacao.Create(item);
  f.Parent := item;
  f.Align := TAlignLayout.Client;

  f.cloIcone.Fill.Bitmap.Bitmap := n.icone;
  f.lblUsuario.Text := n.usuario_id;
  f.lblData.Text := n.data;
  f.lblTexto.Text := n.texto;
  f.btnAceitar.Tag := n.id;
  f.btnExcluir.Tag := n.id;
  f.btnAceitar.TagString := n.usuario_id;
  f.btnExcluir.TagString := n.usuario_id;

  if n.tipo = 'C' then
    f.btnAceitar.Visible := true
  else
    f.btnAceitar.Visible := false;

  FormNotificacao.lbxNotificacao.AddObject(item);
end;

procedure ListarNotificacao();
var
  n : TNotificacao;
  x : integer;
  icone : TStream;
  bmp : TBitmap;
begin
//  FormNotificacao.lbxNotificacao.Items.Clear;
//
//  DM.SqlNotificacoes.Active := False;
//  DM.SqlNotificacoes.SQL.Clear;
//  DM.SqlNotificacoes.SQL.Add('SELECT N.*, U.ICONE FROM NOTIFICACAO N');
//  DM.SqlNotificacoes.SQL.Add('INNER JOIN USUARIOS U ON (U.USUARIO = N.USUARIO_DE)');
//  DM.SqlNotificacoes.SQL.Add('WHERE N.USUARIO_PARA = :USUARIO');
////  DM.SqlNotificacoes.ParamByName('USUARIO').Value := FormPrincipal.pusuario;
//  DM.SqlNotificacoes.Active := True;
//
//  while not DM.SqlNotificacoes.Eof do
//  begin
//    n.id := DM.SqlNotificacoes.FieldByName('ID').AsInteger;
//
//    if DM.SqlNotificacoes.FieldByName('ICONE').AsString <> '' then
//    begin
//      try
//        icone := DM.SqlNotificacoes.CreateBlobStream(DM.SqlNotificacoes.FieldByName('ICONE'), bmread);
//
//        bmp := TBitmap.Create;
//        bmp.LoadFromStream(icone);
//
//        n.icone := bmp;
//      finally
//        icone.DisposeOf;
//      end;
//    end;
//
//    n.usuario_id := DM.SqlNotificacoes.FieldByName('USUARIO_DE').AsString;
//    n.data := FormatDateTime('DD/MM', DM.SqlNotificacoes.FieldByName('DATA').AsDateTime);
//    n.texto := DM.SqlNotificacoes.FieldByName('TEXTO').AsString;
//    n.tipo := DM.SqlNotificacoes.FieldByName('TIPO').AsString;
//
//    CriarFrame(n);
//
//    bmp.DisposeOf;
//    DM.SqlNotificacoes.Next;
//  end;
end;

procedure TFormNotificacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FormNotificacao := nil;
end;

procedure TFormNotificacao.FormShow(Sender: TObject);
begin
//  ListarNotificacao;
//
//  // Marcar notificaçoes como lidas
//  DM.SqlNotificacoes.Active := False;
//  DM.SqlNotificacoes.SQL.Clear;
//  DM.SqlNotificacoes.SQL.Add('UPDATE NOTIFICACAO SET STATUS = ''S''');
//  DM.SqlNotificacoes.SQL.Add('WHERE USUARIO_PARA = :USUARIO');
////  DM.SqlNotificacoes.ParamByName('USUARIO').Value := FormPrincipal.pusuario;
//  DM.SqlNotificacoes.ExecSQL;
end;

procedure TFormNotificacao.imgVoltarClick(Sender: TObject);
begin
  Close;
end;

end.
