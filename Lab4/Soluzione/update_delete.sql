-- Update
-- Aggiorna la colonna Tel della tabella AGENZIA per la riga dove CodA = 1
UPDATE AGENZIA SET Tel = '0987654321' WHERE CodA = 1;

-- Aggiorna le colonne Superficie e Type della tabella STANZA per la riga dove CodS = 1
UPDATE STANZA SET Superficie = 30, Type = 'doppia' WHERE CodS = 1;

-- Aggiorna la colonna Costo della tabella PRENOTAZIONE per la riga dove STANZA_CodS = 1 e DataInizio corrisponde a '2023-01-01'
UPDATE PRENOTAZIONE SET DataInizio = '2023-01-10', DataFine = '2023-01-20', Costo = 400.00 WHERE STANZA_CodS = 1 AND DataInizio = '2023-01-01';


-- La prenotazione dal  12 Gennaio 2023 fino al 17 Gennaio 2023 per la stanza 2 è stata cancellata.
DELETE FROM PRENOTAZIONE WHERE STANZA_CodS = 2 AND DataInizio = '2023-01-12' AND DataFine = '2023-01-17';

-- Tutte le prenotazioni tra il  12 Gennaio 2023 al 17 Gennaio 2023 sono state cancellate.
DELETE FROM PRENOTAZIONE WHERE DataInizio >= '2023-01-12' AND DataFine < '2023-01-17';


