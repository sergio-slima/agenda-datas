unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.ListBox,
  uCustomCalendar, DateUtils, UEventosDados, FMX.TabControl, System.Actions,
  FMX.ActnList, FMX.Edit, Data.DB;

type
  TFormPrincipal = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Label5: TLabel;
    imgNotificacao: TImage;
    cloNotificacao: TCircle;
    Layout2: TLayout;
    imgAnterior: TImage;
    imgProximo: TImage;
    lblMes: TLabel;
    lytCalendario: TLayout;
    lytSemCompromisso: TLayout;
    Image3: TImage;
    lblSemCompromisso: TLabel;
    lytCompromisso: TLayout;
    lbxCompromisso: TListBox;
    Layout3: TLayout;
    lblCompromisso: TLabel;
    ImgAdd: TImage;
    Circle1: TCircle;
    TabControl: TTabControl;
    TabDatas: TTabItem;
    TabFavoritos: TTabItem;
    TabFiltros: TTabItem;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    ActionList1: TActionList;
    ActDatas: TChangeTabAction;
    ActFavoritos: TChangeTabAction;
    ActFiltros: TChangeTabAction;
    ImgFavoritos: TImage;
    ImgDatas: TImage;
    ImgFiltros: TImage;
    RtgSelecao: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Layout5: TLayout;
    edtBusca: TEdit;
    btnBusca: TSpeedButton;
    lbxFiltros: TListBox;
    Layout6: TLayout;
    Rectangle6: TRectangle;
    TabConfig: TTabItem;
    ActConfig: TChangeTabAction;
    ImgConfig: TImage;
    Rectangle7: TRectangle;
    Layout7: TLayout;
    Label1: TLabel;
    Layout8: TLayout;
    Label2: TLabel;
    LbxFavoritos: TListBox;
    EdtTipo: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure DayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgProximoClick(Sender: TObject);
    procedure imgAnteriorClick(Sender: TObject);
    procedure ListarEventos();
    procedure imgNotificacaoClick(Sender: TObject);
    procedure CarregaDadosCalendario();
    procedure lbxCompromissoItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ImgAddClick(Sender: TObject);
    procedure ImgDatasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImgFavoritosClick(Sender: TObject);
    procedure ImgFiltrosClick(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure ImgConfigClick(Sender: TObject);
    procedure EdtTipoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cal : TCustomCalendar;
    tela : String;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.fmx}

uses UEventos, UNotificacao, ULogin, UEventosFrame, UDM, UEventosTiposDados,
      UEventosTiposFrame;

procedure SelecionaIcone(Sender: TObject);
begin
  with FormPrincipal do
  begin
    ImgDatas.Tag := 0;
    ImgFavoritos.Tag := 0;
    ImgFiltros.Tag := 0;
    ImgConfig.Tag := 0;

    TImage(Sender).Tag := 1;

    RtgSelecao.AnimateFloat('Position.X', TImage(Sender).Position.X, 0.2);
  end;

end;

procedure CriarFrame(e : TEventos);
var
  f : TFrameEventos;
  item : TListBoxItem;
begin
  item := TListBoxItem.Create(nil);
  item.Text := '';
  item.Height := 60;
  item.Align := TAlignLayout.Client;
  item.Tag := e.id;
  item.Selectable := False;

  f := TFrameEventos.Create(item);
  f.Parent := item;
  f.Align := TAlignLayout.Client;

  f.lblDescricao.Text := e.descricao;
  f.lblData.Text := e.data;

  if e.tipo = IntToStr(0) then          //Outros
    f.ImgOutros.Visible := True
  else if e.tipo = IntToStr(1) then     //Aniversario
    f.ImgAniversario.Visible := True
  else if e.tipo = IntToStr(2) then     //Escola
    f.ImgEscola.Visible := True
  else if e.tipo = IntToStr(3) then    //Trabalho
    f.ImgTrabalho.Visible := True
  else if e.tipo = IntToStr(4) then    //Festas
    f.ImgFestas.Visible := True
  else if e.tipo = IntToStr(5) then    //Viagem
    f.ImgViagens.Visible := True
  else if e.tipo = IntToStr(6) then    //Igreja
    f.ImgIgreja.Visible := True;

  if e.favorito = 'S' then
    f.ImgON.Visible := True
  else
    f.ImgOFF.Visible := True;


  if (FormPrincipal.tela = 'Favoritos') then
    FormPrincipal.LbxFavoritos.AddObject(item)
  else if (FormPrincipal.tela = 'Filtros') then
    FormPrincipal.lbxFiltros.AddObject(item)
  else
    FormPrincipal.lbxCompromisso.AddObject(item);
end;

