## Changes

Imouto is a fork with an emphasis on small communities. It has some different conventions compared to upstream Danbooru, most of which are configurable, but some enforced. The full list of changes is as follows:

- The user level on signup is now configurable. The new default user level on signup is Contributor.
- The AI tags container is visible by default on the upload and post edit pages.
- The default blacklist has been modified (removed `furry -rating:g`)
- Restored Flash upload functionality.
- The job to retire inactive tag implications and aliases is now togglable. It is now disabled by default.
- Added a config option to enable/disable the tag size and wiki constraints on tag implications. They are now disabled by default.
- Added a config option to toggle post autobanning behaviour. It is now disabled by default.
- Added a config option to disable signups.
- Added a config option to toggle the 2FA nag banner for privileged users. It is now disabled by default.
- Changes have been made to safe mode:
- - No longer blocks all posts not rated General, just posts with the configured blocked tags. Slight changes to user-facing phrasing to reflect that.
- - Added a config option to enable safe mode on signup. Enabled by default.
- Posts have been made more secure:
- - There is now a config option to block all NSFW (rating Q or E) posts for logged-out users. Enabled by default.
- - Attempting to view blocked posts is now completely forbidden.
- - Media assets are no longer visible to logged-out users.
- - Note: None of this is a silver bullet, metadata may still leak in some places.
- Added config options to toggle privacy for:
- - The forum and BURs.
- - Post versions.
- - If enabled, the areas in question will not be visible to logged-out users.
- Fixes:
- - `config.posts_per_page` now properly applies to the Posts page.

## Quickstart

### Using Github Codespaces

To launch a Danbooru instance in your browser:

1. [Create a Github account](https://github.com/signup).
2. Click [Open in Github Codespaces](https://codespaces.new/danbooru/danbooru?quickstart=1).
3. Click the `Create new codespace` button.
4. Wait a few minutes for it to launch.

When it's done, you'll have a new Danbooru instance with a full development environment running in your browser. This way you can try out Danbooru without installing anything on your computer.

See the [Codespaces section](https://github.com/danbooru/danbooru/wiki/Docker-Guide#user-content-running-in-github-codespaces) in the [Docker Guide](https://github.com/danbooru/danbooru/wiki/Docker-Guide) to learn more.

### Using Docker

Run this to start a Danbooru instance:

```sh
sh -c "$(curl -sSL https://raw.githubusercontent.com/danbooru/danbooru/master/bin/setup)"
```

This will install [Docker Compose](https://docs.docker.com/compose/) and start Danbooru. When it's done, Danbooru will be running at http://localhost:3000.

Alternatively, if you already have Docker Compose installed, you can do:

```sh
git clone http://github.com/danbooru/danbooru
cd danbooru
touch .env.local config/danbooru_local_config.rb
sudo docker compose up
```

When you're done, you can run the following to delete everything:

```sh
sudo docker compose down --volumes # Delete all data and images in your Danbooru instance.
sudo docker image prune            # Clean up all unused Docker images.
rm -rf ~/danbooru                  # Delete the Danbooru code.
```

## Installation

See the [Docker Guide](https://github.com/danbooru/danbooru/wiki/Docker-Guide) for more information on running Danbooru using Docker. This is the recommended way to run Danbooru.

Alternatively, you may use the [Manual Installation Guide](https://github.com/danbooru/danbooru/wiki/Manual-Installation-Guide) to install Danbooru without Docker. Manual installation is much more difficult than using Docker, and therefore is not recommended or officially supported.

For help, ask in the [#technical](https://discord.com/channels/310432830138089472/310846683376517121) channel on the [Danbooru Discord](https://discord.gg/danbooru), or in the [discussions area](https://github.com/danbooru/danbooru/discussions) on Github.

## Services

Danboou depends on a couple of cloud services and several microservices to
implement certain features.

### Amazon Web Services

In the production environment, for historical reasons, Danbooru relies on Amazon AWS to send pool/post versions to a SQS queue, and on a separate archives service ([available here](https://github.com/danbooru/archives/)) to extract the versions from that queue and insert them into a database.

The Docker Compose files in this repository come with a preconfigured archives service and an SQS mock using [ElasticMQ](https://github.com/softwaremill/elasticmq), so following the docker tutorial at the start of this file is sufficient to have post/pool versions working for a new instance.

### Google APIs

The following features require a Google Cloud account:

* BigQuery database export

### IQDB Service

IQDB integration is delegated to the [IQDB service](https://github.com/danbooru/iqdb).

### Reportbooru Service

The following features are delegated to the [Reportbooru service](https://github.com/danbooru/reportbooru):

* Post views
* Missed searches report
* Popular searches report

### Recommender Service

Post recommendations require the [Recommender service](https://github.com/danbooru/recommender).
