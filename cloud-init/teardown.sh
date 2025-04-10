#! /bin/bash

# quickly tear down the instances that didn't work
virsh destroy fedora-cloud-01
virsh undefine fedora-cloud-01

