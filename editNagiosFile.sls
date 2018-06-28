/etc/nagios/nrpe.cfg:
  file.line:
    - content: "server_address=10.0.0.9"
    - match: "#server_address=*"
    - mode: "replace"