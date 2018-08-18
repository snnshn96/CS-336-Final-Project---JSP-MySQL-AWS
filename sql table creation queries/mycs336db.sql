DROP DATABASE IF EXISTS mycs336db;
CREATE DATABASE mycs336db;
USE mycs336db;

DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS inventories;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS markets;
DROP TABLE IF EXISTS resources;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS makes;


CREATE TABLE users (
	uid			VARCHAR(20) NOT NULL UNIQUE,
    name		VARCHAR(20) NOT NULL,
    pass		VARCHAR(20) NOT NULL,
    gold		INT DEFAULT 100,
    location    INT NOT NULL,
    
    PRIMARY KEY (uid)
);


CREATE TABLE items (
	id			INT,
    name		VARCHAR(50) NOT NULL,
    type		VARCHAR(8) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE inventories (
	uid			VARCHAR(20) NOT NULL,
    item_id		INT,
    quantity	INT,
    PRIMARY KEY (uid, item_id),
    FOREIGN KEY (uid) REFERENCES users (uid),
    FOREIGN KEY (item_id) REFERENCES items (id)
);

CREATE TABLE locations (
	id			INT,
    name		VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE markets (
	id			INT,
    market_type	VARCHAR(8) NOT NULL,
	PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES locations (id)
);

CREATE TABLE market_trades (
	market_id	INT,
    item_id 	INT,
    trade_type	VARCHAR(2),
    price		INT,
    PRIMARY KEY(market_id, item_id, trade_type),
    FOREIGN KEY(market_id) REFERENCES markets(id),
    FOREIGN KEY(item_id) REFERENCES items (id)
);

CREATE TABLE resources (
	id			INT,
    type	VARCHAR(8) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES locations (id)
);

CREATE TABLE recipes (
	id			INT,
    clth_id		INT,
    clth_qntty	INT,
    lthr_id		INT,
    lthr_qntty	INT,
    mtl_id		INT,
    mtl_qntty	INT,
    wd_id		INT,
    wd_qntty	INT,
    PRIMARY KEY (id)
);

CREATE TABLE makes (
	recipe_id	INT,
    item_id		INT,
    PRIMARY KEY (recipe_id, item_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id),
    FOREIGN KEY (item_id) REFERENCES items (id)
);

CREATE TABLE item_found_in (
	item_id			INT,
    location_id		INT,
    PRIMARY KEY (item_id, location_id),
    FOREIGN KEY (location_id) REFERENCES locations (id),
    FOREIGN KEY (item_id) REFERENCES items (id)
);

/* TEST USERS */
INSERT INTO users (uid, name, pass, gold, location) VALUES ("test", "Test User", "test", 9999, 1);



/* Initial Items */
INSERT INTO items (id, name, type) VALUES (1, "cotton", "cloth");
INSERT INTO items (id, name, type) VALUES (2, "silk", "cloth");
INSERT INTO items (id, name, type) VALUES (3, "linen", "cloth");
INSERT INTO items (id, name, type) VALUES (4, "wool", "cloth");
INSERT INTO items (id, name, type) VALUES (5, "polyester", "cloth");
INSERT INTO items (id, name, type) VALUES (6, "flannel", "cloth");

INSERT INTO items (id, name, type) VALUES (7, "artificial", "leather");
INSERT INTO items (id, name, type) VALUES (8, "faux", "leather");
INSERT INTO items (id, name, type) VALUES (9, "suede", "leather");
INSERT INTO items (id, name, type) VALUES (10, "bonded", "leather");
INSERT INTO items (id, name, type) VALUES (11, "aniline", "leather");
INSERT INTO items (id, name, type) VALUES (12, "nubuck", "leather");

INSERT INTO items (id, name, type) VALUES (13, "gold", "metal");
INSERT INTO items (id, name, type) VALUES (14, "iron", "metal");
INSERT INTO items (id, name, type) VALUES (15, "aluminum", "metal");
INSERT INTO items (id, name, type) VALUES (16, "brass", "metal");
INSERT INTO items (id, name, type) VALUES (17, "copper", "metal");
INSERT INTO items (id, name, type) VALUES (18, "titanium", "metal");

INSERT INTO items (id, name, type) VALUES (19, "maple", "wood");
INSERT INTO items (id, name, type) VALUES (20, "walnut", "wood");
INSERT INTO items (id, name, type) VALUES (21, "basswood", "wood");
INSERT INTO items (id, name, type) VALUES (22, "oak", "wood");
INSERT INTO items (id, name, type) VALUES (23, "beech", "wood");
INSERT INTO items (id, name, type) VALUES (24, "aspen", "wood");

INSERT INTO items (id, name, type) VALUES (25, "wooden sword", "weapon");
INSERT INTO items (id, name, type) VALUES (26, "iron axe", "weapon");
INSERT INTO items (id, name, type) VALUES (27, "iron pick", "weapon");
INSERT INTO items (id, name, type) VALUES (28, "titanium axe", "weapon");
INSERT INTO items (id, name, type) VALUES (29, "titanium pick", "weapon");
INSERT INTO items (id, name, type) VALUES (30, "bow", "weapon");
INSERT INTO items (id, name, type) VALUES (31, "five arrows", "weapon");
INSERT INTO items (id, name, type) VALUES (32, "iron sword", "weapon");
INSERT INTO items (id, name, type) VALUES (33, "titanium sword", "weapon");
INSERT INTO items (id, name, type) VALUES (34, "wooden shield", "weapon");
INSERT INTO items (id, name, type) VALUES (35, "reinforced shield", "weapon");
INSERT INTO items (id, name, type) VALUES (36, "leather shoes", "armor");
INSERT INTO items (id, name, type) VALUES (37, "hard leather boots", "armor");
INSERT INTO items (id, name, type) VALUES (38, "hard leather leggings", "armor");
INSERT INTO items (id, name, type) VALUES (39, "hard leather chasis", "armor");
INSERT INTO items (id, name, type) VALUES (40, "hard leather gloves", "armor");
INSERT INTO items (id, name, type) VALUES (41, "hard leather pauldrons", "armor");
INSERT INTO items (id, name, type) VALUES (42, "hard leather helmet", "armor");
INSERT INTO items (id, name, type) VALUES (43, "titanium boots", "armor");
INSERT INTO items (id, name, type) VALUES (44, "titanium leggings", "armor");
INSERT INTO items (id, name, type) VALUES (45, "titanium chasis", "armor");
INSERT INTO items (id, name, type) VALUES (46, "titanium gloves", "armor");
INSERT INTO items (id, name, type) VALUES (47, "titanium pauldrons", "armor");
INSERT INTO items (id, name, type) VALUES (48, "titanium helmet", "armor");
INSERT INTO items (id, name, type) VALUES (49, "linen pants", "armor");
INSERT INTO items (id, name, type) VALUES (50, "linen shirt", "armor");
INSERT INTO items (id, name, type) VALUES (51, "linen gloves", "armor");
INSERT INTO items (id, name, type) VALUES (52, "flannel jacket", "armor");
INSERT INTO items (id, name, type) VALUES (53, "wool hat", "armor");
INSERT INTO items (id, name, type) VALUES (54, "fancy pants", "armor");
INSERT INTO items (id, name, type) VALUES (55, "fancy shirt", "armor");
INSERT INTO items (id, name, type) VALUES (56, "fancy gloves", "armor");
INSERT INTO items (id, name, type) VALUES (57, "fancy jacket", "armor");
INSERT INTO items (id, name, type) VALUES (58, "fancy hat", "armor");
INSERT INTO items (id, name, type) VALUES (59, "single bed", "home");
INSERT INTO items (id, name, type) VALUES (60, "double bed", "home");
INSERT INTO items (id, name, type) VALUES (61, "fancy double bed", "home");
INSERT INTO items (id, name, type) VALUES (62, "wooden door", "home");
INSERT INTO items (id, name, type) VALUES (63, "reinforced door", "home");
INSERT INTO items (id, name, type) VALUES (64, "wooden shelter frame", "home");
INSERT INTO items (id, name, type) VALUES (65, "reinforced shelter frame", "home");
INSERT INTO items (id, name, type) VALUES (66, "titanium shelter frame", "home");
INSERT INTO items (id, name, type) VALUES (67, "basic tent", "home");
INSERT INTO items (id, name, type) VALUES (68, "reinforced tent", "home");
INSERT INTO items (id, name, type) VALUES (69, "wooden chair", "home");
INSERT INTO items (id, name, type) VALUES (70, "fine wooden chair", "home");
INSERT INTO items (id, name, type) VALUES (71, "fancy wooden chair", "home");
INSERT INTO items (id, name, type) VALUES (72, "cushioned chair", "home");
INSERT INTO items (id, name, type) VALUES (73, "fancy cusioned chair", "home");
INSERT INTO items (id, name, type) VALUES (74, "wooden bowl", "home");
INSERT INTO items (id, name, type) VALUES (75, "copper pot", "home");
INSERT INTO items (id, name, type) VALUES (76, "ironcast pot", "home");
INSERT INTO items (id, name, type) VALUES (77, "wooden utensils", "home");
INSERT INTO items (id, name, type) VALUES (78, "aluminum utensils", "home");
INSERT INTO items (id, name, type) VALUES (79, "fancy utensils", "home");

INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (1,null,0,null,0,null,0,23,2);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (2,1,1,12,1,14,2,20,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (3,1,1,12,1,14,2,20,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (4,1,1,12,1,18,2,20,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (5,1,1,12,1,18,2,20,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (6,5,2,12,1,null,0,19,3);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (7,null,0,null,0,14,1,19,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (8,1,1,12,1,14,2,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (9,1,1,12,1,18,2,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (10,null,0,null,0,null,0,19,4);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (11,null,0,12,1,14,1,19,3);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (12,1,1,12,2,null,0,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (13,1,1,10,2,16,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (14,1,1,10,5,16,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (15,1,1,10,5,16,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (16,1,1,10,2,16,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (17,1,1,10,4,16,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (18,1,1,10,2,16,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (19,1,1,10,2,18,2,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (20,1,1,10,5,18,4,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (21,1,1,10,5,18,5,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (22,1,1,10,2,18,2,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (23,1,1,10,2,18,2,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (24,1,1,10,2,18,2,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (25,3,5,null,0,null,0,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (26,3,5,null,0,null,0,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (27,3,2,null,0,null,0,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (28,6,6,null,0,null,0,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (29,4,2,null,0,null,0,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (30,2,5,9,2,13,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (31,2,4,9,1,13,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (32,2,2,9,1,13,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (33,2,6,9,3,13,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (34,2,2,9,1,13,1,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (35,1,15,null,0,16,1,24,12);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (36,1,30,null,0,16,2,24,24);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (37,3,30,null,0,13,2,22,24);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (38,null,0,null,0,16,2,19,8);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (39,null,0,null,0,16,5,20,8);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (40,null,0,null,0,14,2,19,40);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (41,null,0,null,0,14,15,19,36);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (42,null,0,null,0,18,50,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (43,3,25,12,5,null,0,21,2);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (44,3,25,12,20,14,2,21,4);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (45,null,0,null,0,null,0,23,8);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (46,null,0,null,0,14,2,22,8);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (47,null,0,null,0,13,2,19,8);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (48,1,10,null,0,null,0,23,8);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (49,2,15,9,5,13,4,19,8);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (50,null,0,null,0,null,0,22,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (51,null,0,null,0,17,2,22,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (52,null,0,null,0,14,2,22,1);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (53,null,0,null,0,null,0,22,2);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (54,null,0,null,0,15,2,null,0);
INSERT INTO recipes (id, clth_id, clth_qntty, lthr_id, lthr_qntty, mtl_id, mtl_qntty, wd_id, wd_qntty) VALUES (55,null,0,null,0,13,2,22,1);

INSERT INTO makes (recipe_id, item_id) VALUES (1,25);
INSERT INTO makes (recipe_id, item_id) VALUES (2,26);
INSERT INTO makes (recipe_id, item_id) VALUES (3,27);
INSERT INTO makes (recipe_id, item_id) VALUES (4,28);
INSERT INTO makes (recipe_id, item_id) VALUES (5,29);
INSERT INTO makes (recipe_id, item_id) VALUES (6,30);
INSERT INTO makes (recipe_id, item_id) VALUES (7,31);
INSERT INTO makes (recipe_id, item_id) VALUES (8,32);
INSERT INTO makes (recipe_id, item_id) VALUES (9,33);
INSERT INTO makes (recipe_id, item_id) VALUES (10,34);
INSERT INTO makes (recipe_id, item_id) VALUES (11,35);
INSERT INTO makes (recipe_id, item_id) VALUES (12,36);
INSERT INTO makes (recipe_id, item_id) VALUES (13,37);
INSERT INTO makes (recipe_id, item_id) VALUES (14,38);
INSERT INTO makes (recipe_id, item_id) VALUES (15,39);
INSERT INTO makes (recipe_id, item_id) VALUES (16,40);
INSERT INTO makes (recipe_id, item_id) VALUES (17,41);
INSERT INTO makes (recipe_id, item_id) VALUES (18,42);
INSERT INTO makes (recipe_id, item_id) VALUES (19,43);
INSERT INTO makes (recipe_id, item_id) VALUES (20,44);
INSERT INTO makes (recipe_id, item_id) VALUES (21,45);
INSERT INTO makes (recipe_id, item_id) VALUES (22,46);
INSERT INTO makes (recipe_id, item_id) VALUES (23,47);
INSERT INTO makes (recipe_id, item_id) VALUES (24,48);
INSERT INTO makes (recipe_id, item_id) VALUES (25,49);
INSERT INTO makes (recipe_id, item_id) VALUES (26,50);
INSERT INTO makes (recipe_id, item_id) VALUES (27,51);
INSERT INTO makes (recipe_id, item_id) VALUES (28,52);
INSERT INTO makes (recipe_id, item_id) VALUES (29,53);
INSERT INTO makes (recipe_id, item_id) VALUES (30,54);
INSERT INTO makes (recipe_id, item_id) VALUES (31,55);
INSERT INTO makes (recipe_id, item_id) VALUES (32,56);
INSERT INTO makes (recipe_id, item_id) VALUES (33,57);
INSERT INTO makes (recipe_id, item_id) VALUES (34,58);
INSERT INTO makes (recipe_id, item_id) VALUES (35,59);
INSERT INTO makes (recipe_id, item_id) VALUES (36,60);
INSERT INTO makes (recipe_id, item_id) VALUES (37,61);
INSERT INTO makes (recipe_id, item_id) VALUES (38,62);
INSERT INTO makes (recipe_id, item_id) VALUES (39,63);
INSERT INTO makes (recipe_id, item_id) VALUES (40,64);
INSERT INTO makes (recipe_id, item_id) VALUES (41,65);
INSERT INTO makes (recipe_id, item_id) VALUES (42,66);
INSERT INTO makes (recipe_id, item_id) VALUES (43,67);
INSERT INTO makes (recipe_id, item_id) VALUES (44,68);
INSERT INTO makes (recipe_id, item_id) VALUES (45,69);
INSERT INTO makes (recipe_id, item_id) VALUES (46,70);
INSERT INTO makes (recipe_id, item_id) VALUES (47,71);
INSERT INTO makes (recipe_id, item_id) VALUES (48,72);
INSERT INTO makes (recipe_id, item_id) VALUES (49,73);
INSERT INTO makes (recipe_id, item_id) VALUES (50,74);
INSERT INTO makes (recipe_id, item_id) VALUES (51,75);
INSERT INTO makes (recipe_id, item_id) VALUES (52,76);
INSERT INTO makes (recipe_id, item_id) VALUES (53,77);
INSERT INTO makes (recipe_id, item_id) VALUES (54,78);
INSERT INTO makes (recipe_id, item_id) VALUES (55,79);

INSERT INTO locations (id, name) VALUES (1, "North Market (Cloth)");
INSERT INTO locations (id, name) VALUES (2, "East Market (Leather)");
INSERT INTO locations (id, name) VALUES (3, "South Market (Metal)");
INSERT INTO locations (id, name) VALUES (4, "West Market (Wood)");
INSERT INTO locations (id, name) VALUES (5, "Northern Grasslands (Cloth)");
INSERT INTO locations (id, name) VALUES (6, "Eastern Plains (Leather)");
INSERT INTO locations (id, name) VALUES (7, "Southern Quarries (Metal)");
INSERT INTO locations (id, name) VALUES (8, "Western Forests (Wood)");

INSERT INTO markets (id, market_type) VALUES (1, "cloth");
INSERT INTO markets (id, market_type) VALUES (2, "leather");
INSERT INTO markets (id, market_type) VALUES (3, "metal");
INSERT INTO markets (id, market_type) VALUES (4, "wood");

INSERT INTO resources (id, type) VALUES (5, "cloth");
INSERT INTO resources (id, type) VALUES (6, "leather");
INSERT INTO resources (id, type) VALUES (7, "metal");
INSERT INTO resources (id, type) VALUES (8, "wood");

INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,1,"B",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,2,"B",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,3,"B",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,4,"B",3);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,5,"B",7);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,6,"B",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,1,"S",1);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,2,"S",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,3,"S",3);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,4,"S",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,5,"S",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (1,6,"S",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,7,"B",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,8,"B",3);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,9,"B",7);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,10,"B",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,11,"B",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,12,"B",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,7,"S",1);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,8,"S",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,9,"S",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,10,"S",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,11,"S",3);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (2,12,"S",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,13,"B",7);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,14,"B",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,15,"B",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,16,"B",3);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,17,"B",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,18,"B",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,13,"S",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,14,"S",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,15,"S",3);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,16,"S",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,17,"S",1);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (3,18,"S",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,19,"B",7);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,20,"B",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,21,"B",3);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,22,"B",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,23,"B",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,24,"B",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,19,"S",6);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,20,"S",5);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,21,"S",2);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,22,"S",4);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,23,"S",1);
INSERT INTO market_trades (market_id, item_id, trade_type, price) VALUES (4,24,"S",3);


INSERT INTO inventories (uid, item_id, quantity) VALUES ("test", 25, 1);