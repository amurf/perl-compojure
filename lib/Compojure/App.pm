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
    my $app    = Plack::App::URLMap->new;

    for my $route ( keys %{$routes} ) {
        $app->mount($route => $routes->{$route}->to_app);
    }

    return $app->to_app;
}

1;
