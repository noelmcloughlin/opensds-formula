###  soda/multicloud/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('controller',)  %}
       {%- for id in soda.multicloud.ids %}
           {%- if id in soda.multicloud.daemon and 'release' in soda.multicloud.daemon[id]['strategy']|lower %} 

soda multicloud release {{ id }} download directory clean:
  file.absent:
    - name: {{ soda.dir.multicloud }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
