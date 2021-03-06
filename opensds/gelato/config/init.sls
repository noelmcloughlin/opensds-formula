# opensds/gelato/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "opensds/map.jinja" import opensds with context %}

    {%- if opensds.deploy_project not in ('hotpot',) %}

{%- from "opensds/map.jinja" import devstack, golang with context %}
{%- from 'opensds/files/macros.j2' import update_config with context %}

include:
  - opensds.config

        {%- for id in opensds.gelato.ids %}
            {%- if 'opensdsconf' in opensds.gelato and id in opensds.gelato.opensdsconf %}
                {%- set config = opensds.gelato.opensdsconf[id] %}

{{ update_config('opensds','gelato config', id, config, opensds.conf) }}

            {%- endif %}
                ################################
                #### {{id}} docker compose file
                ################################
            {%- set daemon = opensds.gelato.daemon[ id|string ] %}
            {%- if 'compose' in daemon.strategy|lower %}

opensds gelato config {{ id }} change default auth-strategy:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/opensds/{{ id }}/docker-compose.yml
    - pattern: 'OS_AUTH_AUTHSTRATEGY=.*$'
    - repl: 'OS_AUTH_AUTHSTRATEGY={{ opensds.auth.daemon.osdsauth.strategy }}'
    - backup: '.salt.bak'

opensds gelato config {{ id }} change default auth-url:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/opensds/{{ id }}/docker-compose.yml
    - pattern: 'OS_AUTH_URL=.*$'
    - repl: 'OS_AUTH_URL=http://{{ opensds.host }}/identity'

opensds gelato config {{ id }} change default username:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/opensds/{{ id }}/docker-compose.yml
    - pattern: 'OS_USERNAME=.*$'
    - repl: 'OS_USERNAME={{ opensds.gelato.service }}'

opensds gelato config {{ id }} change default password:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/opensds/{{ id }}/docker-compose.yml
    - pattern: 'OS_PASSWORD=.*$'
    - repl: 'OS_PASSWORD={{ devstack.local.os_password }}'

            {%- endif %}
         {%- endfor %}
     {%- endif %}
