#!/bin/bash
rm -rf db/
rm -rf export/
mkdir export
java -Dtextdb.allow_full_path=true -jar sqltool.jar --inlineRC=url=jdbc:hsqldb:file:db/filedb,password=,user=SA cmd.sql
