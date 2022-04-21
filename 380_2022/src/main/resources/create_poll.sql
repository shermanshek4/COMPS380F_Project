CREATE TABLE pollCollection (
    pollCol_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    userName VARCHAR(50) NOT NULL,
    question VARCHAR(200) NOT NULL,
    answer VARCHAR(200) NOT NULL,
    PRIMARY KEY (pollCol_id)
);

CREATE TABLE poll (
    poll_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    question VARCHAR(200) NOT NULL,
    opt1 VARCHAR(200) NOT NULL,
    opt2 VARCHAR(200) NOT NULL,
    opt3 VARCHAR(200) NOT NULL,
    opt4 VARCHAR(200) NOT NULL,
    PRIMARY KEY (poll_id)
);


INSERT INTO poll (question, opt1, opt2, opt3, opt4) VALUES ('Who is the most handsome?', 'Woody', 'Keith', 'Kevin', 'Paul Lam');
INSERT INTO pollCollection (userName, question, answer)VALUES ('mary', 'Who is the most handsome?', 'Woody');
