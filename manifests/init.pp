
include ::supervisord

class rabbitmqcliconsumer (
    $ensure = 'present'
    )
{
    if $ensure == 'present' {

        exec { "Wget rabbitmq-cli-consumer":
            command => "wget -P /tmp https://github.com/ricbra/rabbitmq-cli-consumer/releases/download/1.4.2/rabbitmq-cli-consumer-linux-amd64.tar.gz",
            onlyif => '/usr/bin/test ! -f /usr/bin/rabbitmq-cli-consumer',
        } ->
        exec { "Extract rabbitmq-cli-consumer":
            command => "tar zxvf /tmp/rabbitmq-cli-consumer-linux-amd64.tar.gz -C /tmp",
            onlyif => '/usr/bin/test ! -f /usr/bin/rabbitmq-cli-consumer',
        } ->
        exec { "Move rabbitmq-cli-consumer":
            command => "mv /tmp/rabbitmq-cli-consumer /usr/bin",
            onlyif => '/usr/bin/test ! -f /usr/bin/rabbitmq-cli-consumer',
        } ->
        exec { "Clean rabbitmq-cli-consumer":
            command => "rm /tmp/rabbitmq-cli-consumer*",
            onlyif => '/usr/bin/test -f /tmp/rabbitmq-cli-consumer*',
        }

    } else {

        exec { "Remove rabbitmq-cli-consumer":
            command => "rm /usr/bin/rabbitmq-cli-consumer",
            onlyif => '/usr/bin/test -f /usr/bin/rabbitmq-cli-consumer',
        }

    }

}
