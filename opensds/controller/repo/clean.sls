###  opensds/controller/repo/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from salt.file.dirname(tpldir) ~ "/map.jinja" import opensds with context %}

opensds controller repo remove directories:
  file.absent:
    - name: {{ opensds.dir.work }}/controller

