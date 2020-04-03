# soda/controller/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import update_config with context %}

include:
  - soda.config

        {%- for id in soda.controller.ids %}
            {%- if 'conf' in soda.controller and id in soda.controller.conf %}
                {%- set config = soda.controller.conf[id] %}
                {%- if config is mapping %}

{{ update_config('soda','controller config', id, config, soda.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
