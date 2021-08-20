From jekyll/jekyll:4.1.0 

WORKDIR /usr/src/app

COPY . .

RUN chmod -R 777 .

EXPOSE 4000/tcp

ENTRYPOINT jekyll serve
