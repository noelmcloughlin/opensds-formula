###  sodafoundation/keystone/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

{%- if "keystone" in sodafoundation.hotpot.conf.let.auth_strategy|lower %}

include:
  - devstack.user
  - sodafoundation.keystone.conflicts.init
  - devstack.install
  {%- if grains.os_family == 'RedHat' %}
  - devstack.install       {# workaround https://github.com/saltstack-formulas/devstack-formula/issues/13 #}
  {%- endif %}
  - sodafoundation.keystone.conflicts.clean

{%- else %}

sodafoundation keystone init nothing to do:
  test.show_notification:
    - text: |
        Skipping keystone because `auth_strategy: noauth` (or something else) was configured!

{%- endif %}
