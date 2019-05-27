# Exherbo-Packer

Packer build for [Exherbo](http://exherbo.org)

## Content

This packer build will create an ISO with the following configurations:

* latest stable linux kernel
* SystemD

Please not that it is a work-in-progress project ;)

## Required

* Latest packer version
* KVM and qemu

## Usage

```bash
packer build exherbo.json
```

## Contributing

Contributing are welcome! Just create some issues and/or pull requests ❤️

## TODO

* Better kernel config (we do not need gpu/floppy/whatever modules)
