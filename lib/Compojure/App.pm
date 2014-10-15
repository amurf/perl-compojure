package Compojure::App;
use Moo;
use Function::Parameters qw(:strict);

use Plack::Builder;
use Plack::App::URLMap;

has routes => (
    is => 'ro',
);

method to_app {
    my $routes = $self->routes;

    return builder {
        enable 'CGIExpand';

        for my $route ( keys %{$routes} ) {
            mount $route => $routes->{$route}->to_app;
        }

        mount "/" => sub {};
    }
}

1;
