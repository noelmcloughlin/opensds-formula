###  sodafoundation/sushi/repo/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}
        {%- for id in sodafoundation.sushi.ids %}

sodafoundation sushi repo {{ id }} ensure directory removed:
  file.absent:
    - name: {{ sodafoundation.dir.sushi }}/{{ id }}

        {%- endfor %}
    {%- endif %}
