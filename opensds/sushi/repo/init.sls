###  sodafoundation/sushi/repo/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

  {%- if sodafoundation.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import golang with context %}
{%- from 'sodafoundation/files/macros.j2' import repo_download with context %}

      {%- for id in sodafoundation.sushi.ids %}
          {%- if 'daemon' in sodafoundation.sushi and id in sodafoundation.sushi.daemon %}
              {%- set daemon = sodafoundation.sushi.daemon[ id ] %}
              {%- if daemon is mapping and 'repo' in daemon.strategy|lower %}

{{ repo_download('sodafoundation', 'sushi repo', id, daemon, golang.go_path + '/src/github.com/sodafoundation') }}

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
