unit UEventosFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrameEventos = class(TFrame)
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Layout3: TLayout;
    lblDescricao: TLabel;
    Layout1: TLayout;
    lblData: TLabel;
    ImgOutros: TImage;
    ImgON: TImage;
    ImgOFF: TImage;
    ImgAniversario: TImage;
    ImgIgreja: TImage;
    ImgEscola: TImage;
    ImgFestas: TImage;
    ImgTrabalho: TImage;
    ImgViagens: TImage;
    Layout4: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
