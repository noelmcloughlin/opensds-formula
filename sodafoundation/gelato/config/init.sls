# sodafoundation/gelato/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('hotpot',) %}

{%- from "sodafoundation/map.jinja" import devstack, golang with context %}
{%- from 'sodafoundation/files/macros.j2' import update_config with context %}

include:
  - sodafoundation.config

        {%- for id in s.gelato.ids %}
            {%- if 'conf' in s.gelato and id in s.gelato.conf %}
                {%- set config = s.gelato.conf[id] %}

{{ update_config('sodafoundation','gelato config', id, config, s.conf) }}

            {%- endif %}
                ################################
                #### {{id}} docker compose file
                ################################
            {%- set daemon = s.gelato.daemon[ id|string ] %}
            {%- if 'compose' in daemon.strategy|lower %}

sodafoundation gelato config {{ id }} change default auth-strategy:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/sodafoundation/{{ id }}/docker-compose.yml
    - pattern: 'OS_AUTH_AUTHSTRATEGY=.*$'
    - repl: 'OS_AUTH_AUTHSTRATEGY={{ s.auth.daemon.auth.strategy }}'
    - backup: '.salt.bak'

sodafoundation gelato config {{ id }} change default auth-url:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/sodafoundation/{{ id }}/docker-compose.yml
    - pattern: 'OS_AUTH_URL=.*$'
    - repl: 'OS_AUTH_URL=http://{{ s.host }}/identity'

sodafoundation gelato config {{ id }} change default username:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/sodafoundation/{{ id }}/docker-compose.yml
    - pattern: 'OS_USERNAME=.*$'
    - repl: 'OS_USERNAME={{ s.gelato.service }}'

sodafoundation gelato config {{ id }} change default password:
  file.replace:
    - name: {{ golang.go_path }}/src/github.com/sodafoundation/{{ id }}/docker-compose.yml
    - pattern: 'OS_PASSWORD=.*$'
    - repl: 'OS_PASSWORD={{ devstack.local.os_password }}'

            {%- endif %}
         {%- endfor %}
     {%- endif %}
