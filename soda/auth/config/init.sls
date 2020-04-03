# soda/auth/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import update_config with context %}

include:
  - soda.config

        {%- for id in soda.auth.ids %}
            {%- if 'conf' in soda.auth and id in soda.auth.conf %}
                {%- set config = soda.auth.conf[id] %}
                {%- if config is mapping %}

{{ update_config('soda','auth config', id, config, soda.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
