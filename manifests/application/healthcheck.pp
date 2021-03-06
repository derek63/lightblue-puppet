# == Class: lightblue::application::healthcheck
#
# Deploys lightblue healthcheck application.
#
# There is some client configuration duplicated from lightblue::eap::client,
# as that doesn't really work with multiple client certificates (although I
# tried in vain for many hours to use that existing class)
#
# === Parameters
#
class lightblue::application::healthcheck (
    $data_service_uri,
    $metadata_service_uri,
    $use_cert_auth,
    $ca_certificates = undef,
    $client_certificates = undef,
    $package_name = 'lightblue-healthcheck',
    $package_ensure = latest,
) {

    package { $package_name :
        ensure  => $package_ensure,
        require => [
            Class['lightblue::yumrepo::lightblue'],
            Class['lightblue::eap'] ],
    }

    $client_module_base_path = '/usr/share/jbossas/modules/com/redhat/lightblue/client'

    # The standard puppet way to create dirs recursively does not work when paths overlap
    # They do, because many modules are created in /usr/share/jbossas/modules/com...
    exec { $client_module_base_path:
        command => "mkdir -p ${client_module_base_path}",
        user    => 'jboss',
    }

    $module_path = "${client_module_base_path}/healthcheck/main"
    $module_dirs = ["${client_module_base_path}/healthcheck", $module_path]

    # Setup the module directory
    file { $module_dirs :
        ensure  => 'directory',
        owner   => 'jboss',
        group   => 'jboss',
        mode    => '0440',
        require => Exec[$client_module_base_path],
    }

    file { "${module_path}/module.xml":
        mode    => '0644',
        owner   => 'jboss',
        group   => 'jboss',
        content => template('lightblue/properties/modulehealthcheckclient.xml.erb'),
        require => File[$module_dirs],
    }

    $ca_certificates_default = {
        file_path     => $module_path,
        mode          => '0440',
        owner         => 'jboss',
        group         => 'jboss',
        links         => 'follow',
    }

    create_resources(lightblue::client::cert_file, $ca_certificates, $ca_certificates_default)

    $client_defaults = {
        file_path            => $module_path,
        data_service_uri     => $data_service_uri,
        metadata_service_uri => $metadata_service_uri,
        use_cert_auth        => $use_cert_auth,
        ca_certificates      => $ca_certificates,
        mode                 => '0440',
        owner                => 'jboss',
        group                => 'jboss',
        links                => 'follow',
    }

    create_resources(lightblue::client::client_cert, $client_certificates, $client_defaults)

    $clients_config_file_name = 'lightblue-clients.config'
    $clients_config_file_path = "${module_path}/${clients_config_file_name}"

    concat { $clients_config_file_path :
        ensure => present,
        mode   => '0440',
        owner  => 'jboss',
        group  => 'jboss',
    }

    $client_cert_keys = keys($client_certificates)

    concat::fragment { $clients_config_file_path:
        target  => $clients_config_file_path,
        content => join($client_cert_keys, ".properties\n"),
    }

}
