# sodafoundation/gelato/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('hotpot',) %}

{%- from 'sodafoundation/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in s.gelato.ids %}
            {%- if "conf" in s.gelato and id in s.gelato.conf %}

{{ cleanup_config('sodafoundation', 'gelato config', id, s.conf)}}
{{ cleanup_files('sodafoundation', 'gelato config', id, s.dir.gelato) }}

            {%- endif %}
        {%- endfor %}
  {%- endif %}
