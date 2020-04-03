# soda/multicloud/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('controller',) %}

{%- from 'soda/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.multicloud.ids %}
            {%- if "conf" in soda.multicloud and id in soda.multicloud.conf %}

{{ cleanup_config('soda', 'multicloud config', id, soda.conf)}}
{{ cleanup_files('soda', 'multicloud config', id, soda.dir.multicloud) }}

            {%- endif %}
        {%- endfor %}
  {%- endif %}
