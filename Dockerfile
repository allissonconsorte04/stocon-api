# Use a imagem oficial do Ruby 2.7.4
FROM ruby:2.7.4

# Atualize o gerenciador de pacotes e instale dependências
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configure o diretório de trabalho
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock e instale as gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.22

# Use o bundler para instalar as dependências no diretório padrão do contêiner
# Sem a opção --path para evitar problemas de PATH
RUN bundle install

# Copie o restante do código-fonte da aplicação
COPY . .

# Remova o arquivo PID se ele existir, para evitar conflitos na reinicialização
RUN rm -f /app/tmp/pids/server.pid

# Exponha a porta do servidor
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
