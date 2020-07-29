# sodafoundation/backend/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}
{%- from 'sodafoundation/files/macros.j2' import update_config with context %}

include:
  - sodafoundation.config

        {%- for id in s.backend.ids %}
            {%- if 'conf' in s.backend and id in s.backend.conf %}
                {%- set config = s.backend.conf[id] %}
                {%- if config %}

{{ update_config('sodafoundation','backend config', id, config, s.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
