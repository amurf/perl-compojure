package Plack::Middleware::CGIExpand;
use parent qw(Plack::Middleware);

use strict;
use warnings;

use Plack::Request;
use CGI::Expand qw(expand_cgi);

sub call {
    my ($self, $env) = @_;

    $env->{'args'} = expand_cgi( Plack::Request->new($env) );

    return $self->app->($env);
}

1;
