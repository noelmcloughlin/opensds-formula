# soda/multicloud/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('controller',) %}

{%- from "soda/map.jinja" import devstack, golang with context %}
{%- from 'soda/files/macros.j2' import update_config with context %}

include:
  - soda.config

        {%- for id in soda.multicloud.ids %}
            {%- if 'conf' in soda.multicloud and id in soda.multicloud.conf %}
                {%- set config = soda.multicloud.conf[id] %}

{{ update_config('soda','multicloud config', id, config, soda.conf) }}

            {%- endif %}
                ################################
                #### {{id}} docker compose file
                ################################
            {%- set daemon = soda.multicloud.daemon[ id|string ] %}
            {%- if 'compose' in daemon.strategy|lower %}

soda multicloud config {{ id }} change default auth-strategy:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/soda/{{ id }}/docker-compose.yml
    - pattern: 'OS_AUTH_AUTHSTRATEGY=.*$'
    - repl: 'OS_AUTH_AUTHSTRATEGY={{ soda.auth.daemon.auth.strategy }}'
    - backup: '.salt.bak'

soda multicloud config {{ id }} change default auth-url:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/soda/{{ id }}/docker-compose.yml
    - pattern: 'OS_AUTH_URL=.*$'
    - repl: 'OS_AUTH_URL=http://{{ soda.host }}/identity'

soda multicloud config {{ id }} change default username:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/soda/{{ id }}/docker-compose.yml
    - pattern: 'OS_USERNAME=.*$'
    - repl: 'OS_USERNAME={{ soda.multicloud.service }}'

soda multicloud config {{ id }} change default password:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/soda/{{ id }}/docker-compose.yml
    - pattern: 'OS_PASSWORD=.*$'
    - repl: 'OS_PASSWORD={{ devstack.local.os_password }}'

            {%- endif %}
         {%- endfor %}
     {%- endif %}
