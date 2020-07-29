# sodafoundation/sushi/plugin/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

  {%- if s.deploy_project not in ('gelato',) %}
      {%- for id in s.sushi.plugin.ids %}
          {%- if 'custom' in s.sushi.plugin and id in s.sushi.plugin.custom and s.sushi.plugin.custom[id] is mapping %}

sodafoundation sushi plugin custom {{ id }} plugin dir absent:
  file.absent:
    - name: {{ s.sushi.plugin.custom[id]['dir'] }}/sodafoundation

          {%- endif %}
      {%- endfor %}
  {%- endif %}
