CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE home (
    id INT PRIMARY KEY AUTO_INCREMENT,
    street_address VARCHAR(255) UNIQUE NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip VARCHAR(10) NOT NULL,
    sqft float8 NOT NULL,
    beds INT NOT NULL,
    baths INT NOT NULL,
    list_price FLOAT NOT NULL
);

CREATE TABLE user_home_junction (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    home_id INT NOT NULL,
    UNIQUE(user_id, home_id), 
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (home_id) REFERENCES home(id) ON DELETE CASCADE
);

INSERT INTO user (username, email)
SELECT DISTINCT username, email
FROM user_home;

INSERT INTO home (street_address, state, zip, sqft, beds, baths, list_price)
SELECT DISTINCT street_address, state, zip, sqft, beds, baths, list_price
FROM user_home;

INSERT INTO user_home_junction (user_id, home_id)
SELECT u.id, h.id
FROM user_home uh
JOIN user u ON uh.username = u.username
JOIN home h ON uh.street_address = h.street_address;
