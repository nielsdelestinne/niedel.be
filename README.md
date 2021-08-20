# Source code of niedel.be

![Build and Deploy](https://github.com/nielsdelestinne/niedel.be/workflows/Build%20and%20Deploy/badge.svg)

Niels Delestinne's blog.
- See the code in action on [niedel.be](https://niedel.be)

## Installation
1. Using Docker, create the image by running: `docker build -t niedel.img .`
2. Create (and start) the container by running: `docker run --name=niedel.container -p 4000:4000/tcp niedel.img`
	- A container in which Jekyll runs in server mode will be created. It will watch for changes, rebuild the site, and provide access through its included web server.
3. Navigate to [http://localhost:4000](http://localhost:4000) to access the website

## Local development
1. Spin up the Jekyll server (development mode) by running: `docker start niedel.container`
2. Navigate to [http://localhost:4000](http://localhost:4000) to access the website
