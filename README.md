# btcpayserver-testing
A collection of scripts to automate the deployment for testing btcpayserver

## Vagrant

### Prequisits
* Install [Virtualbox](https://www.virtualbox.org) and [Vagrant](https://www.vagrantup.com/) on your machine.
* Ensure you have a minimum of 40 GB Diskspace and 4 GB RAM and 4 Cores for the VM.

### Steps for local testing
* Open a Terminal
* Clone this repo
* cd into the repo
* run `vagrant up` or `BTCPAY_BRANCH=[your-branch-of-btcpayserver-repo] BTCPAY_REPO=[YOUR_GIT_URL] vagrant up`
* after vagrant finishes, open [localhost:8080](http://localhost:8080)

## Cloud-Init

### Prequesits
* a VPS which supports cloud-init ([Contabo](https://contabo.com) for example does)
* a VPS with minimum 20 GB disk space and 4 GB RAM should do

### Howto use

Just copy&paste the [cloud-init script](cloud-init.txt) to the configuration panel of your VPS provider:
this should leave you with a preconfiugred BTCPayServer (master branch) on your VPS.

One thing to look out for, change this line `export BTCPAY_HOST="master.staging-server02.btcpay.host"` to modify your hostname.