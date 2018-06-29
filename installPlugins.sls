nagios_client:
  pkg.installed:
    - pkgs:
      - nagios-nrpe-server
	  - nagios-plugins