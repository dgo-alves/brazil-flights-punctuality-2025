CREATE DATABASE anac_voos;
GO

USE anac_voos;
GO

CREATE TABLE fato_voos (
    ICAO_Empresa_Aerea      nvarchar(50),
    Numero_Voo              nvarchar(50),
    Codigo_Autorizacao_DI   nvarchar(50),
    Codigo_Tipo_Linha       nvarchar(50),
    ICAO_Aerodromo_Origem   nvarchar(50),
    ICAO_Aerodromo_Destino  nvarchar(50),
    Partida_Prevista        nvarchar(50),
    Partida_Real            nvarchar(50),
    Chegada_Prevista        nvarchar(50),
    Chegada_Real            nvarchar(50),
    Situacao_Voo            nvarchar(50),
    Codigo_Justificativa    nvarchar(50)
);
GO