procedure ListarFavoritos();
var
  e : TEventos;
begin
  FormPrincipal.LbxFavoritos.Items.Clear;

  DM.QryEventos.Active := False;
  DM.QryEventos.SQL.Clear;
  DM.QryEventos.SQL.Add('SELECT * FROM EVENTOS');
  DM.QryEventos.SQL.Add('WHERE FAVORITO = :FAVORITO');
  DM.QryEventos.ParamByName('FAVORITO').Value := 'S';

  DM.QryEventos.Active := True;

  while not DM.QryEventos.Eof do
  begin
    e.id := DM.QryEventos.FieldByName('ID').AsInteger;
    e.data := FormatDateTime('dd/mm/yyyy',DM.QryEventos.FieldByName('DATA').AsDateTime);
    e.descricao := DM.QryEventos.FieldByName('DESCRICAO').AsString;
    e.tipo := DM.QryEventos.FieldByName('TIPO').AsString;
    e.favorito := DM.QryEventos.FieldByName('FAVORITO').AsString;

    CriarFrame(e);

    DM.QryEventos.Next;
  end;
end;

procedure ListarFiltros();
var
  e : TEventos;
begin
  FormPrincipal.lbxFiltros.Items.Clear;

  DM.QryEventos.Active := False;
  DM.QryEventos.SQL.Clear;
  DM.QryEventos.SQL.Add('SELECT * FROM EVENTOS');

  if FormPrincipal.EdtTipo.ItemIndex <> 7 then
  begin
    DM.QryEventos.SQL.Add('WHERE TIPO = :TIPO');
    case FormPrincipal.EdtTipo.ItemIndex of
      0 : DM.QryEventos.ParamByName('TIPO').Value := 0;
      1 : DM.QryEventos.ParamByName('TIPO').Value := 1;
      2 : DM.QryEventos.ParamByName('TIPO').Value := 2;
      3 : DM.QryEventos.ParamByName('TIPO').Value := 3;
      4 : DM.QryEventos.ParamByName('TIPO').Value := 4;
      5 : DM.QryEventos.ParamByName('TIPO').Value := 5;
      6 : DM.QryEventos.ParamByName('TIPO').Value := 6;
    end;

  end;

  if FormPrincipal.edtBusca.Text <> '' then
  begin
    if FormPrincipal.EdtTipo.ItemIndex <> 7 then
      DM.QryEventos.SQL.Add('AND DESCRICAO = :DESCRICAO')
    else
      DM.QryEventos.SQL.Add('WHERE DESCRICAO = :DESCRICAO');

    DM.QryEventos.ParamByName('DESCRICAO').Value := '%'+FormPrincipal.edtBusca.Text+'%';
  end;

  DM.QryEventos.Active := True;

  while not DM.QryEventos.Eof do
  begin
    e.id := DM.QryEventos.FieldByName('ID').AsInteger;
    e.data := FormatDateTime('dd/mm/yyyy',DM.QryEventos.FieldByName('DATA').AsDateTime);
    e.descricao := DM.QryEventos.FieldByName('DESCRICAO').AsString;
    e.tipo := DM.QryEventos.FieldByName('TIPO').AsString;
    e.favorito := DM.QryEventos.FieldByName('FAVORITO').AsString;

    CriarFrame(e);

    DM.QryEventos.Next;
  end;
end;

procedure TFormPrincipal.btnBuscaClick(Sender: TObject);
begin
  ListarFiltros;
end;

procedure TFormPrincipal.CarregaDadosCalendario();
var
  x : integer;
  dia, mes, ano : word;
begin
  DecodeDate(cal.SelectedDate, ano, mes, dia);

  // Buscar Calendario
  DM.QryEventos.Active := False;
  DM.QryEventos.SQL.Clear;
  DM.QryEventos.SQL.Add('SELECT DISTINCT DATA FROM EVENTOS');
  DM.QryEventos.SQL.Add('WHERE DATA >= :DATA1 AND DATA <= :DATA2');
  DM.QryEventos.ParamByName('DATA1').Value := FormatDateTime('dd.mm.yyyy', EncodeDate(ano, mes, 1));
  DM.QryEventos.ParamByName('DATA2').Value := FormatDateTime('dd.mm.yyyy', EndOfTheMonth(cal.SelectedDate));
  DM.QryEventos.Active := True;

  for x := 1 to DM.QryEventos.RecordCount do
  begin
    cal.AddMarker(FormatDateTime('DD',DM.QryEventos.FieldByName('DATA').AsDateTime).ToInteger);

    DM.QryEventos.Next;
  end;
end;

procedure TFormPrincipal.ListarEventos();
var
  e : TEventos;
  x : integer;
