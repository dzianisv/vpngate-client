A client for connecting to [vpngate.net](http://vpngate.net) OpenVPN servers.

__Features__:
* Discovers OpenVPN servers on vpngate.net.
* Probes the VPN endpoints to detect ones that aren't responding for some reason
before connecting to the VPN server.
* Once connected, performs a speed-test for the VPN and lets you decide if the
speed is good enough for you or if you want to try the next one on the list.
* Cross-ARCH `.deb` packages.
* `namespaced-openvpn` script creates a Linux network namespace with OpenVPN `tun0` only to prevent packet leaks on OpenVPN failures.
* Systemd `vpngate-client.service` and `vpngate-client@netns.service` services for GNU/Linux distributions.
* Filters VPN servers by their geographical location (country or VPNs in Europe).

## Dependencies
This client has following dependencies:
* [python](https://python.org) (at least v3.3)
* [OpenVPN](https://openvpn.net/)


## systemd.service usage
Let systemd care about service health and start it on boot

```sh
systemctl enabel --now vpngate-client
```

or start an Openvpn process inside a Linux Network Namespace `protectedns`. 
In this case the network stack in the namespace will be fully isolated, 
no leaks possible, all the packets go through openvpn or "die".
```sh
systemctl enable --now vpngate-cient@protectedns
```
Now you can test it
```sh
ip netns exec protectedns curl "api.ipify.org"
```
Or start a browser
```sh
sudo -E ip netns exec protectedns sudo -u $(id -u -n) firefox
```


## Script usage

Note: `sudo` is required for OpenVPN.

### Simple Case
```shell
  sudo ./vpngate-client
```

This tries the VPN servers one-by-one ordered by their score and asks you to
choose the one you like.

### Filter by Country
```shell
  sudo ./vpngate-client --country CA
  sudo ./vpngate-client --us # --us is a shorthand for --country US
```

The above command only considers VPN servers in Canada. The country identifier
is a 2 digit code (ISO 3166-2).

### VPNs in Europe
```shell
  sudo ./vpngate-client --eu
```

As a special case, the `--eu` flag only considers VPN servers in Europe.

### Other Options
All the command line options are available by running `./vpngate-client --help`.
