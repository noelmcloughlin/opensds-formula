# soda/nbp/plugin/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- if soda.deploy_project not in ('multicloud',)  %}
{%- from "soda/map.jinja" import golang with context %}
      {%- for id in soda.nbp.plugin.ids %}
          {%- if 'repo' in soda.nbp.daemon.nbp %}

soda nbp plugin config {{ id }} ensure nbp dir exists:
  file.directory:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}
    - makedirs: True
    - clean: True

              {%- if 'subdirs' in soda.nbp.plugin and soda.nbp.plugin.subdirs is iterable %}
                  {%- for s in soda.nbp.plugin.subdirs %}

soda nbp plugin config-repo {{ id }} copy {{ s }} to workdir:
  cmd.run:
    - unless: test -d {{ soda.dir.nbp }}/nbp/{{ id }}/{{ s }}
                      {%- if id|lower == 'provisioner' %}
    - name: cp -rp {{golang.go_path}}/src/github.com/soda/nbp/soda-{{id}}/{{s}} {{soda.dir.nbp}}/nbp/{{id}}/
    - onlyif: test -d {{ golang.go_path }}/src/github.com/soda/nbp/soda-{{ id }}/{{ s }}
                      {%- else %}
    - name: cp -rp {{golang.go_path}}/src/github.com/soda/nbp/{{id}}/{{s}} {{soda.dir.nbp}}/nbp/{{id}}/
    - onlyif: test -d {{ golang.go_path }}/src/github.com/soda/nbp/{{ id }}/{{ s }}

                      {%- endif %}
                  {%- endfor %}
              {%- endif %}

              {%- if 'custom' in soda.nbp.plugin and id in soda.nbp.plugin.custom %}
                  {%- set custom = soda.nbp.plugin.custom[ id ] %}

                      ##############################
                      # deploy plugin to filesystem
                      ##############################
                  {%- if 'file' in custom and custom.file and 'dir' in custom and custom.dir %}
soda nbp plugin config {{ id }} copy {{ custom.file }} to {{ soda.dir.nbp }}/nbp/{{ id }}:
  file.copy:
    - name: {{ custom.dir }}/soda
    - source: {{ soda.dir.nbp }}/nbp/{{ custom.file }}
    - force: True
    - makedirs: True
    - user: {{ soda.user or 'root' }}
    - mode: {{ soda.file_mode or '0644' }}
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ custom.file }}

                  {%- elif custom is iterable and custom is not string %}
                      ##############################
                      # customize plugin yaml files
                      ##############################
                      {%- for file in custom  %}

soda nbp plugin config {{ id }} set sodaendpoint in external {{ file }} file:
  file.replace:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  sodaendpoint.*$'
    - repl: '  sodaendpoint: {{ soda.auth.daemon.auth.endpoint_ipv4 }}:{{ soda.auth.daemon.auth.endpoint_port }}'
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}

soda nbp plugin config {{ id }} set authstrategy in external {{ file }} file:
  file.replace:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  authstrategy.*$'
    - repl: '  authstrategy: {{ soda.controller.conf.let.auth_strategy }}'
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}

soda nbp plugin config {{ id }} set osauthurl in external {{ file }} file:
  file.replace:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osauthurl.*$'
    - repl: '  osauthurl: {{ soda.auth.conf.keystone_authtoken.auth_url }}'
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}

soda nbp plugin config {{ id }} set osusername in external {{ file }} file:
  file.replace:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osusername.*$'
    - repl: '  osusername: {{ soda.auth.conf.keystone_authtoken.username }}'
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}

soda nbp plugin config {{ id }} set ospassword in external {{ file }} file:
  file.replace:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  ospassword.*$'
    - repl: '  ospassword: {{ soda.auth.conf.keystone_authtoken.password }}'
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}

soda nbp plugin config {{ id }} set osprojectname in external {{ file }} file:
  file.replace:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osprojectname.*$'
    - repl: '  osprojectname: {{ soda.auth.conf.keystone_authtoken.project_name }}'
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}

soda nbp plugin config {{ id }} set osuserdomainid in external {{ file }} file:
  file.replace:
    - name: {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osuserdomainid.*$'
    - repl: '  osuserdomainid: {{ soda.auth.conf.keystone_authtoken.user_domain_name }}'
    - onlyif: test -f {{ soda.dir.nbp }}/nbp/{{ id }}/{{ file }}

                      {%- endfor %}
                  {%- endif %}
              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
