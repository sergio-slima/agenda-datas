unit UEventos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls, FMX.ListBox, FMX.TabControl, System.Actions, FMX.ActnList,
  Data.DB, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, uFancyDialog;

type
  TFormEventos = class(TForm)
    Layout1: TLayout;
    lblTitulo: TLabel;
    imgFechar: TImage;
    Layout3: TLayout;
    edtDescricao: TEdit;
    Layout2: TLayout;
    Label5: TLabel;
    EdtData: TDateEdit;
    lbxConvite: TListBox;
    TabControl: TTabControl;
    TabCompromisso: TTabItem;
    TabBusca: TTabItem;
    ActionList1: TActionList;
    actCompromisso: TChangeTabAction;
    actBusca: TChangeTabAction;
    Layout4: TLayout;
    Label1: TLabel;
    imgVoltar: TImage;
    edtBusca: TEdit;
    lbxBusca: TListBox;
    Layout5: TLayout;
    EdtTipo: TComboBox;
    Label3: TLabel;
    ImgOFF: TImage;
    ImgON: TImage;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    btnSalvar: TImage;
    StyleBook1: TStyleBook;
    Label4: TLabel;
    Label6: TLabel;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    ImgSalvar: TImage;
    Rectangle7: TRectangle;
    Layout6: TLayout;
    Rectangle8: TRectangle;
    EdtHora: TEdit;
    Label2: TLabel;
    procedure imgFecharClick(Sender: TObject);
    procedure imgAddClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure lbxBuscaItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ImgSalvarClick(Sender: TObject);
    procedure ImgONClick(Sender: TObject);
    procedure ImgOFFClick(Sender: TObject);
    procedure EdtHoraTyping(Sender: TObject);
  private
    { Private declarations }
    fancy : TFancyDialog;
    procedure AtualizarTipos();
  public
    { Public declarations }
    modo : string; // I = Inclusao A = Alteracao;
    id_compromisso : integer;
  end;

var
  FormEventos: TFormEventos;

implementation

{$R *.fmx}

uses UEventosTiposDados, UEventosTiposFrame, UDM, UPrincipal,
  uFormat;

procedure TFormEventos.AtualizarTipos();
begin
  DM.QryTipos.Active := False;
  DM.QryTipos.SQL.Clear;
  DM.QryTipos.SQL.Add('SELECT * FROM TIPOS');
  DM.QryTipos.Active := True;

  while not DM.QryTipos.Eof do
  begin
    EdtTipo.Items.Add(DM.QryTipos.FieldByName('DESCRICAO').AsString);

    DM.QryTipos.Next;
  end;
end;

procedure CriarFrameBusca(n : TEventosTipos);
var
  f : TFrameEventosTipos;
  item : TListBoxItem;
begin
  item := TListBoxItem.Create(nil);
  item.Text := '';
  item.Height := 46;
  item.Align := TAlignLayout.Client;
  item.TagString := n.descricao;
  item.Selectable := False;

  f := TFrameEventosTipos.Create(item);
  f.Parent := item;
  f.Align := TAlignLayout.Client;

  f.lblID.Text := IntToStr(n.id);
  f.lblDescricao.Text := n.descricao;

  FormEventos.lbxBusca.AddObject(item);
end;

procedure ListarTipos();
var
  n : TEventosTipos;
  x : integer;
  icone : TStream;
  bmp : TBitmap;
begin
  FormEventos.lbxBusca.Items.Clear;

  DM.QryTipos.Active := False;
  DM.QryTipos.SQL.Clear;
  DM.QryTipos.SQL.Add('SELECT * FROM TIPOS');
  DM.QryTipos.Active := True;

  while not DM.QryTipos.Eof do
  begin
    n.id := DM.QryTipos.FieldByName('ID').AsInteger;
    n.descricao := DM.QryTipos.FieldByName('DESCRICAO').AsString;

    CriarFrameBusca(n);

    bmp.DisposeOf;
    DM.QryTipos.Next;
  end;
end;

