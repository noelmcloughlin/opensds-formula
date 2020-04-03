###  soda/dock/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}
       {%- for id in soda.dock.ids %}
           {%- if id in soda.dock.daemon and "release" in soda.dock.daemon[id]['strategy']|lower %} 

soda dock release {{ id }} download directory clean:
  file.absent:
    - name: {{ soda.dir.controller }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
