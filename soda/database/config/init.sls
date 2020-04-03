# soda/database/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import update_config with context %}

include:
  - soda.config

        {%- for id in soda.database.ids %}
            {%- if 'conf' in soda.database and id in soda.database.conf %}
                {%- set config = soda.database.conf[id] %}
                {%- if config is mapping %}

{{ update_config('soda','database config', id, config, soda.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
