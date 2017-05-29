# Blorg

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `(cd assets && npm install)`
  * Compile e4 files with `make`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

###Docker Swarm for Development
  * sudo mkdir -p /var/vol/blorg-dev/postgres/data
  * sudo chown -R <you>:<you> /var/vol/blorg-dev/postgres/data
  * make blorg-dev # Deploys swarm
  * make bash-dev  # Executes bash in web service
    * make init
    * exit
  Now goto <YourIP>:4000 on your host machine

  * make attach-dev #See mix log

  You can edit the files in host machine to see the changes while the development swarm is working. Call make after editing e4 files.

##Docker Swarm for Production
  * sudo mkdir -p /var/vol/blorg-prod/postgres/data
  * sudo chown -R <you>:<you> /var/vol/blorg-prod/postgres/data
  * make blorg-prod # Deploys swarm
  * make bash-prod
    * make init
    * exit
  Now goto <YourIP>:80 on your host machine

  * make attach-prod #See mix log


##make
 * (default): Compiles elm app
 * docker: Rebuilds docker images
 * blorg-dev: Deploys development stack
 * blorg-prod: Deploys production stack



