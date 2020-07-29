# sodafoundation/sushi/plugin/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

  {%- if s.deploy_project not in ('gelato',)  %}
{%- from "sodafoundation/map.jinja" import golang with context %}
      {%- for id in s.sushi.plugin.ids %}
          {%- if 'repo' in s.sushi.daemon.nbp %}

sodafoundation sushi plugin config {{ id }} ensure nbp dir exists:
  file.directory:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}
    - makedirs: True
    - clean: True

              {%- if 'subdirs' in s.sushi.plugin and s.sushi.plugin.subdirs is iterable %}
                  {%- for s in s.sushi.plugin.subdirs %}

sodafoundation sushi plugin config-repo {{ id }} copy {{ s }} to workdir:
  cmd.run:
    - unless: test -d {{ s.dir.sushi }}/nbp/{{ id }}/{{ s }}
                      {%- if id|lower == 'provisioner' %}
    - name: cp -rp {{golang.go_path}}/src/github.com/sodafoundation/nbp/sodafoundation-{{id}}/{{s}} {{s.dir.sushi}}/nbp/{{id}}/
    - onlyif: test -d {{ golang.go_path }}/src/github.com/sodafoundation/nbp/sodafoundation-{{ id }}/{{ s }}
                      {%- else %}
    - name: cp -rp {{golang.go_path}}/src/github.com/sodafoundation/nbp/{{id}}/{{s}} {{s.dir.sushi}}/nbp/{{id}}/
    - onlyif: test -d {{ golang.go_path }}/src/github.com/sodafoundation/nbp/{{ id }}/{{ s }}

                      {%- endif %}
                  {%- endfor %}
              {%- endif %}

              {%- if 'custom' in s.sushi.plugin and id in s.sushi.plugin.custom %}
                  {%- set custom = s.sushi.plugin.custom[ id ] %}

                      ##############################
                      # deploy plugin to filesystem
                      ##############################
                  {%- if 'file' in custom and custom.file and 'dir' in custom and custom.dir %}
sodafoundation sushi plugin config {{ id }} copy {{ custom.file }} to {{ s.dir.sushi }}/nbp/{{ id }}:
  file.copy:
    - name: {{ custom.dir }}/sodafoundation
    - source: {{ s.dir.sushi }}/nbp/{{ custom.file }}
    - force: True
    - makedirs: True
    - user: {{ s.user or 'root' }}
    - mode: {{ s.file_mode or '0644' }}
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ custom.file }}

                  {%- elif custom is iterable and custom is not string %}
                      ##############################
                      # customize plugin yaml files
                      ##############################
                      {%- for file in custom  %}

sodafoundation sushi plugin config {{ id }} set sodafoundationendpoint in external {{ file }} file:
  file.replace:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  sodafoundationendpoint.*$'
    - repl: '  sodafoundationendpoint: {{ s.auth.daemon.osdsauth.endpoint_ipv4 }}:{{ s.auth.daemon.osdsauth.endpoint_port }}'
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}

sodafoundation sushi plugin config {{ id }} set sodafoundationauthstrategy in external {{ file }} file:
  file.replace:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  sodafoundationauthstrategy.*$'
    - repl: '  sodafoundationauthstrategy: {{ s.hotpot.conf.osdslet.auth_strategy }}'
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}

sodafoundation sushi plugin config {{ id }} set osauthurl in external {{ file }} file:
  file.replace:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osauthurl.*$'
    - repl: '  osauthurl: {{ s.auth.conf.keystone_authtoken.auth_url }}'
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}

sodafoundation sushi plugin config {{ id }} set osusername in external {{ file }} file:
  file.replace:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osusername.*$'
    - repl: '  osusername: {{ s.auth.conf.keystone_authtoken.username }}'
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}

sodafoundation sushi plugin config {{ id }} set ospassword in external {{ file }} file:
  file.replace:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  ospassword.*$'
    - repl: '  ospassword: {{ s.auth.conf.keystone_authtoken.password }}'
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}

sodafoundation sushi plugin config {{ id }} set osprojectname in external {{ file }} file:
  file.replace:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osprojectname.*$'
    - repl: '  osprojectname: {{ s.auth.conf.keystone_authtoken.project_name }}'
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}

sodafoundation sushi plugin config {{ id }} set osuserdomainid in external {{ file }} file:
  file.replace:
    - name: {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}
    - pattern: '^  osuserdomainid.*$'
    - repl: '  osuserdomainid: {{ s.auth.conf.keystone_authtoken.user_domain_name }}'
    - onlyif: test -f {{ s.dir.sushi }}/nbp/{{ id }}/{{ file }}

                      {%- endfor %}
                  {%- endif %}
              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
