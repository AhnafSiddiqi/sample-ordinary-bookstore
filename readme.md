## Overview

## Quick Start
Clone the repo and bundle
    git clone https://github.com/AhnafSiddiqi/sample-ordinary-bookstore.git
    cd sample-ordinary-bookstore
    bundle install

Setting up `database.yml` based on your needs. (Use the default settings if you're not sure what to change)

    cp config/database.yml.sample config/database.yml

    ** CHANGE THE DETAILS BEFORE PROCEEDING 

Create the database and run migrate

    rake db:create db:migrate db:seed

## Testing the app
Run the specs with `rspec`