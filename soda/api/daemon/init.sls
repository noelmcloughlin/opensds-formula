{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import packages, apier, golang with context %}
{%- from 'soda/files/macros.j2' import create_dir, build_source, cp_binaries with context %}
{%- from 'soda/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - soda.api.config

      {%- for id in soda.api.ids %}
        {% if 'daemon' in soda.api and id in soda.api.daemon and soda.api.daemon[id] is mapping %}

{{ workflow('soda', 'api daemon', id, soda.api, soda.dir.controller, soda, golang) }}

        {%- endif %}
      {%- endfor %}
    {%- endif %}
