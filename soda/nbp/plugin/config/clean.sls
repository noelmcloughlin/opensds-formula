# soda/nbp/plugin/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- if soda.deploy_project not in ('multicloud',) %}
      {%- for id in soda.nbp.plugin.ids %}
          {%- if 'custom' in soda.nbp.plugin and id in soda.nbp.plugin.custom and soda.nbp.plugin.custom[id] is mapping  %}

soda nbp plugin custom {{ id }} plugin dir absent:
  file.absent:
    - name: {{ soda.nbp.plugin.custom[id]['dir'] }}/soda

          {%- endif %}
      {%- endfor %}
  {%- endif %}
