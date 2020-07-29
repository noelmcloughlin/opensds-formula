###  sodafoundation/gelato/repo/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

   {%- if sodafoundation.deploy_project not in ('hotpot',)  %}
       {%- for id in sodafoundation.gelato.ids %}

sodafoundation gelato repo {{ id }} ensure directory removed:
  file.absent:
    - name: {{ sodafoundation.dir.gelato + '/' + id }}

       {%- endfor %}
   {%- endif %}
