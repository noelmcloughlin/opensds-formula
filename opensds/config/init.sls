###  sodafoundation/config.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation, golang, devstack, packages with context %}

sodafoundation infra base directories created:
  file.directory:
    - names:
      # https://github.com/sodafoundation/sodafoundation-installer/issues/110
      - {{ sodafoundation.dir.sushi }}/nbp/provisioner
      {%- for k, v in sodafoundation.dir.items() %}
      - {{ v }}
      {%- endfor %}
    - makedirs: True
    - force: True
    - user: {{ sodafoundation.user or 'root' }}
    - dir_mode: {{ sodafoundation.dir_mode or '0755' }}

sodafoundation config ensure sodafoundation conf exists:
  file.managed:
   - name: {{ sodafoundation.conf }}
   - makedirs: True
   - replace: False
   - user: root
   - mode: {{ sodafoundation.file_mode or '0644' }}

     {%- if grains.os_family not in ('FreeBSD',) %}

sodafoundation config ensure docker running:
  service.running:
    - name: docker
    - enable: True
  #cmd.run:
  #  - name: echo $DOCKER_PASS | docker login -u$DOCKER_USER --password-stdin $DOCKER_HOST

     {%- endif %}

### sdsrc
sodafoundation config sdsrc file generated:
  file.managed:
    - name: {{ sodafoundation.dir.hotpot }}/sdsrc
    - source: salt://sodafoundation/files/sdsrc.j2
    - makedirs: True
    - template: jinja
    - user: {{ sodafoundation.user or 'root' }}
    - mode: {{ sodafoundation.file_mode or '0644' }}
    - context:
      golang: {{ golang|json }}
      devstack: {{ devstack|json }}
      sodafoundation: {{ sodafoundation|json }}

### profile
sodafoundation infra system profile present:
  file.managed:
    - name: /etc/profile.d/sodafoundation.sh
    - source: salt://sodafoundation/files/profile.j2
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - onlyif: test -f {{ golang.go_path }}/bin/go
    - context:
      golanghome: {{ golang.go_path }}
      sdshome: {{ sodafoundation.dir.hotpot }}
