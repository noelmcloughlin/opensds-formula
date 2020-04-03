###  soda/nbp/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('multicloud',)  %}
       {%- for id in soda.nbp.ids %}
           {%- if id in soda.nbp.daemon and "release" in soda.nbp.daemon[id]['strategy']|lower %} 

soda nbp release {{ id }} download directory clean:
  file.absent:
    - name: {{ soda.dir.nbp }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
