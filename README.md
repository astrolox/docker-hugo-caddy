
Hugo and Caddy in Docker
===============================

This is a really simple set of files for building a static site with [Hugo](https://gohugo.io/) and bundling it in to a container with [Caddy](https://caddyserver.com/).

There are other approaches to using Caddy and Hugo, such as the [official example in the Caddy docs](https://caddyserver.com/docs/http.git). However I prefer to have my websites as self contained docker images for various administrative reasons.


How to use
-----------

Place your hugo site in the `src` folder. If you haven't created it then see the [Hugo quick start guide](https://gohugo.io/getting-started/quick-start/) or just run `hugo new site src`. _You could use the provided hugo docker image to perform this step, but I'll leave working out how to do that as an exercise for the reader._

Once you have your Hugo site in `src`, simply build these three docker containers.

```
docker build -t hugo -f Dockerfile-hugo .
docker build -t caddy -f Dockerfile-caddy .
docker build -t mywebsite .
```

You will likely want to customise the [Caddyfile](https://caddyserver.com/docs/http-caddyfile) to enable Letsnecrypt SSL. Do this by simply editing the provided `config/Caddyfile` file and then rebuilding your website container with `docker build -t mywebsite .`

Finally run your web server:

```
docker run --name mywebsite -d --restart=always -p 2015:2015 mywebsite
```

If you have enabled Letsencrypt SSL then you will want to persist the `/root/` folder and expose the standard web ports instead. For example:

```
export LOCALPATH=/root/mywebsite-container-root/
docker run --name mywebsite -d --restart=always -v ${LOCALPATH}:/root/ -p 80:80 -p 443:443 mywebsite
```
