# sodafoundation/dashboard/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}

{%- from "sodafoundation/map.jinja" import golang with context %}
{%- from 'sodafoundation/files/macros.j2' import update_config with context %}

include:
  - sodafoundation.config

       {%- for id in s.dashboard.ids %}
           {%- if 'conf' in s.dashboard and id in s.dashboard.conf %}
               {%- set config = s.dashboard.conf[id] %}
               {%- if config is mapping %}

{{ update_config('sodafoundation','dashboard config', id, config, s.conf) }}

               {%- endif %}
           {%- endif %}

       {%- endfor %}
    {%- endif %}
