-----------------------------------
--Creating database
-----------------------------------
USE master


IF DB_ID('witcher') IS NULL
CREATE DATABASE witcher
GO


USE witcher

-----------------------------------
--Deleting tables
-----------------------------------
--IF OBJECT_ID('Limits','U') IS NOT NULL
--DROP TABLE Limits;
IF OBJECT_ID('Heroes','U') IS NOT NULL
DROP TABLE Heroes;
IF OBJECT_ID('Elixirs','U') IS NOT NULL
DROP TABLE Elixirs;
IF OBJECT_ID('Bombs','U') IS NOT NULL
DROP TABLE Bombs;
IF OBJECT_ID('Oils','U') IS NOT NULL
DROP TABLE Oils;
IF OBJECT_ID('Meals','U') IS NOT NULL
DROP TABLE Meals;
IF OBJECT_ID('Silver_weapons','U') IS NOT NULL
DROP TABLE Silver_weapons;
IF OBJECT_ID('Armors','U') IS NOT NULL
DROP TABLE Armors;


-----------------------------------
--Creating tables
-----------------------------------
--IF OBJECT_ID('Limits','U') IS NULL
--CREATE TABLE Limits (
--	equipment_lvl_lim	INT NOT NULL UNIQUE CHECK (equipment_lvl_lim <= 51),
--	hero_lvl_lim		INT NOT NULL UNIQUE CHECK (hero_lvl_lim <= 81),
--	damage_lim			INT NOT NULL UNIQUE CHECK (damage_lim <= 499),

--	);
--GO

IF OBJECT_ID('Armors','U') IS NULL
CREATE TABLE Armors (
	armor		VARCHAR(50) NOT NULL PRIMARY KEY,
	type		VARCHAR(20) NOT NULL DEFAULT 'Light',
	rarity		VARCHAR(20) NOT NULL DEFAULT 'Magic Item',
	level		INT NOT NULL CHECK (level <= 51),
	state		INT CHECK (state <= 100 AND state >= 0),
	AR			INT NOT NULL CHECK (AR <= 501),
	glyph_slots	INT CHECK (glyph_slots <= 3 AND glyph_slots >= 0),
	location	VARCHAR(255) NOT NULL DEFAULT 'Purchased from Willis',

	);
GO

IF OBJECT_ID('Silver_weapons','U') IS NULL
CREATE TABLE Silver_weapons (
	weapon		VARCHAR(50) NOT NULL PRIMARY KEY,
	rarity		VARCHAR(20) NOT NULL DEFAULT 'Magic Item',
	level		INT NOT NULL CHECK (level <= 51),
	damage		INT NOT NULL CHECK (damage <= 499),
	rune_slots	INT DEFAULT 0 CHECK (rune_slots <= 3 AND rune_slots >= 0),

	);
GO

IF OBJECT_ID('Elixirs','U') IS NULL
CREATE TABLE Elixirs (
	elixir		VARCHAR(50) NOT NULL PRIMARY KEY,
	duration	INT NOT NULL,
	toxicity	INT,
	doses		INT NOT NULL,

	);
GO

IF OBJECT_ID('Bombs','U') IS NULL
CREATE TABLE Bombs (
	b_id		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	bomb		VARCHAR(50) NOT NULL,
	effect		VARCHAR(255) NOT NULL,
	damage		INT,
	duration	INT,
	charges		INT NOT NULL,
	ingredients	VARCHAR(255) NOT NULL,

	);
GO

IF OBJECT_ID('Oils','U') IS NULL
CREATE TABLE Oils (
	oil_id			INT NOT NULL IDENTITY(1,1),
	oil				VARCHAR(50) NOT NULL,
	buff			INT NOT NULL,
	target			VARCHAR(100) NOT NULL PRIMARY KEY,
	charges			INT NOT NULL,
	basic_ingr		VARCHAR(255) NOT NULL DEFAULT 'Dog Tallow',
	aux_ingr		VARCHAR(255) NOT NULL,

	);
GO

IF OBJECT_ID('Meals','U') IS NULL
CREATE TABLE Meals (
	m_id		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	meal		VARCHAR(50) NOT NULL,
	effect		INT NOT NULL,
	duration	INT,
	price		INT,

	);
GO

