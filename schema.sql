/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id              INT GENERATED ALWAYS AS IDENTITY,
  name            VARCHAR(250),
  date_of_birth   DATE,
  escape_attempts INT,
  neutered        BOOLEAN,
  weight_kg       DECIMAL,
  PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species varchar(255);

-- Multiple tables

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name varchar(255),
    age int,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    PRIMARY KEY (id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals 
ADD COLUMN species_id INT;


ALTER TABLE animals
ADD CONSTRAINT fk_animals_spec
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals 
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_animals_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);


-- DAy 4 many to many

Create table vets (
   id INT GENERATED ALWAYS AS IDENTITY,
   name varchar(250),
   age int,
   date_of_graduation date,
   PRIMARY KEY (id)
);


create table specializations (
  speciesID int,
  CONSTRAINT fk_species
      FOREIGN KEY(speciesID) 
	  REFERENCES species(id)
);

ALTER TABLE specializations 
ADD COLUMN vetsID INT;

ALTER TABLE specializations
ADD CONSTRAINT fk_vets
FOREIGN KEY (vetsID)
REFERENCES vets(id);

ALTER TABLE specializations 
ADD CONSTRAINT PK_specializations 
PRIMARY KEY (speciesID ,vetsID);



create table visits (
  animals_id int,
  vets_id int,
  visit_date date,
  CONSTRAINT fk_animals
      FOREIGN KEY(animals_id) 
	  REFERENCES animals(id)
);

ALTER TABLE visits
ADD CONSTRAINT fk_vets
FOREIGN KEY(vets_id) 
REFERENCES vets(id);

ALTER TABLE visits
ADD CONSTRAINT PK_visits
PRIMARY KEY (animals_id,vets_id,visit_date);





