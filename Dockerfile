FROM jekyll/jekyll:4.2.2

WORKDIR /srv/jekyll

RUN gem install webrick

COPY Gemfile* ./

RUN bundle install

EXPOSE 4000
EXPOSE 35729

CMD ["jekyll", "serve", "--incremental", "--livereload"]
