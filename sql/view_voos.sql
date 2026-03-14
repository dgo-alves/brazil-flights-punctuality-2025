USE anac_voos;
GO

CREATE OR ALTER VIEW vw_voos AS
SELECT
    ICAO_Empresa_Aerea,
    Numero_Voo,
    Codigo_Tipo_Linha,
    ICAO_Aerodromo_Origem,
    ICAO_Aerodromo_Destino,

    
    REPLACE(Situacao_Voo, '"', '')                                          AS Situacao_Voo,
    Codigo_Justificativa,

    
    TRY_CAST(REPLACE(Partida_Prevista,  '"', '') AS datetime2)              AS Partida_Prevista,
    TRY_CAST(REPLACE(Partida_Real,      '"', '') AS datetime2)              AS Partida_Real,
    TRY_CAST(REPLACE(Chegada_Prevista,  '"', '') AS datetime2)              AS Chegada_Prevista,
    TRY_CAST(REPLACE(Chegada_Real,      '"', '') AS datetime2)              AS Chegada_Real,

    
    TRY_CAST(TRY_CAST(REPLACE(Partida_Prevista, '"', '') AS datetime2) AS date) AS Data_Partida,

    
    CASE
        WHEN TRY_CAST(REPLACE(Partida_Real,     '"', '') AS datetime2) IS NOT NULL
         AND TRY_CAST(REPLACE(Partida_Prevista, '"', '') AS datetime2) IS NOT NULL
        THEN DATEDIFF(MINUTE,
                TRY_CAST(REPLACE(Partida_Prevista, '"', '') AS datetime2),
                TRY_CAST(REPLACE(Partida_Real,     '"', '') AS datetime2))
        ELSE NULL
    END AS Atraso_Partida_Min,

   
    CASE
        WHEN TRY_CAST(REPLACE(Chegada_Real,     '"', '') AS datetime2) IS NOT NULL
         AND TRY_CAST(REPLACE(Chegada_Prevista, '"', '') AS datetime2) IS NOT NULL
        THEN DATEDIFF(MINUTE,
                TRY_CAST(REPLACE(Chegada_Prevista, '"', '') AS datetime2),
                TRY_CAST(REPLACE(Chegada_Real,     '"', '') AS datetime2))
        ELSE NULL
    END AS Atraso_Chegada_Min,

    
    CASE
        WHEN REPLACE(Situacao_Voo, '"', '') = 'CANCELADO' THEN 'Cancelado'
        WHEN DATEDIFF(MINUTE,
                TRY_CAST(REPLACE(Partida_Prevista, '"', '') AS datetime2),
                TRY_CAST(REPLACE(Partida_Real,     '"', '') AS datetime2)) > 15 THEN 'Atrasado'
        ELSE 'No Prazo'
    END AS Status_Pontualidade

FROM fato_voos
WHERE REPLACE(Situacao_Voo, '"', '') IS NOT NULL
  AND TRY_CAST(TRY_CAST(REPLACE(Partida_Prevista, '"', '') AS datetime2) AS date) < '2026-01-01';
GO

SELECT TOP 10 * FROM vw_voos;
GO
