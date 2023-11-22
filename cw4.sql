CREATE SCHEMA IF NOT EXISTS ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy
(
	id_pracownika INT PRIMARY KEY,
	imie VARCHAR(255) ,
	nazwisko VARCHAR(255),
	adres VARCHAR(255),
	telefon VARCHAR(255)
);

CREATE TABLE ksiegowosc.godziny
(
	id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin INT,
	id_pracownika INT,
	FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
);

ALTER TABLE ksiegowosc.pracownicy 
ALTER COLUMN imie SET NOT NULL,
ALTER COLUMN nazwisko SET NOT NULL;

ALTER TABLE ksiegowosc.godziny
ALTER COLUMN liczba_godzin SET NOT NULL;


CREATE TABLE ksiegowosc.pensje
(
	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(255) NOT NULL,
	kwota DECIMAL NOT NULL
);

CREATE TABLE ksiegowosc.premie
(
	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(255),
	kwota DECIMAL NOT NULL
);

CREATE TABLE ksiegowosc.wynagrodzenie
(
	id_wynagrodzenia INT PRIMARY KEY,
	data DATE,
	id_pracownika INT NOT NULL,
	id_godziny INT NOT NULL,
	id_pensji INT NOT NULL,
	id_premii INT,
	
	FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
	FOREIGN KEY(id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
	FOREIGN KEY(id_pensji) REFERENCES ksiegowosc.pensje(id_pensji),
	FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premie(id_premii)
);

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Dane o pracownikach';
COMMENT ON TABLE ksiegowosc.godziny IS 'Dane o godzinach';
COMMENT ON TABLE ksiegowosc.pensje IS 'Tu o pensjach';
COMMENT ON TABLE ksiegowosc.premie IS 'Tu rzeczy przyjemne';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tu wszystko razem';

INSERT INTO ksiegowosc.pracownicy VALUES
(1,'Jan','Nowak','Kroniewo 13','123456789'),
(2,'Michal','Podorlak','Warszawa ul. Sekund 2','43917383'),
(3,'Piotruś','Pan','Kraków ul. Sezamkowa 2','88281822'),
(4,'Halina','Nowak','Luboszno ul. Różana 2','888282829'),
(5,'Maria','Serek','Kraków ul. Piękna 2/5','987654321'),
(6,'Katarzyna','Król','Warszawa ul. Markowa 2','221821321'),
(7,'Marek','Adalbert','Krocko ul. Wielka 2','309181288'),
(8,'Joanna','Rapecka','Wójty 5','222333444'),
(9,'Juliusz','Pietruszko','Warszawa ul. Gliniana 2/6','000222333'),
(10,'Helena','Radek','Kalisz ul. Krakowska 3','222333777');


INSERT INTO ksiegowosc.godziny VALUES
(1,'2023-01-14',160,1),
(2,'2023-01-14',167,2),
(3,'2023-01-12',166,3),
(4,'2023-01-05',160,4),
(5,'2023-01-02',160,5),
(6,'2023-01-11',173,6),
(7,'2023-01-19',164,7),
(8,'2023-01-13',165,8),
(9,'2023-01-17',160,9),
(10,'2023-01-19',169,10);

INSERT INTO ksiegowosc.pensje VALUES
(1,'prezes',18700),
(2,'zastepca prezesa',18300),
(3,'przedstawiciel handlowy',15600),
(4,'dyrektor marketingu',16600),
(5,'dyrektor dzialu IT.',17500),
(6,'dyrektor dzialu transportu',14700),
(7,'dyrektor finansowy',15600),
(8,'specjalista ds. obslugi klienta',15300),
(9,'manager projektu',15300),
(10,'manager produktu',13100);


INSERT INTO ksiegowosc.premie VALUES
(1,'Premia swiateczna',450),
(2,'Premia swiateczna',450),
(3,'Za frekwencje',450),
(4,'Premia swiateczna',450),
(5,'Za frekwencje',450),
(6,'Za frekwencje',450),
(7,'Za frekwencje',450),
(8,'Premia swiateczna',450),
(9,'Regulaminowa',450),
(10,'Regulaminowa',450);


INSERT INTO ksiegowosc.wynagrodzenie VALUES 
(1,'2023-04-24',1,1,1,2),
(2,'2023-04-24',2,2,2,2),
(3,'2023-04-24',3,3,3,1),
(4,'2023-04-24',4,4,4,6),
(5,'2023-04-24',5,5,5,4),
(6,'2023-04-24',6,6,6,8),
(7,'2023-04-24',7,7,6,NULL),
(8,'2023-04-24',8,8,6,NULL),
(9,'2023-04-24',9,9,10,3),
(10,'2023-04-24',10,10,8,3);

--a
SELECT imie, nazwisko FROM ksiegowosc.pracownicy;


--b
SELECT ksiegowosc.wynagrodzenie.id_pracownika
FROM ksiegowosc.wynagrodzenie 
JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premie.id_premii
JOIN ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
WHERE ksiegowosc.pensje.kwota+ksiegowosc.premie.kwota> 17500;

--c
SELECT wy.id_pracownika
FROM ksiegowosc.wynagrodzenie wy
JOIN ksiegowosc.pensje  ON wy.id_pensji = ksiegowosc.pensje.id_pensji
FULL OUTER JOIN ksiegowosc.premie ON wy.id_premii = ksiegowosc.premie.id_premii
WHERE wy.id_premii IS NULL AND ksiegowosc.pensje.kwota > 14500;

--d
SELECT id_pracownika, imie, nazwisko
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%'

--e
UPDATE ksiegowosc.pracownicy
SET nazwisko = 'Panieńczykowska'
WHERE id_pracownika = 4

UPDATE ksiegowosc.pracownicy
SET nazwisko = 'Naporka'
WHERE id_pracownika = 1

SELECT id_pracownika, imie, nazwisko
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%a' OR nazwisko LIKE 'N%a'

--f
SELECT imie, nazwisko, liczba_godzin-160 AS nadgodziny
FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.godziny ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_godziny
WHERE liczba_godzin > 160

--g
SELECT imie, nazwisko
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
JOIN ksiegowosc.premie ON ksiegowosc.premie.id_premii = ksiegowosc.wynagrodzenie.id_premii
WHERE ksiegowosc.premie.kwota + ksiegowosc.pensje.kwota BETWEEN 15000 AND 16300

--h
SELECT imie, nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
WHERE liczba_godzin > 160 AND id_premii IS NULL

--i
SELECT p.id_pracownika, imie, nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON pe.id_pensji = w.id_pensji
ORDER BY pe.kwota DESC

--j
SELECT p.id_pracownika, imie, nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON pe.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premie pr ON pr.id_premii = w.id_premii
ORDER BY pe.kwota, pr.kwota DESC

--k
SELECT COUNT(p.id_pracownika), stanowisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
GROUP BY pe.stanowisko

--l
--dyrektor marketingu
SELECT AVG(pe.kwota+pr.kwota) AS Średnia, MIN(pe.kwota+pr.kwota) AS Minimum, MAX(pe.kwota+pr.kwota) AS Maksimum
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensje pe ON pe.id_pensji = w.id_pensji
JOIN ksiegowosc.premie pr ON pr.id_premii = w.id_premii
WHERE pe.stanowisko = 'dyrektor marketingu'

--m
SELECT SUM(pe.kwota+pr.kwota) AS Suma
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
RIGHT OUTER JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii

--n
SELECT pe.stanowisko, SUM(pe.kwota+pr.kwota) AS Suma
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
GROUP BY pe.stanowisko

--o
SELECT pe.stanowisko, COUNT(w.id_premii) AS Ilość
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
GROUP BY pe.stanowisko

--p
ALTER TABLE ksiegowosc.godziny
DROP CONSTRAINT godziny_id_pracownika_fkey,
ADD CONSTRAINT godziny_id_pracownika_fkey
FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika)
ON DELETE CASCADE;

ALTER TABLE ksiegowosc.wynagrodzenie
DROP CONSTRAINT wynagrodzenie_id_pracownika_fkey,
ADD CONSTRAINT wynagrodzenie_id_pracownika_fkey
FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika)
ON DELETE CASCADE;


DELETE FROM ksiegowosc.pracownicy pra
WHERE pra.id_pracownika IN 
(SELECT pra.id_pracownika 
 FROM ksiegowosc.pracownicy pra
JOIN ksiegowosc.wynagrodzenie w ON pra.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
RIGHT OUTER JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
WHERE pe.kwota + pr.kwota < 16000)

SELECT * FROM ksiegowosc.godziny