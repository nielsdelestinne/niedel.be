# Source code of niedel.be

![Build and Deploy](https://github.com/nielsdelestinne/niedel.be/workflows/Build%20and%20Deploy/badge.svg)

Niels Delestinne (niedel) - Website.
- See the code in action on [niedel.be](https://niedel.be)

## Local development
1. Build the Docker image:
   ```
   docker build --load -t niedel-img .
   ```
2. Run the container:
   ```
   docker run --name niedel -v "$PWD:/srv/jekyll" -p 4000:4000/tcp -p 35729:35729/tcp -it niedel-img
   ```
3. Navigate to [http://localhost:4000](http://localhost:4000) to access the website
4. It will watch for changes, rebuild the site, and provide access through its included web server. You can then check the results of changes by reloading http://localhost:4000/ in a browser.
