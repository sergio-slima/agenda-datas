unit UEventosDados;

interface

uses FMX.Graphics;

type
  TEventos = record
    id : Integer;
    data : String; //TDate;
    hora : String;
    descricao : String;
    favorito : String; // S ou N
    tipo : String;
  end;

implementation

end.
