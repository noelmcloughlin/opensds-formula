# soda/nbp/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}

{%- from 'soda/files/macros.j2' import cleanup_config with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.nbp.ids %}
            {%- if "conf" in soda.nbp and id in soda.nbp.conf and soda.nbp.conf[id] is mapping %}

{{ cleanup_config('soda', 'nbp config', id, soda.conf)}}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
