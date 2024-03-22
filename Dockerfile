# Use a imagem oficial do Ruby 2.7.4
FROM ruby:2.7.4

# Atualize o gerenciador de pacotes e instale dependências
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configure o diretório de trabalho
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock e instale as gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.22
RUN bundle install

# Copie o restante do código-fonte da aplicação
COPY . .

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Inicialize o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
