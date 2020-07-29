###  sodafoundation/database/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation, golang with context %}

include:
    {%- if 'etcd' in sodafoundation.database.daemon %}
        {%- if 'container' in sodafoundation.database.daemon.etcd.strategy|lower %}
  - etcd.docker.stopped
          {%- else %}
  - etcd.service.stopped
          {%- endif %}
  - etcd.remove
     {%- endif %}
  - sodafoundation.database.config.clean
