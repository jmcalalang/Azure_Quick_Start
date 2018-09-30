# Ansible Role: BIG-IQ Onboard

Performs a basic series of onboarding steps to bootstrap a BIG-IQ system
to the point that it can accept configuration.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    bigiq_onboard_server: localhost
    bigiq_onboard_server_port: 443
    bigiq_onboard_user: admin
    bigiq_onboard_password: secret
    bigiq_onboard_validate_certs: no
    bigiq_onboard_transport: rest
    bigiq_onboard_timeout: 120

Establishes initial connection to your BIG-IQ. These values are substituted into
your ``provider`` module parameter.

    bigiq_onboard_new_root_password:
    bigiq_onboard_old_root_password: default
    bigiq_onboard_new_admin_password:
    bigiq_onboard_old_admin_password: admin

Parameters used to change the default admin and root accounts on the BIG-IQ during
onboarding. If you do not want to change the passwords, leave the ``new`` variables
empty.

    bigiq_onboard_node_type: cm

Control the type of the BIG-IQ node. There are two types; ``cm`` and ``dcd``. If you
do not specify a type, the default will be ``cm``.

    bigiq_onboard_master_passphrase:

Sets the master password for the BIG-IQ. This value is used for encryption/decryption
of fields that BIG-IQ uses. This must meet certain complexity requirements before
BIG-IQ will accept it; 16 characters long, and must contain at least one uppercase
letter, lower case letter, number, and special character.

    bigiq_onboard_dns_nameservers:
      - 8.8.8.8

DNS servers that the BIG-IQ will use for name resolution

    bigiq_onboard_dns_search:
      - localhost

DNS search domains

    bigiq_onboard_ntp_servers:
      - time.nist.gov

NTP configuration

    bigiq_onboard_timezone: America/Los_Angeles

The timezone to set on the BIG-IQ device. This timezone should be specified in the
"TZ" format as seen [here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

    bigiq_onboard_license_key:

License key to use to license the BIG-IQ device. If you do not wish to license your
device, leave this field empty.

## Dependencies

None.

## Example Playbook

    - name: Set up a CM BIG-IQ
      hosts: bigiq
      vars_files:
        - vars/main.yml
      roles:
        - { role: f5devcentral.bigiq_onboard }

*Inside `vars/main.yml`*:

    bigiq_onboard_server: bigiq01.domain.org
    bigiq_onboard_password: secret
    bigiq_onboard_new_root_password: New_Admin_Secret123
    bigiq_onboard_old_root_password: default
    bigiq_onboard_new_admin_password: New_Root_Secret123
    bigiq_onboard_old_admin_password: admin
    bigiq_onboard_master_passphrase: M@sterPassphrase1234
    bigiq_onboard_dns_nameservers:
      - 10.10.10.10
    bigiq_onboard_dns_search:
      - domain.org
    bigiq_onboard_timezone: America/Los_Angeles
    bigiq_onboard_license_key: XXXXX-XXXXX-XXXXX-XXXXX-XXXXXXX

## License

Apache2

## Author Information

This role was created in 2018 by [Tim Rupp](https://github.com/caphrim007).
