### opensds/controller/repo.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "opensds/map.jinja" import opensds with context %}

include:
  - golang

opensds controller ensure opensds dirs exist:
  file.directory:
    - names:
      {%- for k, v in opensds.dir.items() %}
      - {{ v }}
      {%- endfor %}
      - {{ opensds.dir.tmp }}/{{ opensds.dir.work }}
    - makedirs: True
    - force: True
    - dir_mode: '0755'

opensds controller repo download from git:
  git.latest:
    - name: {{ opensds.controller.repo.url }}
    - target: {{ opensds.dir.tmp }}/{{ opensds.dir.work }}
    - rev: {{ opensds.repo.get('branch', 'master') }}
    - force_checkout: True
    - force_clone: True
    - force_fetch: True
    - force_reset: True
    - require:
      - opensds controller ensure opensds dirs exist
  cmd.run:
    - name: make
    - cwd: {{ opensds.dir.tmp }}/{{ opensds.dir.work }}
    - env:
       - GOPATH: {{ golang.go_path }}/bin
    - require:
      - git: opensds controller {{ opensds.controller.release }} repo download from git
  file.managed:
    - name: {{ opensds.dir.work }}/
    - makedirs: True
    - mode: '0755'

opensds controller {{ opensds.controller.release }} copy repo content to work directory:
  file.copy:
    - name: {{ opensds.dir.work }}/
    - source: {{ opensds.dir.tmp }}/{{ opensds.dir.work }}/*
    - makedirs: True
    - force: True
    - require:
      - file: opensds controller repo download from git
     