begin
  // Atualiar labels da data
  lblMes.Text := cal.MonthName;
  lblCompromisso.Text := 'Registros do dia ' + FormatDateTime('DD/MM', cal.SelectedDate);
  FormPrincipal.lbxCompromisso.Items.Clear;

  // Buscar Eventos no servidor
  DM.QryEventos.Active := False;
  DM.QryEventos.SQL.Clear;
  DM.QryEventos.SQL.Add('SELECT * FROM EVENTOS');
  DM.QryEventos.SQL.Add('WHERE DATA = :DATA');
  DM.QryEventos.ParamByName('DATA').Value := FormatDateTime('dd/mm/yyyy', cal.SelectedDate);
  DM.QryEventos.Active := True;

  if DM.QryEventos.RecordCount = 0 then
  begin
    lytCompromisso.Visible := False;
    lytSemCompromisso.Visible := True;
    lblSemCompromisso.Text := 'Sem registro em ' + FormatDateTime('DD/MM', cal.SelectedDate);
  end else
  begin
    lytCompromisso.Visible := True;
    lytSemCompromisso.Visible := False;

    for x := 1 to DM.QryEventos.RecordCount do
    begin
      with DM.QryEventos do
      begin
        e.id := FieldByName('ID').AsInteger;
        e.data := FormatDateTime('dd/mm/yyyy',FieldByName('DATA').AsDateTime);
        e.descricao := FieldByName('DESCRICAO').AsString;
        e.tipo := FieldByName('TIPO').AsString;
        e.favorito := FieldByName('FAVORITO').AsString;

        CriarFrame(e);

        DM.QryEventos.Next;
      end;
    end;
  end;
end;

procedure TFormPrincipal.DayClick(Sender: TObject);
begin
  // Carregar escalas do dia
  ListarEventos;
end;

procedure TFormPrincipal.EdtTipoChange(Sender: TObject);
begin
  ListarFiltros;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cal.DisposeOf;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  TabControl.TabPosition := TTabPosition.None;
  TabControl.ActiveTab := TabDatas;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  SelecionaIcone(ImgDatas);

  cal := TCustomCalendar.Create(lytCalendario);
  cal.OnClick := DayClick;

  cloNotificacao.Visible := False;

  // Setup calendario
  cal.DayFontSize := 14;
  cal.DayFontColor := $FF737375;
  cal.SelectedDayColor := $FF4B7AF0;
  cal.BackgroundColor := $FFFFFFFF;

  // Montar calendario na tela
  cal.ShowCalendar;

  // Pintar Dias com Compromisso
  CarregaDadosCalendario();

  // Ajustar labels da data
  ListarEventos;
end;

procedure TFormPrincipal.ImgConfigClick(Sender: TObject);
begin
  SelecionaIcone(Sender);
  ActConfig.Execute;
end;

procedure TFormPrincipal.ImgDatasClick(Sender: TObject);
begin
  SelecionaIcone(Sender);
  ActDatas.Execute;
end;

procedure TFormPrincipal.ImgFavoritosClick(Sender: TObject);
begin
  Tela := 'Favoritos';
  ListarFavoritos;
  SelecionaIcone(Sender);
  ActFavoritos.Execute;
end;

procedure TFormPrincipal.ImgFiltrosClick(Sender: TObject);
begin
  Tela := 'Filtros';
  ListarFiltros;
  SelecionaIcone(Sender);
  ActFiltros.Execute;
end;

procedure TFormPrincipal.ImgAddClick(Sender: TObject);
begin
  if not Assigned(FormEventos) then
    Application.CreateForm(TFormEventos, FormEventos);

  FormEventos.modo := 'I';
  FormEventos.id_compromisso := 0;
  FormEventos.Show;
end;

procedure TFormPrincipal.imgAnteriorClick(Sender: TObject);
begin
  cal.PriorMonth;
  CarregaDadosCalendario();
  ListarEventos;
end;

procedure TFormPrincipal.imgNotificacaoClick(Sender: TObject);
begin
  if not Assigned(FormNotificacao) then
    Application.CreateForm(TFormNotificacao, FormNotificacao);

  cloNotificacao.Visible := False;
  FormNotificacao.Show;
end;

procedure TFormPrincipal.imgProximoClick(Sender: TObject);
begin
  cal.NextMonth;
  CarregaDadosCalendario();
  ListarEventos;
end;

procedure TFormPrincipal.lbxCompromissoItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  if not Assigned(FormEventos) then
    Application.CreateForm(TFormEventos, FormEventos);

  FormEventos.modo := 'A';
  FormEventos.id_compromisso := Item.Tag;
  FormEventos.Show;;
end;

end.
