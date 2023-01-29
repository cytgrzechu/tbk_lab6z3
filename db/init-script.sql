CREATE TABLE cars
(
    id      SERIAL PRIMARY KEY,
    model   VARCHAR(50),
    year    INT,
    details TEXT
);

INSERT INTO 
cars (model, "year", details)
VALUES
('Ford Mondeo', 2011, 'Good condition. Leather on driver seat is worn out.'),
('Volkswagen Arteon', 2020, 'Pristine condition.'),
('Renault Clio', 2014, 'Needs repainting.');