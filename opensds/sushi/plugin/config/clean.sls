# opensds/sushi/plugin/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from 'opensds/map.jinja' import opensds, golang with context %}

  {%- if opensds.deploy_project not in ('gelato',) %}
      {%- for id in opensds.sushi.plugin.ids %}
          {%- if 'custom' in opensds.sushi.plugin and id in opensds.sushi.plugin.custom  %}
              {%- if opensds.sushi.plugin.custom[id] is mapping  %}

opensds sushi plugin custom {{ id }} plugin dir absent:
  file.absent:
    - name: {{ opensds.sushi.plugin.custom[id]['dir'] }}/opensds

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
