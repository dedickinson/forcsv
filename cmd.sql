CREATE SCHEMA anzsrc AUTHORIZATION sa;
SET SCHEMA anzsrc;

CREATE TEXT TABLE forcodes (div VARCHAR(255), grp VARCHAR(255), name VARCHAR(255), code CHAR(6));
SET TABLE forcodes SOURCE "data/forcodes.csv;fs=,;ignore_first=true;quoted=true";
SET TABLE forcodes READONLY TRUE;

CREATE TEXT TABLE forexport (id VARCHAR(255), code VARCHAR(255), label VARCHAR(255), broader VARCHAR(255));
SET TABLE forexport SOURCE "export/forcodes.csv;fs=,;quoted=true";

INSERT INTO forexport (id, code, label) (
  SELECT DISTINCT concat('http://purl.org/asc/1297.0/2008/for/',left(code,2)), left(code,2), div 
  FROM forcodes
);

INSERT INTO forexport (id, code, label, broader) (
  SELECT DISTINCT concat('http://purl.org/asc/1297.0/2008/for/',left(code,4)), 
    left(code,4), 
    grp, 
    concat('http://purl.org/asc/1297.0/2008/for/',left(code,2))
  FROM forcodes 
);

INSERT INTO forexport (id, code, label, broader) (
  SELECT DISTINCT concat('http://purl.org/asc/1297.0/2008/for/', code), 
    code, 
    name, 
    concat('http://purl.org/asc/1297.0/2008/for/',left(code,4))
  FROM forcodes
);

COMMIT;
