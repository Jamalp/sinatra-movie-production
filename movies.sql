CREATE TABLE people (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  title VARCHAR(255)
);

CREATE TABLE movies(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255),
  people_id INT references people(id)
);

CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255),
  complete BOOLEAN,
  movie_id INT references movies(id),
  people_id INT references people(id)
);

# INSERT INTO movies(name, description) VALUES ('A Clockwork Orange', 'In future Britain, charismatic delinquent Alex DeLarge is jailed and volunteers for an experimental aversion therapy developed by the government in an effort to solve societys crime problem... but not all goes to plan.');