IF OBJECT_ID('Heroes','U') IS NULL
CREATE TABLE Heroes (
	h_id			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	hero			VARCHAR(50) NOT NULL,
	level			INT NOT NULL CHECK (level <= 81),
	silver_weapon	VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES Silver_weapons(weapon),
	armor			VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES Armors(armor),
	delicacy		INT NOT NULL FOREIGN KEY REFERENCES Meals(m_id),
	imunity			VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES Oils(target),
	elixir			VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES Elixirs(elixir),
	bomb_id			INT NOT NULL FOREIGN KEY REFERENCES Bombs(b_ID),

	);
GO

-----------------------------------
--Inserting elements
-----------------------------------
INSERT INTO
Bombs (bomb, effect, damage, duration, charges, ingredients)
VALUES
('Dancing Star', 'Produces a fiery explosion that can cause nearby opponents to start burning. Destroys monster nests', 100, 4, 2, '1x Saltpeter 2x Sulfur'),
('Enhanced Dancing Star', 'Produces a fiery explosion that can cause nearby opponents to start burning. Destroys monster nests', 100, 7, 3, '1x Stammelford`s Dust 1x Dancing Star 1x Phosphorus 1x Sulfur 1x Sewant Mushrooms 1x Hellebore Petals 1x Nostrix'),
('Superior Dancing Star', 'Produces a fiery explosion that can cause nearby opponents to start burning. Destroys monster nests', 100, 10, 4, '1x Alchemists` Powder 1x Enhanced Dancing Star 2x Phosphorus 2x Sulfur 2x Sewant Mushrooms 2x Nostrix 1x Nigredo'),
('Devil`s Puffball', 'Releases a cloud of poison when detonated', 100, 10, 2, '1x Saltpeter 2x Sewant Mushrooms'),
('Enhanced Devil`s Puffball', 'Releases a cloud of poison when detonated', 100, 30, 3, '1x Stammelford`s Dust 1x Devil`s Puffball 1x Calcium Equum 1x Endrega Heart 1x Sewant Mushrooms 1x Ginatia Petals 1x Green Mold'),
('Superior Devil`s Puffball', 'Releases a cloud of poison when detonated', 100, 30, 4, '1x Alchemists` Powder 1x Enhanced Devil`s Puffball 2x Calcium Equum 2x Endrega Heart 2x Sewant Mushrooms 2x Ginatia Petals 1x Rebis'),
('Dimeritium Bomb', 'Releases a cloud of dimeritium slivers that block magic and monsters` magic abilities', 0, 15, 2, '5x Saltpeter 2x Optima Mater'),
('Enhanced Dimeritium Bomb', 'Releases a cloud of dimeritium slivers that block magic and monsters` magic abilities', 0, 30, 3, '1x Stammelford`s Dust 1x Dimeritium Bomb 1x Optima Mater 1x Powdered Pearl 1x Blowball 1x Ginatia Petals 1x Bloodmoss'),
('Superior Dimeritium Bomb', 'Releases a cloud of dimeritium slivers that block magic and monsters` magic abilities', 0, 30, 4, '1x Alchemists` Powder 1x Enhanced Dimeritium Bomb 2x Optima Mater 2x Powdered Pearl 2x Puffball 2x Bloodmoss 1x Nigredo'),
('Dragon`s Dream', 'Releases a cloud of gas that explodes when ignited', 300, 15, 2, '1x Saltpeter 2x Phosphorus'),
('Enhanced Dragon`s Dream', 'Releases a cloud of gas that explodes when ignited', 400, 30, 3, '1x Stammelford`s Dust 1x Dragon`s Dream 1x Phosphorus 1x Optima Mater 1x Mistletoe 1x Allspice 1x Bryonia'),
('Superior Dragon`s Dream', 'Releases a cloud of gas that explodes when ignited', 400, 30, 4, '1x Alchemists` Powder 1x Enhanced Dragon`s Dream 2x Phosphorus 2x Optima Mater 2x Allspice 2x Bryonia 1x Aether'),
('Grapeshot', 'Inflicts shrapnel damage to foes within its explosion radius. Deals a small amount of fire damage. Destroys monster nests', 350, 0, 2, '2x Saltpeter 2x Calcium Equum'),
('Samum', 'Blinds opponents within its explosion radius. Destroys monster nests', 0, 4, 2, '1x Saltpeter 2x Celandine'),
('Moon Dust', 'Contains silver splinters that temporarily prevent monsters from transforming', 0, 20, 2, '1x Saltpeter 2x Quicksilver Solution'),
('Northern Wind', 'Freezes foes. Blows landed on frozen foes deal additional damage', 0, 4, 2, '1x Saltpeter 1x Ducal Water 1x Powdered Pearl 2x Allspice');

