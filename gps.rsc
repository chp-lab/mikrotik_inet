{
:global lat
:global lon
/system gps monitor once do={
:set $lat $("latitude")
:set $lon $("longitude")
}
# tool fetch mode=http url="http://wattvision-dev.giantiot.com:1880/api/v1/mikrotik/LtMiniLte" port=80 http-method=post http-data=("{\"lat\":\"" . $lat . "\",\"lon\":\"" . $lon . "\"}") http-header-field="Content-Type: application/json"
# :put ("{\"lat\":\"" . $lat . "\",\"lon\":\"" . $lon . "\"}")

:local imei
:set imei ([/interface lte info lte1 as-value once]->"imei")
:put ("all imei number: $imei")

:for e from 0 to 5 do={
/system gps monitor once do={
:set $lat $("latitude")
:set $lon $("longitude")
}
:put ($e)
tool fetch mode=http url="http://wattvision-dev.giantiot.com:1880/api/v1/mikrotik/LtMiniLte" port=80 http-method=post http-data=("{\"lat\":\"" . $lat . "\",\"lon\":\"" . $lon . "\",\"imei\":\"". $imei . "\",\"src\":\"iot\"}") http-header-field="Content-Type: application/json"
}
}
