# sodafoundation/dock/config/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',) %}
{%- from 'sodafoundation/files/macros.j2' import update_config, create_dir with context %}

include:
  - sodafoundation.config

        {%- for id in sodafoundation.dock.ids %}
            {%- if 'conf' in sodafoundation.dock and id in sodafoundation.dock.conf %}
                {%- set config = sodafoundation.dock.conf[id] %}
                {%- if config is mapping %}

{{ update_config('sodafoundation','dock config', id, config, sodafoundation.conf) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}

{{ create_dir('sodafoundation','dock config', 'volumegroups', sodafoundation.dir.hotpot) }}
    {%- endif %}
