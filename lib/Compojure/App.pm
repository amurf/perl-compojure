package Compojure::App;
use Moo;
use Function::Parameters qw(:strict);
use Plack::Builder;

has routes => (
    is => 'ro',
);

has middleware => (
    is      => 'ro',
);

method to_app {
    my $routes = $self->routes;
    my $app    = Plack::Builder->new;

    for my $mw (@{$self->middleware}) {
        $app->add_middleware('CGIExpand');
    }

    for my $route (keys %{$routes}) {
        $app->mount($route => $routes->{$route}->to_app);
    }

    return $app->to_app;
}

1;