procedure TFormEventos.btnSalvarClick(Sender: TObject);
begin
  if (EdtData.IsEmpty) or (edtDescricao.Text = '') then
  begin
    fancy.Show(TIconDialog.Warning, 'Atenção', 'Digite a data, hora e descrição!', 'OK');
    Exit;
  end;

  try
    DM.QryEventos.Active := False;
    DM.QryEventos.SQL.Clear;
    DM.QryEventos.SQL.Add('INSERT INTO EVENTOS (DATA, DESCRICAO, TIPO, FAVORITO, HORA)');
    DM.QryEventos.SQL.Add('VALUES(:DATA, :DESCRICAO, :TIPO, :FAVORITO, :HORA)');
    DM.QryEventos.ParamByName('DATA').Value := FormatDateTime('yyyy-mm-dd', EdtData.Date);
    DM.QryEventos.ParamByName('DESCRICAO').Value := edtDescricao.Text;
    DM.QryEventos.ParamByName('TIPO').Value := EdtTipo.ItemIndex;
    if ImgON.Visible = True then
      DM.QryEventos.ParamByName('FAVORITO').Value := 'S'
    else
      DM.QryEventos.ParamByName('FAVORITO').Value := 'N';
    DM.QryEventos.ParamByName('HORA').Value := edtHora.Text;

    DM.QryEventos.ExecSQL;

    // Atualizar Dados
    FormPrincipal.ListarEventos;
    FormPrincipal.CarregaDadosCalendario;

    fancy.Show(TIconDialog.Success, 'Concluído', 'Evento Cadastrado com Sucesso!', 'OK');
    Close;
  except
    fancy.Show(TIconDialog.Error, 'Erro', 'Erro ao cadastrar evento!', 'OK');
  end;
end;

procedure TFormEventos.EdtHoraTyping(Sender: TObject);
begin
  Formatar(EdtHora, TFormato.Personalizado, '##:##');
end;

procedure TFormEventos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fancy.DisposeOf;
  Action := TCloseAction.caFree;
  FormEventos := nil;
end;

procedure TFormEventos.FormCreate(Sender: TObject);
begin
  fancy := TFancyDialog.Create(FormEventos);
  //AtualizarTipos();
    // limpar campos
  EdtData.Date := now;
  edtDescricao.Text := '';
  EdtTipo.ItemIndex := 0;
  ImgOFF.Visible := True;
  ImgON.Visible := False;

  TabControl.TabPosition := TTabPosition.None;
  TabControl.ActiveTab := TabCompromisso;
end;

procedure TFormEventos.imgAddClick(Sender: TObject);
begin
   ListarTipos();

  edtBusca.Text := '';
  actBusca.Execute;
end;

procedure TFormEventos.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormEventos.ImgOFFClick(Sender: TObject);
begin
  ImgOFF.Visible := False;
  ImgON.Visible := True;
end;

procedure TFormEventos.ImgONClick(Sender: TObject);
begin
  ImgON.Visible := False;
  ImgOFF.Visible := True;
end;

procedure TFormEventos.ImgSalvarClick(Sender: TObject);
begin
  if edtBusca.Text = '' then
  begin
    fancy.Show(TIconDialog.Warning, 'Atenção', 'Digite uma descrição!', 'OK');
    Exit;
  end;

  // Consulta se a Descrição existe
  DM.QryTipos.Active := False;
  DM.QryTipos.SQL.Clear;
  DM.QryTipos.SQL.Add('SELECT * FROM TIPOS WHERE DESCRICAO = :DESCRICAO');
  DM.QryTipos.ParamByName('DESCRICAO').Value := edtBusca.Text;
  DM.QryTipos.Active := True;
  if DM.QryTipos.RecordCount > 0 then
  begin
    fancy.Show(TIconDialog.Info, 'Ops!', 'Tipo de evento já cadastrado!', 'OK');
    exit;
  end;

  // Cadastra o novo tipo
  DM.QryTipos.Active := False;
  DM.QryTipos.SQL.Clear;
  DM.QryTipos.SQL.Add('INSERT INTO TIPOS (DESCRICAO) VALUES (:DESCRICAO)');
  DM.QryTipos.ParamByName('DESCRICAO').Value := edtBusca.Text;
  DM.QryTipos.ExecSQL;

  ListarTipos;
  edtBusca.Text := '';
end;

procedure TFormEventos.imgVoltarClick(Sender: TObject);
begin
  AtualizarTipos;
  actCompromisso.Execute;
end;

procedure TFormEventos.lbxBuscaItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin

  lbxBusca.Items.Delete(Item.Index);
end;

end.