INSERT INTO
Elixirs (elixir, duration, toxicity, doses)
VALUES
('Black Blood', 30, 15, 3),
('Enhanced Black Blood', 45, 15, 4),
('Superior Black Blood', 60, 15, 5),
('Blizzard', 15, 25 ,2),
('Enhanced Blizzard', 20, 25, 3),
('Superior Blizzard', 30, 25, 4),
('Cat', 600, 15, 3),
('Full Moon', 60, 25, 1),
('Golden Oriole', 60, 20, 1),
('Maribor Forest', 30, 20, 1),
('Petri’s Philter', 30, 25, 1),
('Swallow', 20, 20, 1),
('Tawny Owl', 30, 20, 1),
('Thunderbolt' , 30, 25, 1),
('Killer Whale', 180, 15, 1),
('Drowner Pheromones', 90, 15, 1),
('Potion of Clearance', 9999, 9999, 1);

INSERT INTO
Oils (oil, buff, target, charges, basic_ingr, aux_ingr)
VALUES
('Beast Oil', 10, 'Beasts', 20, DEFAULT, 'Wolf`s liver'),
('Cursed Oil', 10, 'Cursed Ones', 20, DEFAULT, 'Wolfsbane'),
('Draconid Oil', 10, 'Draconids', 20, DEFAULT, 'Ergot Seeds'),
('Elementa Oil', 10, 'Elementa', 20, DEFAULT, 'Puffball'),
('Hanged Man`s Venom', 10, 'Humans and Nonhumans', 20, DEFAULT, 'Arenaria'),
('Hybrid Oil', 10, 'Hybrids', 20, DEFAULT, 'White Myrtle Petals'),
('Insectoid Oil', 10, 'Insectoids', 20, DEFAULT, 'Ranogrin'),
('Necrophage Oil', 10, 'Necrophages', 20, DEFAULT, 'Blowball'),
('Ogroid Oil', 10, 'Ogroids', 20, 'Bear Fat', 'Ginatia Petals'),
('Relict Oil', 10, 'Relicts', 20, DEFAULT, 'Mistletoe'),
('Specter Oil', 10, 'Specters', 20, 'Bear Fat', 'Arenaria'),
('Vampire Oil', 10, 'Vampires', 20, DEFAULT, 'Ducal Water');

INSERT INTO 
Meals (meal, effect, duration, price)
VALUES
('Apple', 50, 5, 5),
('Apple juice', 80, 10, 23),
('Baguette with Camembert', 50, 10, 13),
('Baguette with Fish Pâté', 50, 10, 17),
('BakedApple', 50, 10, 29),
('Baked Potato', 50, 10, NULL),
('Banana', 50, 10, 13),
('Blueberries', 50, 5, 4),
('Bread', 50, 5, 9),
('Brioche', 50, 5, 5),
('Butter', 50, 10, 5),
('Cake', 100, NULL, 0),
('Cheese', 50, 10, 34),
('Chicken Leg', 50, 10, 31),
('Chicken Sandwich', 80, 10, 16),
('Chicken Liver Pate', 50, 10, 11),
('Chocolate Souffle', 50, 5, 3),
('Cucumber', 50, 5, 5),
('Dried Fish', 50, 10, 34),
('Dried Fruit', 50, 10, 23),
('Dried fruit and nuts', 80, 10, 23),
('Duck Confit', 80, 10, 13),
('Dumpling', 50, 5, 1),
('Egg', 50, 5, 6),
('Exquisite Honey', 80, 10, 55),
('Fish', 80, 10, 24),
('Fish Tart', 50, 10, 38),
('Flamiche', 50, 10, 3),
('Fondue', 80, 10, 16),
('Fried meat', 80, 10, 38),
('Goat`s milk', 50, 10, 14),
('Grapes', 50, 10, 6);

