###  soda/controller/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}
       {%- for id in soda.controller.ids %}
           {%- if id in soda.controller.daemon and 'release' in soda.controller.daemon[id]['strategy']|lower %}

soda controller release {{ id }} download directory clean:
  file.absent:
    - name: {{ soda.dir.controller }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
