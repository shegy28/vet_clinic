/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


/*1st transaction */
BEGIN;
UPDATE animals
SET species = 'Unspecified';
SELECT * from animals;
ROLLBACK;

/*2nd transaction */

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species = '';

SELECT * from animals;
COMMIT;

/*3rd transaction */

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * from animals;

/*4th transaction */

BEGIN;
DELETE FROM animals
where date_of_birth > '2022-01-01';
SAVEPOINT afterdate;

UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK to afterdate;

UPDATE animals
SET weight_kg = weight_kg * -1
where weight_kg < 0;
COMMIT;

/* Aggregate Functions */

SELECT COUNT(name) FROM animals;

SELECT COUNT(escape_attempts) FROM animals
where escape_attempts < 1;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, sum(escape_attempts)
FROM animals
GROUP BY neutered;

SELECT species, min(weight_kg), max(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