INSERT INTO
Silver_weapons (weapon, level, rarity, damage, rune_slots)
VALUES
('Serpentine Silver Sword', 1, 'Withcer Gear',  125, DEFAULT),
('Griffin Silver Sword', 11, 'Withcer Gear', 180, DEFAULT),
('Disglair', 12, DEFAULT, 215, 3),
('Gven`el', 13, DEFAULT, 225, 1),
('Feline Silver Sword', 17, 'Withcer Gear', 240, DEFAULT),
('Mastercrfated Silver Sword', 16, DEFAULT, 250, 2),
('Griffin Silver Sword Enchanced', 18, 'Withcer Gear', 250, DEFAULT),
('Ursine Silver Sword', 20, 'Withcer Gear', 270, 3),
('Eirlithrad', 18, DEFAULT, 275, 1),
('Feline Silver Sword Enchanced', 23, 'Withcer Gear', 300, DEFAULT),
('Ursine Silver Sword Enhanced', 25, 'Witcher Gear', 320, 2),
('Tor`haerne', 23, DEFAULT, 325, DEFAULT),
('Torlunn', 23, DEFAULT, 325, 3),
('Griffin Silver Sword Superior', 26, 'Witcher Gear', 330, 2),
('The Tamer', 24, DEFAULT, 325, 1),
('An`ferthe', 26, DEFAULT, 355, DEFAULT),
('Melltith', 26, DEFAULT, 355, 3),
('The Digger', 26, DEFAULT, 355, 1),
('Feline Silver Sword Superior', 29, 'Witcher Gear', 360, 2),
('Ursine Silver Sword Superior', 30, 'Witcher Gear', 370, 3),
('Weeper', 31, 'Relic Item', 410, 1),
('Feline Silver Sword Mastercrafted', 34, 'Witcher Gear', 410, 2),
('Griffin Silver Sword Mastercrafted', 34, 'Witcher Gear', 410, 2),
('Ursine Silver Sword Mastercrafted', 34, 'Witcher Gear', 415, 3),
('Steiger', 37, DEFAULT, 465, 2),
('Faustino', 37, DEFAULT, 465, 1),
('Harpy', 37, 'Relic Item', 465, 3);

INSERT INTO
Armors (armor, level, state, rarity, AR, glyph_slots, location)
VALUES
('Warrior`s Leather Jacket', 1, 34, 'Witcher Gear', 30, 0, 'Unlocked from the start'),
('Cidarian Gambeson', 1, 56, DEFAULT, 32, 0, DEFAULT),
('Skellige Gambeson', 2, 98, DEFAULT, 38, 0, DEFAULT),
('Kaedweni Gambeson', 3, 13, DEFAULT, 42, 1, DEFAULT),
('Spikeroog Aketon', 5, 34, DEFAULT, 54, 1, '??'),
('Verden Archer`s Gambeson', 7, 69, DEFAULT, 62, 0, '??'),
('Bounty Hunter`s Gambeson', 8, 71, DEFAULT, 67, 1, 'Velen, chest near a Nekker monster den'),
('Ard Skellig Aketon', 13, 28, DEFAULT, 92, 1, 'Chest near the Monster Nest northwest of Hanged Man`s Tree'),
('Feline Armor', 17, 24, 'Witcher Gear', 105, 0, 'In a Cave northwest of Electors Square'),
('Enhanced Feline Armor', 23, 80, 'Witcher Gear',  135, 0, 'Aeramas` Abandoned Manor'),
('Shiadhal`s Armor', 24, 5, 'Relic Item', 150, 0, 'Hidden Treasure south of Duen Hen'), 
('Superior Feline Armor', 29, 75, 'Witcher Gear', 165, 0, 'Located in a chest west of Dragonslayer`s Grotto guarded by an Earth Elemental'),
('Mastercrafted Feline Armor', 34, 47, 'Witcher Gear', 190, 0, 'Monster Den south of Trottheim');

