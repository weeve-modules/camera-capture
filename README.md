# Camera Capture

|              |                                                                                     |
| ------------ | ----------------------------------------------------------------------------------- |
| name         | Camera Capture                                                                      |
| version      | v0.0.1                                                                              |
| docker image | [weevenetwork/camera-capture](https://hub.docker.com/r/weevenetwork/camera-capture) |
| authors      | Jakub Grzelak                                                                       |

- [Camera Capture](#camera-capture)
  - [Description](#description)
  - [Features](#features)
  - [Environment Variables](#environment-variables)
    - [Module Specific](#module-specific)
    - [Set by the weeve Agent on the edge-node](#set-by-the-weeve-agent-on-the-edge-node)
  - [Additional docker settings](#additional-docker-settings)
    - [Volume Mounts](#volume-mounts)
    - [Device Mounts](#device-mounts)
  - [Dependencies](#dependencies)
  - [Examples](#examples)
    - [Input](#input)
    - [Output](#output)
  - [docker-compose example](#docker-compose-example)

## Description

This module connects to pi Camera and captures image.

## Features

- Captures images using in-build tools in RaspberryPi OS.
- Interval of capturing the image can be specified

## Environment Variables

### Module Specific

The following module configurations can be provided in a data service designer section on weeve platform:

| Name            | Environment Variables | type   | Description                                                                                                   |
| --------------- | --------------------- | ------ | ------------------------------------------------------------------------------------------------------------- |
| LD Library Path | LD_LIBRARY_PATH       | string | Path to the LD libraries on the hist system, so that the container need not to install them. eg `/opt/vc/lib` |
| Interval        | INTERVAL              | string | Interval at which image will be captured. eg `1s`                                                             |


Other features required for establishing the inter-container communication between modules in a data service are set by weeve agent.

### Set by the weeve Agent on the edge-node

| Environment Variables | type   | Description                            |
| --------------------- | ------ | -------------------------------------- |
| EGRESS_API_HOST       | string | HTTP ReST endpoint for the next module |
| MODULE_NAME           | string | Name of the module                     |


## Additional docker settings
### Volume Mounts

| Host           | Container      | Description                     |
| -------------- | -------------- | ------------------------------- |
| /dev/bus/usb   | /dev/bus/usb   | Mounting the USB bus            |
| /opt/vc        | /opt/vc        | Mounting the Video Card/Capture |
| /tmp/.X11-unix | /tmp/.X11-unix |                                 |

### Device Mounts
`/dev/vchiq:/dev/vchiq` - Mount the Pi Camera
## Dependencies


* Raspberry Pi
* Pi Camera


## Examples

### Input
Camera Input
### Output

Images file, that will be sent via HTTP POST Method with Form data, and key as `image`.

## docker-compose example

```yml
version: "3"
services:
    camera:
        image: weevenetwork/camera-capture
        network_mode: host
        restart: always
        volumes:
            - /dev/bus/usb:/dev/bus/usb
            - /opt/vc:/opt/vc
            - /tmp/.X11-unix:/tmp/.X11-unix
        environment:
            LD_LIBRARY_PATH: /opt/vc/lib
            INTERVAL: 1s
            DISPLAY:
        devices:
            - "/dev/vchiq:/dev/vchiq"
        privileged: true
```
