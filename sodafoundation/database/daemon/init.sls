###  sodafoundation/database/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

include:
  - sodafoundation.database.config
    {%- if 'database' in sodafoundation.database.daemon %}
        {%- if 'etcd' in sodafoundation.database.daemon.database.strategy %}
  - etcd.install
  - etcd.linuxenv
            {%- if 'container' in sodafoundation.database.daemon.database.strategy %}
  - etcd.docker.running
            {%- else %}
  - etcd.service
            {%- endif %}
        {%- endif %}
    {%- endif %}
