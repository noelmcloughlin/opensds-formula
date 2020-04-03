###  soda/api/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}
       {%- for id in soda.api.ids %}
           {%- if id in soda.api.daemon and "release" in soda.api.daemon[id]['strategy']|lower %} 

soda api release {{ id }} download directory clean:
  file.absent:
    - name: {{ soda.dir.controller }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
