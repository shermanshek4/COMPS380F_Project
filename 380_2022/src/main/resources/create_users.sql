CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
phonenumber VARCHAR(50) NOT NULL,
fullname VARCHAR(50) NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE user_roles (
    user_role_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_role_id),
    FOREIGN KEY (username) REFERENCES users(username)
);

INSERT INTO users VALUES ('keith', '{noop}keithpw','tst','12345678','keithlee');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_STUDENT');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_LECTURER');

INSERT INTO users VALUES ('john', '{noop}johnpw','tstsss','12345675345438','johnlee');
INSERT INTO user_roles(username, role) VALUES ('john', 'ROLE_LECTURER');

INSERT INTO users VALUES ('mary', '{noop}marypw','tmk','12333345678','marylee');
INSERT INTO user_roles(username, role) VALUES ('mary', 'ROLE_STUDENT');
