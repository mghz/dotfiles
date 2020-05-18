-- sample
--  CREATE DATABASE yourdbname;
--  CREATE USER youruser WITH ENCRYPTED PASSWORD 'yourpass';
--  GRANT ALL PRIVILEGES ON DATABASE yourdbname TO youruser;

-- iris gitea database
CREATE DATABASE iris;
CREATE USER iris WITH ENCRYPTED PASSWORD 'iris';
GRANT ALL PRIVILEGES ON DATABASE iris TO iris;
