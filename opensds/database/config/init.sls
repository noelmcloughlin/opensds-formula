# sodafoundation/database/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}
{%- from 'sodafoundation/files/macros.j2' import update_config with context %}

include:
  - s.config

        {%- for id in s.database.ids %}
            {%- if 'conf' in s.database and id in s.database.conf %}
                {%- set config = s.database.conf[id] %}
                {%- if config is mapping %}

{{ update_config('sodafoundation','database config', id, config, s.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
