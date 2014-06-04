CREATE SCHEMA anzsrc AUTHORIZATION sa;
SET SCHEMA anzsrc;

-- FOR Codes
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

-- SEO Codes
CREATE TEXT TABLE seocodes (sector VARCHAR(255), div VARCHAR(255), grp VARCHAR(255), name VARCHAR(255), code CHAR(6));
SET TABLE seocodes SOURCE "data/seocodes.csv;fs=,;ignore_first=true;quoted=true";
SET TABLE seocodes READONLY TRUE;

CREATE TEXT TABLE seoexport (id VARCHAR(255), code VARCHAR(255), label VARCHAR(255), broader VARCHAR(255), sector VARCHAR(255));
SET TABLE seoexport SOURCE "export/seoexport.csv;fs=,;quoted=true";

INSERT INTO seoexport (id, code, label, sector) (
  SELECT DISTINCT concat('http://purl.org/asc/1297.0/2008/seo/',left(code,2)), left(code,2), div, sector
  FROM seocodes
);

INSERT INTO seoexport (id, code, label, broader, sector) (
  SELECT DISTINCT concat('http://purl.org/asc/1297.0/2008/seo/',left(code,4)), 
    left(code,4), 
    grp, 
    concat('http://purl.org/asc/1297.0/2008/seo/',left(code,2)), sector
  FROM seocodes 
);

INSERT INTO seoexport (id, code, label, broader, sector) (
  SELECT DISTINCT concat('http://purl.org/asc/1297.0/2008/seo/', code), 
    code, 
    name, 
    concat('http://purl.org/asc/1297.0/2008/seo/',left(code,4)), sector
  FROM seocodes
);

COMMIT;