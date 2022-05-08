# btcpayserver-testing
A collection of scripts to automate the deployment for testing btcpayserver

## Prequisits
* Install [Virtualbox](https://www.virtualbox.org) and [Vagrant](https://www.vagrantup.com/) on your machine.
* Ensure you have a minimum of 40 GB Diskspace and 4 GB RAM and 4 Cores for the VM.

## Steps for local testing
* Open a Terminal
* Clone this repo
* cd into the repo
* run `./pull-subtree.sh` to pull changes from the upstream repos
* run `vagrant up`
* after vagrant finishes, open [localhost:8080](http://localhost:8080)