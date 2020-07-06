-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE pracownik (
id INT PRIMARY KEY auto_increment,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
wyplata DECIMAL(8,2),
data_urodzenia DATE,
stanowisko VARCHAR(25)
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO pracownik(imie, nazwisko, wyplata, data_urodzenia, stanowisko) 
VALUES ('Jan', 'Kowalski', 7500, '1990-11-24', 'informatyk'),
('Maria', 'Jarkowska', 4700, '1993-02-13', 'sekretarka'),
('Wiktoria', 'Pakosińska', 5400, '1988-09-03', 'informatyk'),
('Krzysztof', 'Gomułka', 2500, '1979-05-30', 'ochroniarz'),
('Beata', 'Sadowska', 6600, '1982-05-10', 'analityk'),
('Krzysztof', 'Dąbrowski', 11900, '1981-01-24', 'prezes'),
('Mariusz', 'Kowalski', 7200, '1986-10-01', 'analityk'),
('Dominik', 'Piotrowski', 2900, '2000-04-27', 'stażysta');

-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM pracownik
ORDER BY nazwisko;

-- 4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM pracownik 
WHERE stanowisko = 'informatyk';

 -- 5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM pracownik
WHERE TIMESTAMPDIFF(YEAR, data_urodzenia, CURDATE()) >= 30;

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE pracownik
SET wyplata = wyplata * 1.1
WHERE stanowisko = 'analityk';

-- 7. Usuwa najmłodszego pracownika
DELETE FROM pracownik
WHERE data_urodzenia = (SELECT MAX(data_urodzenia))
ORDER BY data_urodzenia DESC
LIMIT 1;

-- 8. Usuwa tabelę pracownik
DROP TABLE pracownik;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE stanowisko (
id INT PRIMARY KEY auto_increment,
nazwa_stanowiska VARCHAR(25) NOT NULL,
opis VARCHAR(160),
wyplata DECIMAL(8,2)
);

-- 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE adres (
id INT PRIMARY KEY auto_increment,
ulica_nrdomu_nrmieszkania VARCHAR(50) NOT NULL,
kod_pocztowy VARCHAR(6),
miejscowosc VARCHAR(40) NOT NULL
);

-- 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE pracownik (
id INT PRIMARY KEY auto_increment,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
data_urodzenia DATE,
stanowisko_id INT,
adres_id INT
);

-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO stanowisko(id,nazwa_stanowiska, opis, wyplata) 
VALUES (1, 'prezes', 'właściciel firmy', 11900),
(2, 'informatyk', 'osoba pracująca w dziale IT', 7500),
(3, 'analityk', 'osoba zajmująca się analizą danych', 6900),
(4, 'sekretarka', 'osoba pracująca w biurze prezesa', 4900),
(5, 'ochroniarz', 'osoba zajmująca się ochroną osób i mienia', 2700),
(6, 'stażysta', 'osoba odbywająca staż w różnych działach', 2900);

INSERT INTO adres(id, ulica_nrdomu_nrmieszkania, kod_pocztowy, miejscowosc)
VALUES (1, 'Piękna 42/173', '02-223', 'Kazimierz Dolny'),
(2, 'Ćwiartki 3/4', '13-111', 'Warszawa'),
(3, 'Mokotowska 114', '05-040', 'Kraków'),
(4, 'Skarbka z Gór 2A/47', '00-321', 'Warszawa'),
(5, 'Henryka Sienkiewicza 140/2', '02-009', 'Warszawa'),
(6, 'Henryka Sienkiewicza 140/17', '02-009', 'Warszawa');

INSERT INTO pracownik(imie, nazwisko, data_urodzenia, stanowisko_id, adres_id) 
VALUES ('Jan', 'Kowalski', '1990-11-24', 2, 2),
('Maria', 'Jarkowska', '1993-02-13', 4, 4),
('Wiktoria', 'Pakosińska', '1988-09-03', 2, 5),
('Krzysztof', 'Gomułka', '1979-05-30', 5, 3),
('Beata', 'Sadowska', '1982-05-10', 3, 2),
('Krzysztof', 'Dąbrowski', '1981-01-24', 1, 1),
('Mariusz', 'Kowalski', '1986-10-01', 3, 5),
('Dominik', 'Piotrowski', '2000-04-27', 6, 6);

-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT imie, nazwisko, ulica_nrdomu_nrmieszkania, kod_pocztowy, miejscowosc, nazwa_stanowiska FROM pracownik p
JOIN adres a ON p.adres_id = a.id
JOIN stanowisko s ON p.stanowisko_id = s.id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(wyplata) AS SUMA_WYPLAT FROM pracownik p
JOIN stanowisko s ON p.stanowisko_id = s.id;

-- 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT imie, nazwisko, ulica_nrdomu_nrmieszkania, kod_pocztowy, miejscowosc FROM pracownik p
JOIN adres a ON p.adres_id = a.id
WHERE kod_pocztowy = '02-009';