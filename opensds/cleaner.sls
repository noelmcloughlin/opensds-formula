### sodafoundation/cleaner.sls
# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - sodafoundation.auth.clean
  - sodafoundation.dashboard.clean
  - sodafoundation.dock.clean
  - sodafoundation.database.clean
  - sodafoundation.sushi.clean
  - sodafoundation.gelato.clean
  - sodafoundation.hotpot.clean
  - sodafoundation.backend.clean
  - sodafoundation.telemetry.clean
  - sodafoundation.infra.clean
  - sodafoundation.freespace