INSERT INTO
Heroes (hero, level, silver_weapon, armor, delicacy, imunity, elixir, bomb_id)
VALUES
('Geralt of Rivia', 1, 'Gven`el', 'Cidarian Gambeson', 4, 'Elementa', 'Drowner Pheromones', 12),
('Cirilla Fiona Elen Riannon', 20, 'Griffin Silver Sword Enchanced', 'Ard Skellig Aketon', 21, 'Beasts', 'Full Moon',2),
('Yennefer of Vengerberg', 60, 'Feline Silver Sword Enchanced', 'Mastercrafted Feline Armor', 13, 'Vampires', 'Potion of Clearance', 7),
('Triss Merigold', 38, 'Mastercrfated Silver Sword', 'Superior Feline Armor', 11, 'Necrophages', 'Swallow', 11);

-----------------------------------
--Tests
-----------------------------------
--SELECT * FROM Silver_weapon
--ORDER BY damage
--SELECT * FROM ARMOR
--ORDER BY AR
--SELECT * FROM Food
--ORDER BY effect DESC
--SELECT * FROM Oils
--SELECT * FROM Elixirs
--SELECT * FROM Bombs
--SELECT * FROM Heroes

-----------------------------------
--Views (Deleting/Creating)
-----------------------------------
IF OBJECT_ID('Best_meal', 'V') IS NOT NULL
DROP VIEW Best_meal
GO

IF OBJECT_ID('Broken_armor', 'V') IS NOT NULL
DROP VIEW Broken_armor
GO

IF OBJECT_ID('Master_weapon_dmg', 'V') IS NOT NULL
DROP VIEW Master_weapon_dmg
GO

IF OBJECT_ID('Hero_dmg', 'V') IS NOT NULL
DROP VIEW Hero_dmg
GO

-----------------------------------
CREATE VIEW Best_meal AS (
SELECT TOP 100 percent f.meal, (f.effect * f.duration) AS Taste 
FROM Meals AS f
)
GO

CREATE VIEW Broken_armor AS (
SELECT armor, state
FROM Armors
WHERE state < 50
)
GO

CREATE VIEW Master_weapon_dmg AS (
SELECT * FROM Silver_weapons
WHERE weapon LIKE '%Mastercrafted%'
)
GO

CREATE VIEW Hero_dmg AS (
SELECT h.hero, Silver_weapons.damage FROM Heroes AS h
INNER JOIN Silver_weapons ON h.silver_weapon = Silver_weapons.weapon
)
GO

-----------------------------------
--Procedures (Deleting/Creating)
-----------------------------------
IF OBJECT_ID('Weak_points', 'P') IS NOT NULL
DROP PROCEDURE Weak_points
GO

IF OBJECT_ID('Decision', 'P') IS NOT NULL
DROP PROCEDURE Decision
GO

-----------------------------------
CREATE PROCEDURE Weak_points (
@monster_name VARCHAR (50)
) AS (
SELECT @monster_name AS m_name, aux_ingr AS weak_point
FROM Oils
WHERE @monster_name = target
)
GO

CREATE PROCEDURE Decision (
@hero_name VARCHAR (50),
@monster_power FLOAT
) AS (
SELECT @hero_name AS Hero, Armors.state AS condition, Armors.level AS amplifier, @monster_power AS Power_withstanded FROM Heroes AS h
INNER JOIN Armors ON h.armor = Armors.armor
WHERE @hero_name = h.hero AND (@monster_power * ((100.0 - Armors.state)/100) / ((100.0 + Armors.level)/100)) < 100
)
GO

-----------------------------------
--Reports (Views/Procedures)
-----------------------------------
PRINT 'The tastiest delicacy is: '
SELECT TOP 1 * FROM Best_meal
ORDER BY Taste DESC

PRINT 'The most powerfull silver swords: '
SELECT * FROM Master_weapon_dmg
ORDER BY damage DESC

PRINT 'Heroes`s powers: '
SELECT * FROM Hero_dmg

PRINT 'U really need to fix these immediately: '
SELECT TOP 4 * FROM Broken_armor
ORDER BY state ASC

-----------------------------------
PRINT 'Weak points: '
EXEC Weak_points 'Necrophages'

PRINT 'Decision: '
EXEC Decision 'Geralt of Rivia', 220

-----------------------------------
--Deleting database
-----------------------------------
USE master


IF DB_ID('witcher') IS NOT NULL
DROP DATABASE witcher
