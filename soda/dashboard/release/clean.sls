###  soda/dashboard/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}
       {%- for id in soda.dashboard.ids %}
           {%- if id in soda.dashboard.daemon and 'release' in soda.dashboard.daemon[id]['strategy'] %} 

soda dashboard release {{ id }} download directory clean:
  file.absent:
    - name: {{ soda.dir.dashboard }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
