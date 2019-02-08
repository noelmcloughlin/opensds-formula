###  opensds/config.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "opensds/map.jinja" import opensds, golang, devstack, packages with context %}

opensds infra base directories created:
  file.directory:
    - names:
      {%- for k, v in opensds.dir.items() %}
      - {{ v }}
      {%- endfor %}
    - makedirs: True
    - force: True
    - user: {{ opensds.user or 'root' }}
    - dir_mode: {{ opensds.dir_mode or '0755' }}

opensds config ensure opensds conf exists:
  file.managed:
   - name: {{ opensds.conf }}
   - makedirs: True
   - replace: False
   - user: root
   - mode: {{ opensds.file_mode or '0644' }}

opensds config ensure docker running:
  service.running:
    - name: docker
    - enable: True
  #cmd.run:
  #  - name: echo $DOCKER_PASS | docker login -u$DOCKER_USER --password-stdin $DOCKER_HOST

### sdsrc
opensds config sdsrc file generated:
  file.managed:
    - name: {{ opensds.dir.hotpot }}/sdsrc
    - source: salt://opensds/files/sdsrc.j2
    - makedirs: True
    - template: jinja
    - user: {{ opensds.user or 'root' }}
    - mode: {{ opensds.file_mode or '0644' }}
    - context:
      golang: {{ golang }}
      devstack: {{ devstack }}
      opensds: {{ opensds }}

### profile
opensds infra system profile present:
  file.managed:
    - name: /etc/profile.d/opensds.sh
    - source: salt://opensds/files/profile.j2
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - onlyif: test -f {{ golang.go_path }}/bin/go
    - context:
      golanghome: {{ golang.go_path }}
      sdshome: {{ opensds.dir.hotpot }}
