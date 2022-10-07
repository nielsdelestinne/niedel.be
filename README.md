# Source code of niedel.be

![Build and Deploy](https://github.com/nielsdelestinne/niedel.be/workflows/Build%20and%20Deploy/badge.svg)

Niels Delestinne's blog.
- See the code in action on [niedel.be](https://niedel.be)

## Local development
1. Spin up the Jekyll server (development mode) by running the following docker command:
   - Windows: `docker run --rm -v "<absolute-path>:/srv/jekyll" -p 4000:4000/tcp -p 35729:35729/tcp -it jekyll/jekyll:4.2.0 jekyll serve --incremental --livereload`
     - E.g. `docker run --rm -v "C:/Users/niels/repos/niedel.be:/srv/jekyll" -p 4000:4000/tcp -p 35729:35729/tcp -it jekyll/jekyll:4.2.0 jekyll serve --incremental --livereload`
   - Linux: `docker run --rm -v "$PWD:/srv/jekyll" -p 4000:4000/tcp -p 35729:35729/tcp -it jekyll/jekyll:4.2.0 jekyll serve --incremental --livereload`
2. Navigate to [http://localhost:4000](http://localhost:4000) to access the website
3. It will watch for changes, rebuild the site, and provide access through its included web server. You can then check the results of changes by reloading http://localhost:4000/ in a browser.