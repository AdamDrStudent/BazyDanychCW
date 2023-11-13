CREATE SCHEMA rozliczenia;

CREATE TABLE rozliczenia.pracownicy
(
	id_pracownika INT PRIMARY KEY,
	imie VARCHAR(255) NOT NULL,
	nazwisko VARCHAR(255) NOT NULL,
	adres VARCHAR(255),
	telefon VARCHAR(255)	
);

CREATE TABLE rozliczenia.godziny
(
	id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin DECIMAL NOT NULL,
	id_pracownika INT NOT NULL
);

CREATE TABLE rozliczenia.pensje
(
	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(255),
	kwota DECIMAL NOT NULL,
	id_premii INT
);

CREATE TABLE rozliczenia.premie
(
	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(255),
	kwota DECIMAL NOT NULL
);


INSERT INTO rozliczenia.pracownicy VALUES
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

INSERT INTO rozliczenia.godziny VALUES
(1,'2023-01-22',3,4),
(2,'2023-01-25',6,1),
(3,'2023-07-21',3,1),
(4,'2023-03-12',7,10),
(5,'2023-04-26',9,5),
(6,'2023-02-27',2,3),
(7,'2023-01-02',7,7),
(8,'2023-01-08',9,8),
(9,'2023-06-12',4,9),
(10,'2023-11-06',5,2);

INSERT INTO rozliczenia.pensje VALUES
(1,'Kierownik',7600,1),
(2,'Zastępca kierownika',7100,2),
(3,'Menedzer',5300,3),
(4,'Specjalista',3400,4),
(5,'Specjalista',6850,5),
(6,'Specjalista',6900,6),
(7,'Kierownik dzialu transportu',6900,7),
(8,'Kierownik dzialu PR',6800,8),
(9,'Mlodszy specjalista',6600,9),
(10,'Mlodszy specjalista',6600,10);

INSERT INTO rozliczenia.premie VALUES
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

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

SELECT DATE_PART('month', data) AS miesiac, DATE_PART('dow', data) AS dzien FROM rozliczenia.godziny;

ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD kwota_netto DECIMAL;

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto*0.77;

