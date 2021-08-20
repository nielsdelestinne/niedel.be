From ruby:2.7.4-slim

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD["bundle", "exec", "jekyll", "serve"]
