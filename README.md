# btcpayserver-testing
A collection of scripts to automate the deployment for testing btcpayserver

## Prequisits
* Install [Virtualbox](https://www.virtualbox.org) and [Vagrant](https://www.vagrantup.com/) on your machine.
* Ensure you have a minimum of 40 GB Diskspace and 4 GB RAM and 4 Cores for the VM.

## Steps for local testing
* Open a Terminal
* Clone this repo
* cd into the repo
* run `vagrant up` or `BTCPAY_BRANCH=[your-branch-of-btcpayserver-repo] vagrant up`
* after vagrant finishes, open [localhost:8080](http://localhost:8080)

## TODO
* enable btcpayserver-docker to docker-compose --build instead of just "up" using the src directory instead of the released image
* fix the redirect issue after registration it sends you to localhost/login instead of localhost:8080/login (strange)