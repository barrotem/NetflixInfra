# NetflixInfra
NetflixInfra is a simple repository holding Nginx web server configuration files for the NetflixMovieCatalog App.
This repo uses GitHub Actions to perform Continuous Deployment of the stored Nginx files to AWS's EC2 instances.
Doing so, this automates the process of changing Nginx configration files, making it possible to server the NetflixMovieCatalog app with its new configuration, in no time.

## How it works
When pushing to this repository, a GitHub Action (pipeline) is triggered, performing all required tasks to specific EC2 instances on AWS.

## Please note
The deploy script assumes the following :
1. Script it run after .github/workflows/nginx-deploy.yaml was run, meaning all repository content was copied.
2. Destination EC2 instance is already configured as an Nginx web-server, no installations necessary.
3. The script si statically typed, addressing Nginx configuration files with their default names (e.g. nginx.conf).

![logo_image](resources/logo.jpg)

_Bar Rotem,082024_

