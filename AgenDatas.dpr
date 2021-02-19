program AgenDatas;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULogin in 'ULogin.pas' {FormLogin},
  UPrincipal in 'UPrincipal.pas' {FormPrincipal},
  uCustomCalendar in 'uCustomCalendar.pas',
  UNotificacao in 'UNotificacao.pas' {FormNotificacao},
  UEventos in 'UEventos.pas' {FormEventos},
  UNotificacaoDados in 'UNotificacaoDados.pas',
  UEventosDados in 'UEventosDados.pas',
  UNotificacaoFrame in 'UNotificacaoFrame.pas' {FrameNotificacao: TFrame},
  UEventosTiposDados in 'UEventosTiposDados.pas',
  UEventosTiposFrame in 'UEventosTiposFrame.pas' {FrameEventosTipos: TFrame},
  UDM in 'UDM.pas' {DM: TDataModule},
  UEventosFrame in 'UEventosFrame.pas' {FrameEventos: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
