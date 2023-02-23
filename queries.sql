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


-- Day 3 Join queries

SELECT owner_id, full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME"
   FROM animals
   INNER JOIN owners
   ON  animals.owner_id = owners.id
   WHERE owners.full_name = 'Melody Pond';

SELECT species.name AS "Animal Species", animals.name AS "ANIMALS NAME"
    FROM animals
    JOIN species
    on animals.species_id = species.id
    where species.id = 1;

SELECT  full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME"
   FROM owners
   LEFT JOIN  animals
   ON  owners.id =  animals.owner_id ;

SELECT species.name AS "SPECIES NAME",  COUNT(animals.name) AS "SPECIES COUNT" 
    FROM species
    JOIN animals
    on species.id = animals.species_id 
    GROUP By species.name;

SELECT full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME",species.name AS "Animal Species"
   FROM animals
   INNER JOIN owners ON  animals.owner_id = owners.id
   INNER JOIN species ON  animals.species_id = species.id
   WHERE owners.id = 2 and species.name = 'Digimon';   

SELECT full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME",species.name AS "Animal Species"
   FROM animals
   INNER JOIN owners ON  animals.owner_id = owners.id
   INNER JOIN species ON  animals.species_id = species.id
   WHERE owners.id = 5 and animals.escape_attempts = 0;  

SELECT full_name AS "OWNER NAME",  COUNT(animals.name) AS "ANIMAL COUNT" 
    FROM owners
    JOIN animals
    on owners.id = animals.owner_id 
    GROUP By full_name
    ORDER BY COUNT(animals.name) DESC LIMIT 1;


-- Day 4 Query many-many relationships


SELECT animals.name AS "LAST ANIMAL SEEN", visit_date
    from animals
    JOIN visits
    ON animals.id = visits.animals_id
    WHERE vets_id = (SELECT id from vets WHERE name = 'William Tatcher')
    ORDER BY visit_date DESC LIMIT 1;

SELECT vets.name AS "VET NAME" , COUNT(animals.name) AS "Different Animal Seen Count"
    from animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON visits.vets_id = vets.id
    WHERE vets_id = (SELECT id from vets WHERE name = 'Stephanie Mendez')
    GROUP BY vets.name;

SELECT  vets.name AS "VET NAME" , species.name AS "SpecializATION"
   FROM vets
   LEFT JOIN  specializations ON vets.id = specializations.vetsID
   LEFT JOIN species on specializations.speciesID = species.id;

SELECT vets.name AS "VET NAME" , animals.name AS "Animal Seen", visit_date
    from animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON visits.vets_id = vets.id
    WHERE vets_id = (SELECT id from vets WHERE name = 'Stephanie Mendez') AND visit_date BETWEEN '2020-04-01' and '2020-08-30';

SELECT animals.name , COUNT (*) as "Visit count"
   from animals
   JOIN visits ON animals.id = visits.animals_id
   GROUP BY  animals.name
   ORDER BY COUNT (*) DESC LIMIT 1;

SELECT animals.name AS "FIRST ANIMAL SEEN", visit_date
    from animals
    JOIN visits
    ON animals.id = visits.animals_id
    WHERE vets_id = (SELECT id from vets WHERE name = 'Maisy Smith')
    ORDER BY visit_date ASC LIMIT 1;

SELECT animals.name AS "RECENT ANIMAL SEEN", vets.name AS "VET NAME", visit_date AS "Visit Date"
    FROM animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON visits.vets_id = vets.id
    ORDER BY visit_date DESC LIMIT 1;

SELECT species.name AS "Species Name" 
    FROM visits
    JOIN animals ON visits.animals_id = animals.id 
    JOIN vets ON visits.vets_id = vets.id
    JOIN species ON animals.species_id = species.id 
    WHERE visits.vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') 
    GROUP BY species.name 
    ORDER BY count(animals.name) DESC LIMIT 1;

SELECT COUNT(*) AS "number of visits" FROM vets
    INNER JOIN visits ON vets.id = visits.vets_id
    LEFT JOIN specializations ON vets.id = specializations.vetsID
    LEFT JOIN species ON specializations.speciesID = species.id
    WHERE species IS NULL;








  
   


