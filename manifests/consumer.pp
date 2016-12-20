
define rabbitmqcliconsumer::consumer(
    $command = undef,
    $host = 'localhost',
    $port = 5672,
    $user = 'guest',
    $password = 'guest',
    $vhost = '/',
    $queue = undef,
    $compression = 'off'
) {
    # The base class must be included first because it is used by parameter defaults
    if ! defined(Class['rabbitmqcliconsumer']) {
        fail('You must include the rabbitmqcliconsumer base class before using any rabbitmqcliconsumer defined resources')
    }

    if ($queue == undef) {
        fail('You must set a queue to attach the consumer')
    }

    if ($command == undef) {
        fail('You must set a command to the consumer')
    }

    if ($name == undef) {
        fail('You must set a name to the consumer')
    }

    $logs_error = "/etc/rabbitmq-cli-consumer/logs/error_${name}.log"
    $logs_info = "/etc/rabbitmq-cli-consumer/logs/info_${name}.log"

    include rabbitmqcliconsumer::config_dir

    # @TODO: flag for rabbitmq-cli-consumer
    # --strict-exit-code
    # --include, -i


    # create config file
    file { "/etc/rabbitmq-cli-consumer/conf/${name}.conf":
        ensure => present,
        content => template("rabbitmqcliconsumer/rabbitmq-cli.conf.erb")
    }->
    supervisord::program { "rabbitmq-cli-consumer_${name}":
        command             => "rabbitmq-cli-consumer -e \"${command}\" -c /etc/rabbitmq-cli-consumer/conf/${name}.conf -V",
        priority            => '100',
    }

}
