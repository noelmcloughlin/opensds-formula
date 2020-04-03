# soda/dashboard/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}

{%- from "soda/map.jinja" import golang with context %}
{%- from 'soda/files/macros.j2' import update_config with context %}

include:
  - soda.config

       {%- for id in soda.dashboard.ids %}
           {%- if 'conf' in soda.dashboard and id in soda.dashboard.conf %}
               {%- set config = soda.dashboard.conf[id] %}
               {%- if config is mapping %}

{{ update_config('soda','dashboard config', id, config, soda.conf) }}

               {%- endif %}
           {%- endif %}

       {%- endfor %}
    {%- endif %}
