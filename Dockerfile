FROM ruby:3.2.6

# Устанавливаем зависимости
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    postgresql-client \
    build-essential

WORKDIR /app

# Копируем Gemfile и Gemfile.lock сначала, чтобы использовать кэш
COPY Gemfile* ./

# Устанавливаем гемы
RUN gem install bundler:2.6.9
RUN bundle install

# Копируем остальной код приложения
COPY . .