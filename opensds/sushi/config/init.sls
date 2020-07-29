# sodafoundation/sushi/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}
{%- from 'sodafoundation/files/macros.j2' import update_config with context %}

        {%- for id in s.sushi.ids %}
             {%- if 'conf' in s.sushi and id in s.sushi.conf %}
                 {%- if s.sushi.conf[id] is mapping %}

{{ update_config('sodafoundation','sushi config', id, s.sushi.conf[id], s.conf)}}

                 {%- endif %}
             {%- endif %}
        {%- endfor %}
  {%- endif %}
