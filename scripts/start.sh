#!/bin/sh

# Porta padrão
PORT=${PORT:-3000}

# Função pra checar se a porta está ocupada
is_port_in_use() {
  nc -z localhost $1 >/dev/null 2>&1
}

# Incrementa se a porta estiver ocupada
while is_port_in_use $PORT; do
  echo "⚠️ Porta $PORT já está em uso, tentando próxima..."
  PORT=$((PORT+1))
done

echo "✅ Usando porta $PORT"
export PORT

# Se DATABASE_URL não estiver definida, usa padrão local
if [ -z "$DATABASE_URL" ]; then
  echo "📝 Usando configuração local do banco"
  echo "PORT=$PORT" > .env
  echo "DATABASE_URL=postgresql://user:password@db:5432/minha_api?schema=public" >> .env
  DB_HOST="db"
  DB_PORT="5432"
else
  echo "📝 Usando DATABASE_URL do ambiente"
  echo "PORT=$PORT" > .env
  echo "DATABASE_URL=$DATABASE_URL" >> .env
  # Extrai host e porta da DATABASE_URL para o health check
  DB_HOST=$(echo $DATABASE_URL | sed -n 's/.*@\([^:]*\):.*/\1/p')
  DB_PORT=$(echo $DATABASE_URL | sed -n 's/.*:\([0-9]*\)\/.*/\1/p')
fi

# Espera o PostgreSQL subir
echo "⏳ Aguardando o banco de dados inicializar..."
until nc -z $DB_HOST $DB_PORT; do
  echo "⏳ Ainda aguardando o PostgreSQL..."
  sleep 2
done

echo "✅ Banco de dados pronto!"

# Executa migrações Prisma (garante caminho fixo)
echo "🚀 Executando migrações do Prisma..."
npx prisma migrate deploy --schema=./prisma/schema.prisma

# Inicia o servidor Node
echo "🚀 Iniciando aplicação Node.js na porta $PORT..."
node src/server.js

