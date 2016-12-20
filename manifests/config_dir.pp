class rabbitmqcliconsumer::config_dir {

    # created directory structure
    file {["/etc/rabbitmq-cli-consumer/", "/etc/rabbitmq-cli-consumer/conf/", "/etc/rabbitmq-cli-consumer/logs/"]:
        ensure => directory
    }
}
