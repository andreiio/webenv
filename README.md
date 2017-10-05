# webenv

Dockerized LAMP stack local development environment with https & wildcard subdomains. Uses [webenv-httpd](https://github.com/andreiio/webenv-httpd) and [webenv-php](https://github.com/andreiio/webenv-php). Built for and tested on macOS.

## Getting started

```
$ git clone git@github.com:andreiio/webenv.git
$ cd webenv
$ cp .env.example .env
$ sudo ./resolver.sh
$ docker-compose up -d
```

That easy! Well, maybe you should edit the .env file before.


### Directory structure

```
├── docker-compose.yml
├── mnt
│   ├── httpd
│   │   ├── config
│   │   │   ├── httpd.conf
│   │   │   ├── sites
│   │   │   │   └── default.conf
│   │   │   └── ssl
│   │   │       ├── example.domain.crt
│   │   │       └── example.domain.key
│   │   └── www
│   │       ├── sub1.example.domain (user-created dir or symlink)
│   │       ├── sub2.example.domain (user-created dir or symlink)
│   │       └── example.domain (pre-populated)
│   └── mariadb
│       └── ...
└── resolver.sh
```

### Wildcard SSL certificate
This is [generated on runtime](https://github.com/andreiio/webenv-httpd/blob/master/root/init.sh#L24), assuming there's no matching certificate already present. It can be replaced with any other crt/key pair or added to your trusted

### 1:1 directory mapping

If you don't want to maintain multiple copies of your code (_and who does, really?_), you can map your projects folder to the containers. Assuming you're keeping all your work in `~/Projects`, add the following volumes to your [`docker-compose.yml`](docker-compose.yml). Make sure you change it for both apache and php, otherwise you might run into issues later on.

```yml
version: '3'
services:
    httpd:
        ...
        volumes:
            ...
            - $HOME/Projects:$HOME/Projects
    php:
        ...
        volumes:
            ...
            - $HOME/Projects:$HOME/Projects
    ...
```

This allows you to symlink projects to their respective `/www` path directly from the host, without having to bash your way into the containers every time you want to make a change. This also works wonders for projects that don't server their content from their root.


