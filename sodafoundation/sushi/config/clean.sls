# sodafoundation/sushi/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}

{%- from 'sodafoundation/files/macros.j2' import cleanup_config with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in s.sushi.ids %}
            {%- if "conf" in s.sushi and id in s.sushi.conf and s.sushi.conf[id] is mapping %}

{{ cleanup_config('sodafoundation', 'sushi config', id, s.conf)}}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
