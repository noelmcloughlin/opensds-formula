###  soda/multicloud/repo/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

   {%- if soda.deploy_project not in ('controller',)  %}
       {%- for id in soda.multicloud.ids %}

soda multicloud repo {{ id }} ensure directory removed:
  file.absent:
    - name: {{ soda.dir.multicloud + '/' + id }}

       {%- endfor %}
   {%- endif %}
