unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.TabControl,
  System.Actions, FMX.ActnList;

type
  TFormLogin = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Layout3: TLayout;
    edtUsuario: TEdit;
    btnAcessar: TRectangle;
    btnLogin: TSpeedButton;
    Layout4: TLayout;
    Image2: TImage;
    Layout5: TLayout;
    lblCadastrar: TLabel;
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabCadastrar: TTabItem;
    ActionList1: TActionList;
    actLogin: TChangeTabAction;
    actCadastrar: TChangeTabAction;
    Layout6: TLayout;
    Image3: TImage;
    Label4: TLabel;
    Layout7: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    Layout8: TLayout;
    edtUsuarioNovo: TEdit;
    Rectangle1: TRectangle;
    btnCadastrar: TSpeedButton;
    Label9: TLabel;
    Layout9: TLayout;
    imgPregador: TImage;
    imgPastor: TImage;
    imgAnciao: TImage;
    cloSelecao: TCircle;
    Layout10: TLayout;
    lblLogin: TLabel;
    Layout11: TLayout;
    Image7: TImage;
    procedure FormCreate(Sender: TObject);
    procedure lblCadastrarClick(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure imgPregadorClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.fmx}

uses UPrincipal, UDM;

procedure SelecionaIcone(Sender: TObject);
begin
  with FormLogin do
  begin
    imgPregador.Tag := 0;
    imgAnciao.Tag := 0;
    imgPastor.Tag := 0;

    TImage(Sender).Tag := 1;

    cloSelecao.AnimateFloat('Position.X', TImage(Sender).Position.X + 25, 0.2);
  end;

end;

procedure TFormLogin.btnCadastrarClick(Sender: TObject);
var
  icone : TBitmap;
begin
  // Verificar se usuario existe
  DM.SqlUsuarios.Active := False;
  DM.SqlUsuarios.SQL.Clear;
  DM.SqlUsuarios.SQL.Add('SELECT * FROM USUARIOS');
  DM.SqlUsuarios.SQL.Add('WHERE USUARIO = :USUARIO');
  DM.SqlUsuarios.ParamByName('USUARIO').Value := edtUsuarioNovo.Text;
  DM.SqlUsuarios.Active := True;

  if DM.SqlUsuarios.RecordCount > 0 then
  begin
    ShowMessage('Usuário já cadastrado.');
    Exit;
  end;

  // Icone selecionado
  if imgPregador.Tag = 1 then icone := imgPregador.Bitmap;
  if imgAnciao.Tag = 1 then icone := imgAnciao.Bitmap;
  if imgPastor.Tag = 1 then icone := imgPastor.Bitmap;

  // Cadastrar Usuario
  try
    DM.SqlUsuarios.Active := False;
    DM.SqlUsuarios.SQL.Clear;
    DM.SqlUsuarios.SQL.Add('INSERT INTO USUARIOS (USUARIO, ICONE)');
    DM.SqlUsuarios.SQL.Add('VALUES (:USUARIO, :ICONE)');
    DM.SqlUsuarios.ParamByName('USUARIO').Value := edtUsuarioNovo.Text;
    DM.SqlUsuarios.ParamByName('ICONE').Assign(icone);
    DM.SqlUsuarios.ExecSQL;
  except
    ShowMessage('Erro ao criar nova conta');
    Exit;
  end;

  if not Assigned(FormPrincipal) then
    Application.CreateForm(TFormPrincipal, FormPrincipal);

  Application.MainForm := FormPrincipal;
//  FormPrincipal.pusuario := edtUsuarioNovo.Text;
  FormPrincipal.Show;
  FormLogin.Close;
end;

procedure TFormLogin.btnLoginClick(Sender: TObject);
begin
  // Verificar se usuario existe
  DM.SqlUsuarios.Active := False;
  DM.SqlUsuarios.SQL.Clear;
  DM.SqlUsuarios.SQL.Add('SELECT * FROM USUARIOS');
  DM.SqlUsuarios.SQL.Add('WHERE USUARIO = :USUARIO');
  DM.SqlUsuarios.ParamByName('USUARIO').Value := edtUsuario.Text;
  DM.SqlUsuarios.Active := True;

  if DM.SqlUsuarios.RecordCount = 0 then
  begin
    ShowMessage('Usuário não encontrado.');
    Exit;
  end;

  if not Assigned(FormPrincipal) then
    Application.CreateForm(TFormPrincipal, FormPrincipal);

  Application.MainForm := FormPrincipal;
  //FormPrincipal.pusuario := edtUsuario.Text;
  FormPrincipal.Show;
  FormLogin.Close;
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  TabControl.TabPosition := TTabPosition.None;
  TabControl.ActiveTab := TabLogin;
end;

procedure TFormLogin.FormShow(Sender: TObject);
begin
  SelecionaIcone(imgPregador);
end;

procedure TFormLogin.imgPregadorClick(Sender: TObject);
begin
  SelecionaIcone(Sender);
end;

procedure TFormLogin.lblCadastrarClick(Sender: TObject);
begin
  actCadastrar.Execute;
end;

procedure TFormLogin.lblLoginClick(Sender: TObject);
begin
  actLogin.Execute;
end;

end.
