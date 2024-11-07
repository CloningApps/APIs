DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS series;
DROP TABLE IF EXISTS episodes;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS watch_history;
DROP TABLE IF EXISTS favorites;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_premium BOOLEAN DEFAULT FALSE
);

CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year YEAR,
    duration INT,  -- czas trwania w minutach
    genre_id INT,
    description TEXT,
    rating DECIMAL(3, 1),  -- ocena np. 7.5
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE series (
    series_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year YEAR,
    genre_id INT,
    description TEXT,
    rating DECIMAL(3, 1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE episodes (
    episode_id INT AUTO_INCREMENT PRIMARY KEY,
    series_id INT NOT NULL,
    season_number INT NOT NULL,
    episode_number INT NOT NULL,
    title VARCHAR(255),
    duration INT,  -- czas trwania w minutach
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (series_id) REFERENCES series(series_id)
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE watch_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT,
    episode_id INT,
    watch_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id)
);

CREATE TABLE favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT,
    series_id INT,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (series_id) REFERENCES series(series_id)
);