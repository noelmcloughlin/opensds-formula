### sodafoundation/backend/block/box/install.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation, resolver with context %}

   {%- if sodafoundation.deploy_project not in ('gelato',)  %}
       {%- if 'cinder' in sodafoundation.backend.block.ids and 'daemon' in sodafoundation.backend.block %}
           {%- set daemon = sodafoundation.backend.block.daemon['cinder'] %}
           {%- if 'compose' in daemon.strategy|lower and 'cinder' in sodafoundation.backend.block.container %}
               {%- set container = sodafoundation.backend.block.container['cinder'] %}
           {%- endif %}

           ###################
           # Docker daemon
           ###################
           {%- if grains.os_family == 'RedHat' %}
sodafoundation backend block box docker daemon set dns:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://sodafoundation/files/docker.json.j2
    - makedirs: True
    - template: jinja
    - user: {{ sodafoundation.user or 'root' }}
    - mode: {{ sodafoundation.file_mode or '0644' }}
    - context:
      dns_host1: {{ resolver.nameservers[0] }}
      dns_host2: {{ resolver.nameservers[1] }}
      ipdomain: {{ resolver.domain }}
  cmd.run:
    - name: systemctl restart docker || service restart docker
           {%- endif %}
    

           ###################
           # Custom makefiles
           ###################

sodafoundation backend block box cinder Makefile set platform:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/Makefile
    - pattern: 'PLATFORM.*\?=.*$'
    - repl: 'PLATFORM ?= {{ container.makefile.platform }}'
    - backup: '.salt.bak.original'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/Makefile

sodafoundation backend block box cinder Makefile set image tag:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/Makefile
    - pattern: 'TAG.*\?=.*$'
    - repl: 'TAG ?= {{ container.makefile.tag }}'
    - backup: '.salt.bak'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/Makefile

sodafoundation backend block box cinder docker-compose modify default username:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/docker-compose.yml
    - pattern: 'image: debian-cinder'
    - repl: 'image: {{ container.compose.image }}'
    - backup: '.salt.bak'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/docker-compose.yml

sodafoundation backend block box cinder docker-compose set image:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/docker-compose.yml
    - pattern: 'image: lvm-debian-cinder'
    - repl: 'image: {{ container.compose.imagetag }}'
    - backup: '.salt.bak'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/docker-compose.yml

sodafoundation backend block box cinder docker-compose set dbport:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/docker-compose.yml
    - pattern: '3306:3306'
    - repl: '{{ container.compose.dbports }}'
    - backup: '.salt.bak'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/docker-compose.yml

               ###########################
               # update cinder.conf files
               ###########################
           {%- if 'custom' in sodafoundation.backend.block and'cinder'in sodafoundation.backend.block.custom %}
               {%- if sodafoundation.backend.block.custom['cinder'] is iterable %}
                   {%- for file in sodafoundation.backend.block.custom['cinder'] %}

sodafoundation backend block box cinder {{ file }} modify default volumegroup:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/etc/cinder.conf
    - pattern: 'volume_group = cinder-volumes '
    - repl: 'volume_group = {{ container.conf.volumegroup }} '
    - backup: '.salt2.bak'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/etc/cinder.conf

sodafoundation backend block box cinder {{ file }} modify default enabled_backends:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/etc/cinder.conf
    - pattern: 'enabled_backends.*'
    - repl: 'enabled_backends = {{ sodafoundation.dock.conf.dock.enabled_backends }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/etc/cinder.conf

#sodafoundation backend block box cinder {{ file }} modify default volumes_dir:
#  file.replace:
#    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/etc/cinder.conf
#    - pattern: 'volumes_dir.*'
#    - repl: 'volumes_dir = {{ sodafoundation.dir.hotpot }}/volumegroups/'
#    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/etc/cinder.conf

                       {%- if "DISABLED DISABLED keystone" in file %}

sodafoundation backend block box cinder {{ file }} set sodafoundationendpoint:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^www_authenticate_uri.*$'
    - repl: 'www_authenticate_uri = {{ sodafoundation.auth.daemon.auth.endpoint_ipv4 }}:{{ sodafoundation.auth.daemon.auth.endpoint_port }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set auth_type:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^auth_type.*$'
    - repl: 'auth_type = password'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set auth_url:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^auth_url.*$'
    - repl: 'auth_url = {{ sodafoundation.auth.conf.keystone_authtoken.auth_url }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set memcached_servers:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^memcached_servers.*$'
    - repl: 'memcached_servers = {{ sodafoundation.auth.daemon.auth.endpoint_ipv4 }}:11211'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set username:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^username.*$'
    - repl: 'username = {{ sodafoundation.backend.drivers.cinder.authOptions.username }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set password:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^password.*$'
    - repl: 'password = {{ sodafoundation.backend.drivers.cinder.authOptions.password }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set project_domain_name:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^project_domain_name.*$'
    - repl: 'project_domain_name = {{ sodafoundation.backend.drivers.cinder.authOptions.domainId }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set user_domain_name:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^user_domain_name.*$'
    - repl: 'user_domain_name = {{ sodafoundation.backend.drivers.cinder.authOptions.domainName }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set project_name:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^project_name.*$'
    - repl: 'project_name = {{ sodafoundation.backend.drivers.cinder.authOptions.projectName }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

sodafoundation backend block box cinder {{ file }} set connection:
  file.replace:
    - name: {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}
    - pattern: '^connection.*$'
    - repl: 'connection = mysql:{{ sodafoundation.database.conf.database.credential }}'
    - onlyif: test -f {{ sodafoundation.dir.sushi }}/cinder/contrib/block-box/{{ file }}

                       {%- endif %}
                   {%- endfor %}
               {%- endif %}
           {%- endif %}
      {%- endif %}
  {%- endif %}
