-- Tworzenie tabeli KATEGORIE
CREATE TABLE kategorie (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL
);

-- Tworzenie tabeli DOSTAWCY
CREATE TABLE dostawcy (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    adres VARCHAR(255),
    telefon VARCHAR(15)
);

-- Tworzenie tabeli PRODUKTY
CREATE TABLE produkty (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    kategoria_id INT REFERENCES kategorie(id),
    dostawca_id INT REFERENCES dostawcy(id),
    cena NUMERIC(10, 2) NOT NULL,
    ilosc INT DEFAULT 0,
    data_dostawy DATE
);

-- Dodanie przykładowych Kategorii
INSERT INTO kategorie (nazwa) VALUES 
('Elektronika'), 
('Artykuły biurowe'), 
('Odzież'), 
('Sport'), 
('Zdrowie i Uroda'), 
('Motoryzacja');

-- Dodanie przykładowych Dostawców
INSERT INTO dostawcy (nazwa, adres, telefon) VALUES 
('Dostawca A', 'Ulica 123, Miasto', '123-456-789'),
('Dostawca B', 'Ulica 456, Miasto', '987-654-321'),
('Dostawca C', 'Ulica 789, Miasto', '111-222-333');

-- Skrypt do generowania 5 milionów produktów w tabeli produkty
DO $$
DECLARE
    i INT := 1;
    random_category INT;
    random_supplier INT;
    random_price NUMERIC(10,2);
    random_quantity INT;
    random_date DATE;
BEGIN
    -- Generujemy 5 milionów produktów
    WHILE i <= 5000000 LOOP
        -- Losowanie kategorii, dostawcy, ceny, ilości oraz daty dostawy
        random_category := (SELECT id FROM kategorie ORDER BY RANDOM() LIMIT 1);
        random_supplier := (SELECT id FROM dostawcy ORDER BY RANDOM() LIMIT 1);
        random_price := ROUND(10 + (RANDOM() * (1000 - 10)), 2);  -- Cena między 10 a 1000
        random_quantity := FLOOR(RANDOM() * 1000);  -- Ilość między 0 a 1000
        random_date := CURRENT_DATE - (FLOOR(RANDOM() * 3650));  -- Data dostawy w ciągu ostatnich 10 lat

        -- Wstawianie nowego produktu
        INSERT INTO produkty (nazwa, kategoria_id, dostawca_id, cena, ilosc, data_dostawy) 
        VALUES (
            'Produkt ' || i, 
            random_category, 
            random_supplier, 
            random_price, 
            random_quantity, 
            random_date
        );

        -- Zwiększamy licznik
        i := i + 1;
    END LOOP;
END $$;