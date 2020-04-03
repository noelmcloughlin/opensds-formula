# soda/dock/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import update_config, create_dir with context %}

include:
  - soda.config

        {%- for id in soda.dock.ids %}
            {%- if 'conf' in soda.dock and id in soda.dock.conf %}
                {%- set config = soda.dock.conf[id] %}
                {%- if config is mapping %}

{{ update_config('soda','dock config', id, config, soda.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}

{{ create_dir('soda','dock config', 'volumegroups', soda.dir.controller) }}
    {%- endif %}
