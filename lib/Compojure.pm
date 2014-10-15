package Compojure;

use Exporter 'import';
@EXPORT = qw(get post put app context routes template);

use strict;
use warnings;

use Compojure::Route;
use Compojure::App;

use Function::Parameters qw(:strict);
use Template;

#XXX: keeps track of routes..
my %routes;

fun app(@routes) {
    my %combined_routes;

    for my $route (@routes) {
        @combined_routes{keys %$route} = values %$route;
    }

    return Compojure::App->new(routes => \%combined_routes)->to_app;
}

fun add_handler($type, $path, $func) {
    my $route = $routes{$path};

    if ($route) {
        $route->$type($func);
    } else {
        $routes{$path} = Compojure::Route->new($type => $func);
    }

    return { $path => $routes{$path} };
}

fun context($path, $func) {
    if (ref $func eq 'CODE') {
        $func = $func->();
    }

    if (ref $func eq 'HASH') {
        my %hash = map { $path.$_ => $func->{$_} } keys %$func;
        return \%hash;
    }

    return;
}

fun routes(@routes) {
    my %hash;

    for my $route (@routes) {
        for my $key (keys %$route) {
            $hash{$key} = $route->{$key};
        }
    }

    return \%hash;
}


fun template($name, $vars = undef) {
    my $output;

    Template->new(INCLUDE_PATH => '.')
            ->process($name, $vars, \$output);

    return $output;
}

fun get($path, $func) {
    add_handler('GET', $path, $func);
}

fun post($path, $func) {
    add_handler('POST', $path, $func);
}

fun put($path, $func) {
    add_handler('PUT', $path, $func);
}


1;
