# openssh-sysrepo - NETCONF enabled OpenSSH fork

Fork of OpenSSH that uses sysrepo to store its configuration, which makes it remotely manageble via NETCONF.

The purpose of this project is to demonstrate how [sysrepo](https://github.com/sysrepo/sysrepo/blob/master/INSTALL.md) & [Netopeer 2](https://github.com/CESNET/Netopeer2) can be used to make an existing Linux application remotely manageable via NECTONF in a few hours.

## Integration
Implementation only builds on existing OpenSSH faculties. Configuration in sshd_config is loaded first and then we read run-time configuration from sysrepo datastore.
It works by way of updating server options context by information attained from sysrepo session.

Some of the features of OpenSSH that have been integrated with sysrepo so far are:
* AllowUsers: list of users which are allowed to connect.
* UsePAM: use PAM module for authentication.
* PermitRootLogin: enable client to connect as root.

There are some more. And, more importantly, per need basis others are not difficult to implement.

## Demo
Asciinema-recored demo of this integration is available here: http://www.sysrepo.org/openssh-demo

## Installation
To use this integration, follow hese steps:

1) [Install sysrepo](https://github.com/sysrepo/sysrepo/blob/master/INSTALL.md).
2) [Initialize sysrepo with model and configuration]
   ```
   # Inside openssh directory:
   sysrepoctl --install --yang=sshd_config.yang
   sysrepocfg --import=example_sshd_conf.xml --datastore=startup sshd_config
   ```
3  [Start daemon and NETCONF server]
   ```
   sysrepod -l 0
   netopeer2-server
   ```
4) [Configure OpenSSH]
   ```
   autoreconf && ./configure LDCONFIG=-L/usr/lib LIBS=-lsysrepo
   ```
5) [Install OpenSSH]
   ```
   make && make install
   ```
