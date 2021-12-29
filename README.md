# Rack App With Database
Another small Rack app for testing. This one, however, is intended to use a
datastore of some type (postgres here) in order to prove slightly more rigorous
test cases.

# Setup
* `bundle install`
* `rbenv local 2.7.2`
  * The project defines Ruby 2.7.2 and rbenv is my manager of choice

# Running Locally
* `rackup --host 0.0.0.0 -p 5000`

# Docker
This app has been containerized with Docker with basic, default settings.

## Building an image
1. `docker build -t basic .`
  * This creates an image tagged "basic" from the local directory

## Running the Docker image
1. `docker run -p 5000:5000 basic`
  * This runs the image mapping the local port 5000 to the image port 5000 for
    the image tagged as "basic"

## Making a request
`curl localhost:5000`
