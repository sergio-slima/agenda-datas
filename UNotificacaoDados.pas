unit UNotificacaoDados;

interface

uses FMX.Graphics;

type
  TNotificacao = record
    id : integer;
    icone : TBitmap;
    usuario_id : string;
    data : string;
    texto : string;
    tipo : string; // T = Texto  C = Convite
  end;

implementation

end.
