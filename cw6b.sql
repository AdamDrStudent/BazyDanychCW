--a
-- ponizsze funkcje, aby resetowac numery telefonu w razie wpadki
UPDATE ksiegowosc.pracownicy
SET telefon = '884222822'
WHERE id_pracownika = 1;

UPDATE ksiegowosc.pracownicy
SET telefon = '334765111'
WHERE id_pracownika = 2;

UPDATE ksiegowosc.pracownicy
SET telefon = '800966587'
WHERE id_pracownika = 3;

UPDATE ksiegowosc.pracownicy
SET telefon = '326579530'
WHERE id_pracownika = 4;

UPDATE ksiegowosc.pracownicy
SET telefon = '234789654'
WHERE id_pracownika = 5;

UPDATE ksiegowosc.pracownicy
SET telefon = '888555444'
WHERE id_pracownika = 6;

UPDATE ksiegowosc.pracownicy
SET telefon = '075895332'
WHERE id_pracownika = 7;

UPDATE ksiegowosc.pracownicy
SET telefon = '685379647'
WHERE id_pracownika = 8;

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ',telefon);

SELECT telefon FROM ksiegowosc.pracownicy



--b
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(SUBSTR(telefon,1,3),'-',SUBSTR(telefon,4,3),'-',SUBSTR(telefon,7,3))

--c
SELECT UPPER(nazwisko) AS nazwisko FROM ksiegowosc.pracownicy
ORDER BY LENGTH(nazwisko) DESC 
LIMIT 1

--d
SELECT MD5(imie) AS imie, MD5(nazwisko) AS nazwisko, MD5(kwota::char) AS pensje 
FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON pe.id_pensji = w.id_pensji

--f
SELECT imie, nazwisko, pe.kwota AS pensja,pr.kwota AS premia 
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
LEFT JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii

--g
SELECT CONCAT('Pracownik ',imie,' ',nazwisko,' w dniu ',w.data,' otrzymal pensje calkowita na kwote ',pr.kwota+pe.kwota+450*(g.liczba_godzin-160),' zł, gdzie wynagrodzenie zasadnicze wynosilo: ',pe.kwota,' zł, premia: ',CAST(COALESCE(pr.kwota,0) AS DECIMAL),' zł, nadgodziny: ',(g.liczba_godzin-160)*450,' zł') AS Komunikat
FROM ksiegowosc.godziny g
JOIN ksiegowosc.pracownicy p ON g.id_pracownika = p.id_pracownika
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensje pe ON pe.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premie pr ON pr.id_premii = w.id_premii



