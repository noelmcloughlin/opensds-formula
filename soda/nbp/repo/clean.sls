###  soda/nbp/repo/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}
        {%- for id in soda.nbp.ids %}

soda nbp repo {{ id }} ensure directory removed:
  file.absent:
    - name: {{ soda.dir.nbp }}/{{ id }}

        {%- endfor %}
    {%- endif %}
