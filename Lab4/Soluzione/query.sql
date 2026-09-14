-- Visualizza il numero di prenotazioni per ogni stanza
SELECT STANZA_CodS, COUNT(*)
FROM PRENOTAZIONE
GROUP BY STANZA_CodS;

-- Visualizzare il numero di stanze, per tipo, per cui non sono mai state fatte prenotazioni 
SELECT 
  Type, 
  COUNT(*) AS Numero_di_Stanze_Senza_Prenotazioni 
FROM 
  STANZA 
WHERE 
  CodS NOT IN (
    SELECT 
      STANZA_CodS 
    FROM 
      PRENOTAZIONE
  )
GROUP BY 
  Type;


-- Visualizzare per ciascun mese il codice, piano, superficie e tipo di stanza con il costo medio giornaliero mensile più alto

WITH costi_mensili AS (
    SELECT STANZA_CodS, EXTRACT(YEAR FROM TO_DATE(DataInizio, 'YYYY-MM-DD')) AS Anno, EXTRACT(MONTH FROM TO_DATE(DataInizio, 'YYYY-MM-DD')) AS Mese, 
           Costo/(TO_DATE(DataFine, 'YYYY-MM-DD') - TO_DATE(DataInizio, 'YYYY-MM-DD')) AS CostoGiornaliero
    FROM PRENOTAZIONE
), 
costi_mensili_raggruppati AS (
    SELECT Anno, Mese, STANZA_CodS, AVG(CostoGiornaliero) AS MediaGiornaliera
    FROM costi_mensili
    GROUP BY Anno, Mese, STANZA_CodS
),
costi_mensili_max AS (
    SELECT Anno, Mese, MAX(MediaGiornaliera) AS MediaGiornalieraMax
    FROM costi_mensili_raggruppati
    GROUP BY Anno, Mese
)
SELECT cmr.Mese, cmr.STANZA_CodS, s.Piano, s.Superficie, s.Type, cmr.MediaGiornaliera
FROM costi_mensili_raggruppati cmr
JOIN costi_mensili_max cmm ON cmr.Anno = cmm.Anno AND cmr.Mese = cmm.Mese AND cmr.MediaGiornaliera = cmm.MediaGiornalieraMax
JOIN STANZA s ON s.CodS = cmr.STANZA_CodS;



