###  sodafoundation/dashboard/repo/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}
        {%- for id in sodafoundation.dashboard.ids %}

sodafoundation dashboard repo {{ id }} ensure directory removed:
  file.absent:
    - name: {{ sodafoundation.dir.dashboard + '/' + id }}

        {%- endfor %}
    {%- endif %}
