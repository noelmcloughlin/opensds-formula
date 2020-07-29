# sodafoundation/auth/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',) %}
{%- from 'sodafoundation/files/macros.j2' import update_config with context %}

include:
  - sodafoundation.config

        {%- for id in sodafoundation.auth.ids %}
            {%- if 'conf' in sodafoundation.auth and id in sodafoundation.auth.conf %}
                {%- set config = sodafoundation.auth.conf[id] %}
                {%- if config is mapping %}

{{ update_config('sodafoundation','auth config', id, config, sodafoundation.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
