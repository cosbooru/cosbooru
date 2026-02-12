## Quickstart

### Using Github Codespaces

To launch an Cosbooru instance in your browser:

1. [Create a Github account](https://github.com/signup).
2. Click [Open in Github Codespaces](https://codespaces.new/cosbooru/cosbooru?quickstart=1).
3. Click the `Create new codespace` button.
4. Wait a few minutes for it to launch.

When it's done, you'll have a new Cosbooru instance with a full development environment running in your browser. This way you can try out Cosbooru without installing anything on your computer.

See the [Codespaces section](https://github.com/danbooru/danbooru/wiki/Docker-Guide#user-content-running-in-github-codespaces) in the [Docker Guide](https://github.com/danbooru/danbooru/wiki/Docker-Guide) to learn more.

### Using Docker

Run this to start an Cosbooru instance:

```sh
sh -c "$(curl -sSL https://raw.githubusercontent.com/cosbooru/cosbooru/master/bin/setup)"
```

This will install [Docker Compose](https://docs.docker.com/compose/) and start Cosbooru. When it's done, Cosbooru will be running at http://localhost:3000.

Alternatively, if you already have Docker Compose installed, you can do:

```sh
git clone http://github.com/cosbooru/cosbooru
cd cosbooru
touch .env.local config/danbooru_local_config.rb
sudo docker compose up
```

When you're done, you can run the following to delete everything:

```sh
sudo docker compose down --volumes # Delete all data and images in your Cosbooru instance.
sudo docker image prune            # Clean up all unused Docker images.
rm -rf ~/cosbooru                  # Delete the Cosbooru code.
```

## Installation

See the [Docker Guide](https://github.com/danbooru/danbooru/wiki/Docker-Guide) for more information on running Cosbooru using Docker. This is the recommended way to run Cosbooru.

Alternatively, you may use the [Manual Installation Guide](https://github.com/danbooru/danbooru/wiki/Manual-Installation-Guide) to install Cosbooru without Docker. Manual installation is much more difficult than using Docker, and therefore is not recommended or officially supported.

For help, ask in the [#technical](https://discord.com/channels/1026560538240618547/1029499442329567253) channel on the [Cosbooru Discord](https://discord.gg/VuYvNsagK7), or in the [discussions area](https://github.com/cosbooru/cosbooru/discussions) on Github.

## Services

Danboou depends on a couple of cloud services and several microservices to
implement certain features.


### Google APIs

The following features require a Google Cloud account:

* BigQuery database export

### IQDB Service

IQDB integration is delegated to the [IQDB service](https://github.com/danbooru/iqdb).

### Reportbooru Service

The following features are delegated to the [Reportbooru service](https://github.com/danbooru/reportbooru):

* Missed searches report
* Popular searches report

### Recommender Service

Post recommendations require the [Recommender service](https://github.com/danbooru/recommender).
