unit UEventosDados;

interface

uses FMX.Graphics;

type
  TEventos = record
    id : integer;
    data : TDate;
    hora : string;
    descricao : string;
    favorito : string; // S ou N
    tipo : string;
  end;

implementation

end.
