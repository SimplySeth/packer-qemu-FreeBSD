# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 2.2.5'

Vagrant.configure(2) do |config|
  config.vm.guest = :freebsd
  config.vm.provider "qemu" do |qe|
    qe.machine = "virt,accel=hvf,highmem=off"
    qe.memory = "1024"
  end

  config.vm.synced_folder "./http", "/vagrant", type: :rsync,
    rsync__auto: true, rsync__args: ["--verbose"]
end
