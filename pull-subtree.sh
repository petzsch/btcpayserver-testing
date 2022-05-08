#!/bin/bash
git subtree pull --prefix btcpayserver-docker https://github.com/btcpayserver/btcpayserver-docker.git master --squash
git subtree pull --prefix btcpayserver-docker/btcpayserver-src https://github.com/btcpayserver/btcpayserver.git master --squash