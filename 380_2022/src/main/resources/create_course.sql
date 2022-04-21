CREATE TABLE course (
    course_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    courseNo VARCHAR(20) NOT NULL,
    lectureTitle VARCHAR(50) NOT NULL,
    PRIMARY KEY (course_id)
);

CREATE TABLE course_comment (
    comment_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), 
    courseNo VARCHAR(20) NOT NULL,
    lectureTitle VARCHAR(50) NOT NULL,
    comment VARCHAR(300) NOT NULL,
    userName VARCHAR(50) NOT NULL,
    PRIMARY KEY(comment_id)
);

INSERT INTO course (courseNo, lectureTitle)VALUES ('COMP S380F', 'Web Applications:Design And Development');
INSERT INTO course (courseNo, lectureTitle)VALUES ('COMP S265F', 'Design And Analysis Of Algorithms');
INSERT INTO course_comment(courseNo, lectureTitle, comment, userName) VALUES ('COMPS S380F', 'Web Applications:Design And Development', 'This course so hard', 'mary');
