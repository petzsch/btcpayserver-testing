# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/jammy64"

  # expand OS Disk to 50GB (requires EXPERIMANTAL FEATURE - disabled for now)
  # config.vm.disk :disk, size: "25GB", primary: true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 9001, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "4096"
    vb.cpus = 4
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", env: {"BTCPAY_BRANCH" => ENV['BTCPAY_BRANCH'], "BTCPAY_REPO" => ENV['BTCPAY_REPO']}, inline: <<-SHELL
    apt-get update
    apt-get install -y git
    # Create a folder for BTCPay
    cd /root/
    mkdir BTCPayServer
    cd BTCPayServer

    # Clone this repository
    git clone https://github.com/btcpayserver/btcpayserver-docker
    cd btcpayserver-docker
    if [ -z "$BTCPAY_REPO" ]
      then
            export BTCPAY_REPO="https://github.com/btcpayserver/btcpayserver.git"
            echo "cloning from https://github.com/btcpayserver/btcpayserver.git (none selected)"
      else
            echo "\$BTCPAY_REPO will be cloned"
      fi
    if [ -z "$BTCPAY_BRANCH" ]
      then
            export BTCPAY_BRANCH="master"
            echo "master will be checked out (none selected)"
      else
            echo "\$BTCPAY_BRANCH will be checked out"
      fi
    git clone --single-branch -b $BTCPAY_BRANCH $BTCPAY_REPO

    # patch btcpayserver-docker to build from source directory
    sed -i 's#docker-compose -f $BTCPAY_DOCKER_COMPOSE up --remove-orphans -d#docker-compose -f $BTCPAY_DOCKER_COMPOSE up --build --remove-orphans -d#g' helpers.sh
    


    # Run btcpay-setup.sh with the right parameters
    export BTCPAY_HOST="btcpay.local"
    export BTCPAY_ADDITIONAL_HOSTS="localhost"
    export NBITCOIN_NETWORK="mainnet"
    export BTCPAYGEN_CRYPTO1="btc"
    export BTCPAYGEN_ADDITIONAL_FRAGMENTS="opt-save-storage-xxs"
    export BTCPAYGEN_REVERSEPROXY="nginx"
    export BTCPAYGEN_EXCLUDE_FRAGMENTS="nginx-https" # offload SSL termination to apache
    export REVERSEPROXY_HTTP_PORT=9001
    export BTCPAYGEN_LIGHTNING="lnd"
    export BTCPAY_ENABLE_SSH=true
    . ./btcpay-setup.sh -i
    # patch generated docker-compose file to include build context instead of image
    sed -i 's#image: \${BTCPAY_IMAGE:-btcpayserver\/btcpayserver:.*\..*\..*}#build:\n      context: \.\./btcpayserver\n      dockerfile: amd64.Dockerfile#g' Generated/docker-compose.generated.yml
    btcpay-restart.sh
  SHELL
  config.vm.provision "shell", inline: <<-SHELL
    cd /root/BTCPayServer/btcpayserver-docker/
    btcpay-down.sh
    cd contrib/FastSync
    ./load-utxo-set.sh
    btcpay-up.sh
  SHELL
end
