# soda/backend/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import update_config with context %}

include:
  - soda.config

        {%- for id in soda.backend.ids %}
            {%- if 'conf' in soda.backend and id in soda.backend.conf %}
                {%- set config = soda.backend.conf[id] %}
                {%- if config %}

{{ update_config('soda','backend config', id, config, soda.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
