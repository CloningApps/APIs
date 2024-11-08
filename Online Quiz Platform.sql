-- Usuwanie tabel, jeśli istnieją
DROP TABLE IF EXISTS `quizzes`;
DROP TABLE IF EXISTS `questions`;
DROP TABLE IF EXISTS `options`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `results`;

-- Tabela 'quizzes' przechowująca informacje o quizach
CREATE TABLE `quizzes` (
    `quiz_id` INT PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela 'questions' przechowująca pytania powiązane z quizami
CREATE TABLE `questions` (
    `question_id` INT PRIMARY KEY AUTO_INCREMENT,
    `quiz_id` INT,
    `question_text` TEXT NOT NULL,
    FOREIGN KEY (`quiz_id`) REFERENCES `quizzes`(`quiz_id`) ON DELETE CASCADE
);

-- Tabela 'options' przechowująca opcje odpowiedzi dla pytań
CREATE TABLE `options` (
    `option_id` INT PRIMARY KEY AUTO_INCREMENT,
    `question_id` INT,
    `option_text` VARCHAR(255) NOT NULL,
    `is_correct` BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (`question_id`) REFERENCES `questions`(`question_id`) ON DELETE CASCADE
);

-- Tabela 'users' przechowująca dane użytkowników
CREATE TABLE `users` (
    `user_id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(50) UNIQUE NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela 'results' przechowująca wyniki użytkowników w quizach
CREATE TABLE `results` (
    `result_id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT,
    `quiz_id` INT,
    `score` INT,
    `completed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`quiz_id`) REFERENCES `quizzes`(`quiz_id`) ON DELETE CASCADE
);