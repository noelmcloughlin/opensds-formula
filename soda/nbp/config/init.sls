# soda/nbp/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import update_config with context %}

        {%- for id in soda.nbp.ids %}
             {%- if 'conf' in soda.nbp and id in soda.nbp.conf %}
                 {%- if soda.nbp.conf[id] is mapping %}

{{ update_config('soda','nbp config', id, soda.nbp.conf[id], soda.conf)}}

                 {%- endif %}
             {%- endif %}
        {%- endfor %}
  {%- endif %}
