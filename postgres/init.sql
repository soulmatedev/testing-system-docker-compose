-- Таблица ролей
CREATE TABLE "Role" (
                        "id" serial PRIMARY KEY,
                        "name" VARCHAR
);
-- Таблица аккаунтов
CREATE TABLE "Account" (
                           id SERIAL PRIMARY KEY,
                           login VARCHAR,
                           email VARCHAR UNIQUE NOT NULL,
                           password VARCHAR,
                           name VARCHAR,
                           role INTEGER NULL REFERENCES "Role"("id")
);

CREATE TABLE  "Test" (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(255) NOT NULL,
                         description TEXT,
                         status VARCHAR,
                         questions_count INT,
                         user_id INTEGER NULL REFERENCES "Account"("id")
);

CREATE TABLE "Question" (
                            id SERIAL PRIMARY KEY,
                            text TEXT NOT NULL,
                            type VARCHAR(50) NOT NULL,
                            answers TEXT[],
                            pairs TEXT[]
);

CREATE TABLE "Answer" (
                          id SERIAL PRIMARY KEY,
                          text TEXT NOT NULL,
                          isCorrect BOOLEAN NOT NULL,
                          weight FLOAT NOT NULL DEFAULT 0.0,
                          question_id INT REFERENCES "Question"(id) ON DELETE CASCADE
);

CREATE TABLE "QuestionAnswer" (question_id INT NOT NULL REFERENCES "Question"(id) ON DELETE CASCADE,
                               answer_id INT NOT NULL REFERENCES "Answer"(id) ON DELETE CASCADE,
                               PRIMARY KEY (question_id, answer_id)
);

CREATE TABLE "Pair" (
                        id SERIAL PRIMARY KEY,
                        questionId INT REFERENCES "Question"(id) ON DELETE CASCADE,
                        title TEXT NOT NULL,
                        description TEXT NOT NULL
);

CREATE TABLE "Competency" (
                              id SERIAL  PRIMARY KEY,
                              name VARCHAR NOT NULL,
                              description TEXT
);

CREATE TABLE "AnswerCompetency" (
                                    competency_id INT NOT NULL,
                                    answer_id BIGINT NOT NULL,
                                    PRIMARY KEY (competency_id, answer_id),
                                    FOREIGN KEY (competency_id) REFERENCES "Competency"(id),
                                    FOREIGN KEY (answer_id) REFERENCES "Answer"(id)
);

CREATE TABLE "TestQuestion" (
                                test_id INT NOT NULL REFERENCES "Test"(id) ON DELETE CASCADE,
                                question_id INT NOT NULL REFERENCES "Question"(id) ON DELETE CASCADE,
                                PRIMARY KEY (test_id, question_id)
);

CREATE TABLE "TestResult" (
                              id SERIAL PRIMARY KEY,
                              user_id INT NOT NULL REFERENCES "Account"(id) ON DELETE CASCADE,
                              test_id INT NOT NULL REFERENCES "Test"(id) ON DELETE CASCADE,
                              questions_total INT NOT NULL,
                              correct_answers INT NOT NULL,
                              completed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO "Role"(id, name)
VALUES (0, 'Сотрудник'),
       (1,'Администратор');

INSERT INTO "Account" (login, email, password, name, role)
VALUES ('1234', '1234@mail.ru', '$2a$10$nPfDGCz6u01prtCzMhIWs.QfheP6SD8QEgaRCwkiwo7w7niUpzb/O', '', 1);


