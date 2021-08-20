From ruby:2.7.4

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN gem install jekyll bundler

CMD ["./start"]
