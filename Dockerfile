FROM sysrepo/sysrepo-netopeer2:devel_20160817

# Privileged user needed for OpenSSH
RUN echo 'sshd:x:128:' >> /etc/group
RUN echo 'sshd:x:128:128:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin' >> /etc/passwd

# OpenSSH
RUN \
      cd /opt/dev && \
      git clone https://github.com/sysrepo/openssh-sysrepo.git && cd openssh-sysrepo && \
      autoreconf && ./configure LDCONFIG=-L/usr/lib LIBS=-lsysrepo && \
      make sshd #&& make install

RUN cd /opt/dev/openssh-sysrepo && sysrepoctl --install --yang=sshd_config.yang
RUN cd /opt/dev/openssh-sysrepo && sysrepocfg --import=example_sshd_conf.xml --datastore=startup sshd_config

CMD ["/usr/bin/sysrepod"]
CMD ["/usr/bin/netopeer2-server", "-d"]
