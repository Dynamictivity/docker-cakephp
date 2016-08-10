<?php

/* Initialize connection */
$mysqli = new mysqli(getenv('DB_HOST'), getenv('DB_USERNAME'),
    getenv('DB_DATABASE'), getenv('DB_PASSWORD'));

/* Check connection */
if ($mysqli->connect_errno) {
    printf("Connect failed: %s\n", $mysqli->connect_error);
    exit();
}

/* Create sessions table */
$result = $mysqli->query("CREATE TABLE IF NOT EXISTS sessions (
  id varchar(40) NOT NULL default '',
  data BLOB,
  expires INT(11) NOT NULL,
  PRIMARY KEY  (id)
);");

/* Close connection */
$mysqli->close();

print "### MySQL Sessions Table Created ###";
