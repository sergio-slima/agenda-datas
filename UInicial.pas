unit UInicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  System.Actions, FMX.ActnList;

type
  TFormInicial = class(TForm)
    TabControl: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    LytProximo: TLayout;
    Layout2: TLayout;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Layout3: TLayout;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Layout5: TLayout;
    Image4: TImage;
    StyleBook1: TStyleBook;
    BtnVoltar: TSpeedButton;
    BtnProximo: TSpeedButton;
    ActionList1: TActionList;
    LytBotoes: TLayout;
    BtnLogin: TSpeedButton;
    ActTab1: TChangeTabAction;
    ActTab2: TChangeTabAction;
    ActTab3: TChangeTabAction;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure NavegacaoAba(cont: integer);
    procedure BtnVoltarClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInicial: TFormInicial;

implementation

{$R *.fmx}

uses ULogin, UPrincipal;

procedure TFormInicial.BtnLoginClick(Sender: TObject);
begin
  if not Assigned(FormPrincipal) then
    Application.CreateForm(TFormPrincipal, FormPrincipal);

  Application.MainForm := FormPrincipal;
  FormPrincipal.TabControl.ActiveTab := FormPrincipal.TabDatas;
  FormPrincipal.Show;
  FormInicial.Close;
end;

procedure TFormInicial.BtnProximoClick(Sender: TObject);
begin
  NavegacaoAba(1);
end;

procedure TFormInicial.BtnVoltarClick(Sender: TObject);
begin
  NavegacaoAba(-1);
end;

procedure TFormInicial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FormInicial := nil;
end;

procedure TFormInicial.FormCreate(Sender: TObject);
begin
  TabControl.TabPosition := TTabPosition.None;
  TabControl.ActiveTab := TabItem1;
  lytProximo.Visible:=True;
  lytBotoes.Visible:=False;
  NavegacaoAba(-1);
end;

procedure TFormInicial.NavegacaoAba(cont: integer);
begin
  //Proximo..
  if cont > 0 then
  begin
    case TabControl.TabIndex of
      0: ActTab2.Execute;
      1: ActTab3.Execute;
    end;
  end
  else
  //Voltar..
  begin
    case TabControl.TabIndex of
      2: ActTab2.Execute;
      1: ActTab1.Execute;
    end;
  end;

  // tratando botao
  BtnVoltar.Visible:= True;
  BtnProximo.Visible:= True;

  if TabControl.TabIndex = 0 then
    BtnVoltar.Visible := False
  else if TabControl.TabIndex = 2 then
  begin
    lytProximo.Visible:= False;
    lytBotoes.Visible:=True;
  end;
end;

end.
