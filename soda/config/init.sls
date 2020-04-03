###  soda/config.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda, golang, devstack, packages with context %}

soda infra base directories created:
  file.directory:
    - names:
      - {{ soda.dir.nbp }}/nbp/provisioner  # https://github.com/sodafoundation/installer/issues/110
      {%- for k, v in soda.dir.items() %}
      - {{ v }}
      {%- endfor %}
    - makedirs: True
    - force: True
    - user: {{ soda.user or 'root' }}
    - dir_mode: {{ soda.dir_mode or '0755' }}

soda config ensure soda conf exists:
  file.managed:
   - name: {{ soda.conf }}
   - makedirs: True
   - replace: False
   - user: root
   - mode: {{ soda.file_mode or '0644' }}

     {%- if grains.os_family not in ('FreeBSD',) %}

soda config ensure docker running:
  service.running:
    - name: docker
    - enable: True
  #cmd.run:
  #  - name: echo $DOCKER_PASS | docker login -u$DOCKER_USER --password-stdin $DOCKER_HOST

     {%- endif %}

### sdsrc
soda config sdsrc file generated:
  file.managed:
    - name: {{ soda.dir.controller }}/sdsrc
    - source: salt://soda/files/sdsrc.j2
    - makedirs: True
    - template: jinja
    - user: {{ soda.user or 'root' }}
    - mode: {{ soda.file_mode or '0644' }}
    - context:
      golang: {{ golang|json }}
      devstack: {{ devstack|json }}
      soda: {{ soda|json }}

### profile
soda infra system profile present:
  file.managed:
    - name: /etc/profile.d/soda.sh
    - source: salt://soda/files/profile.j2
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - onlyif: test -f {{ golang.go_path }}/bin/go
    - context:
      golanghome: {{ golang.go_path }}
      sdshome: {{ soda.dir.controller }}
