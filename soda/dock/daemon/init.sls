{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import packages, docker, golang with context %}
{%- from 'soda/files/macros.j2' import create_dir, build_source, cp_binaries with context %}
{%- from 'soda/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - soda.dock.config

      {%- for id in soda.dock.ids %}
        {% if 'daemon' in soda.dock and id in soda.dock.daemon and soda.dock.daemon[id] is mapping %}

{{ workflow('soda', 'dock daemon', id, soda.dock, soda.dir.controller, soda, golang) }}

        {%- endif %}
      {%- endfor %}
    {%- endif %}
