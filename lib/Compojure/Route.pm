package Compojure::Route;
use parent 'Plack::Component';
use Plack::Request;
use Compojure::Response;
use Function::Parameters qw(:strict);
use Moo;

has GET => (
    is => 'rw',
);

has POST => (
    is => 'rw',
);

has PUT => (
    is => 'rw',
);


method call($env) {
    my $method = $env->{REQUEST_METHOD};

    my $body = $self->$method->( Plack::Request->new($env) );
    return Compojure::Response->render($body);
}

method static_files($root) {
    return Plack::App::File->new(root => $root);
}

1;
