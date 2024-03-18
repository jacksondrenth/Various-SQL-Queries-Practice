CREATE TABLE `player` (
	`player_id` INT(5) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `team` varchar(30) NOT NULL,
  `number` int(3) NOT NULL,
  `name` varchar(50) NOT NULL
);

INSERT IGNORE INTO `player` (team, number, name)
values("Bulls", 24, "Michael Jordan");

UPDATE `player`
set number = 23
where name = 'Michael Jordan';

INSERT INTO player (team, number, name)
VALUES('Lakers', 24, 'Kobe Bryant');
INSERT INTO player (team, number, name)
VALUES('Lakers', 23, 'Lebron James');
# easier and uses on script 
INSERT INTO player (team, number, name)
VALUES('Clippers', 1, 'James Harden'), ("Clippers", 21, 'Kobe Brown');

DELETE FROM player
where player_id = 1;

DELETE FROM player;

TRUNCATE TABLE player; # TABLE is optional

# Descrive or explain shows metadata

SELECT *
FROM player;

INSERT INTO player (team, number, name)
VALUES('Lakers', 24, 'Kobe Bryant'),
('Lakers', 23, 'Lebron James'),
('Clippers', 1, 'James Harden'), 
("Clippers", 21, 'Kobe Brown');