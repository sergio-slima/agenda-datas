object DM: TDM
  OldCreateOrder = False
  Height = 481
  Width = 391
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Sergio\Documents\Embarcadero\Studio\Projects\a' +
        'genda-datas\banco.sqlite'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 264
    Top = 16
  end
  object QryEventos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from eventos')
    Left = 264
    Top = 80
  end
  object QryTipos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from tipos')
    Left = 264
    Top = 144
  end
end
