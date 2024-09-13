# Use a imagem oficial do Ruby 2.7.4
FROM ruby:2.7.4

# Atualize o gerenciador de pacotes e instale dependências
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configure o diretório de trabalho
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock e instale as gems
COPY Gemfile Gemfile.lock ./

# Instalação do Bundler correto
RUN gem install bundler -v 2.4.22

# Instala as gems no diretório vendor/bundle
RUN bundle install --path vendor/bundle

# Copie o restante do código-fonte da aplicação
COPY . .

# Remova o arquivo PID se existir, e inicie o servidor Rails
CMD ["bash", "-c", "rm -f /app/tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0'"]
