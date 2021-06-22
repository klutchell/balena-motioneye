# balena-motioneye

A [motionEye](https://github.com/ccrisan/motioneye) server deployed on balena.io.

## Getting Started

You can one-click-deploy this project to balena using the button below:

[![deploy button](https://balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/klutchell/balena-motioneye&defaultDeviceType=raspberrypi3)

## Manual Deployment

Alternatively, deployment can be carried out by manually creating a [balenaCloud account](https://dashboard.balena-cloud.com) and application, flashing a device, downloading the project and pushing it via the [balena CLI](https://github.com/balena-io/balena-cli).

## Usage

- Navigate to the device's IP/hostname over http to open the interface
- Alternatively enable the [public device URL](https://www.balena.io/docs/learn/manage/actions/#enable-public-device-url) and navigate to that to see the interface

The interface uses the default MotionEye credentials. There you can add your settings (cameras, etc) that are stored in a non-volatile way (in docker volumes).

To use an attached PiCamera, check our [documetation](https://www.balena.io/docs/learn/develop/hardware/i2c-and-spi/#raspberry-pi-camera-module) for setting it up, and use `gpu_mem` set at least to `192`.

### Configuration variables

Some device settings can be adjusted with Device/Fleet service variables. These should be set for the `motioneye` service:

- `SERVER_NAME`: the name of the server in the MotionEye UI. If not set, then the device's name (from the [`RESIN_DEVICE_NAME_AT_INIT` variable](https://docs.resin.io/learn/develop/runtime/#environment-variables)) will be used automatically.
- `TZ`: the device's local time, one of the timezone names from the [available time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). If not set, the default UTC time is used.
- `DEVICE_HOSTNAME`: Set a custom hostname on application start so it can be reached via MDNS like `motioneye.local`.

### Notes

- The current setup only supports ARMv7 devices (especially Raspberry Pi 3). Other device types are WIP
- The default `docker-compose.yml` exposes 10 MotionEye camera streaming ports on the port range used by MotionEye by default (`8081-8090`), if need more than that, you need to edit the compose file.

## Acknowledgments

Original software is by Calin Crisan and the Motion-Project.

- <https://github.com/ccrisan/motioneye/>
- <https://github.com/Motion-Project/motion>
