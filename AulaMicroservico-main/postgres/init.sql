-- Criação da tabela de usuários
CREATE TABLE IF NOT EXISTS users (
 id SERIAL PRIMARY KEY,
 username VARCHAR(50) UNIQUE NOT NULL,
 email VARCHAR(100) UNIQUE NOT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Criação da tabela de posts
CREATE TABLE IF NOT EXISTS posts (
 id SERIAL PRIMARY KEY,
 user_id INTEGER REFERENCES users(id),
 title VARCHAR(200) NOT NULL,
 content TEXT,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Inserção de dados de exemplo
INSERT INTO users (username, email) VALUES
 ('usuario_teste', 'teste@exemplo.com'),
 ('admin', 'admin@exemplo.com');