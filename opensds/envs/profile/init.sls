### opensds/profile/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from "opensds/map.jinja" import opensds with context %}

opensds profile set system profile path:
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
      sdshome: {{ opensds.dir.work }}
