#!/bin/bash

#Basic docker inspect (Json format)
docker inspect {containername} 
docker container inspect {containername}

#Basic docker inspect (pretty format)
docker inspect --pretty {containername} 
docker container inspect --pretty {containername}

#Basic docker inspect Grep (JSONformat)
docker inspect {containername} | grep IPAddress

#Docker inspect jSON filter (JSONformat) - Value only no key
docker inspect --format="{{.State.Paused}}" {containername}
docker inspect --format="{{.State}}" {containername}

#Docker inspect jSON filter (JSONformat) - Includes Key & Value
docker inspect --format="{{json .Config}}" {containername}
