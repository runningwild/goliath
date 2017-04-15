CREATE USER goliath;

CREATE DATABASE IF NOT EXISTS Goliath;

GRANT ALL ON DATABASE Goliath TO goliath;

SET DATABASE TO Goliath;

CREATE TABLE IF NOT EXISTS Folder (
  -- Key columns
  id SERIAL PRIMARY KEY,
  -- Data columns
  name STRING
);

CREATE TABLE IF NOT EXISTS FolderChildren (
  -- Key columns
  parent INT NOT NULL REFERENCES Folder (id),
  child INT NOT NULL REFERENCES Folder (id),
  PRIMARY KEY (parent, child)
) INTERLEAVE IN PARENT Folder (parent);

CREATE TABLE IF NOT EXISTS Feed (
  -- Key columns
  id SERIAL NOT NULL UNIQUE,
  folder INT NOT NULL,
  PRIMARY KEY (folder, id),
  CONSTRAINT fd_folder FOREIGN KEY (folder) REFERENCES Folder,
  -- Data columns
  title STRING,
  description STRING,
  url STRING,
  text STRING
) INTERLEAVE IN PARENT Folder (folder);

CREATE TABLE IF NOT EXISTS Article (
  -- Key columns
  id SERIAL NOT NULL UNIQUE,
  feed INT NOT NULL,
  folder INT NOT NULL,
  PRIMARY KEY (folder, feed, id),
  CONSTRAINT fk_feed_folder FOREIGN KEY (folder, feed) REFERENCES Feed
) INTERLEAVE IN PARENT Feed (folder, feed);