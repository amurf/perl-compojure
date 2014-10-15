package Compojure::Response;
use Function::Parameters qw(:strict);
use Plack::Response;

method render($body) {

    my $response = Plack::Response->new(200);

    # big switch? if $body is many
    # diff things do the correct thing.

    # If string/html
    $response->body($body);
    $response->content_type("text/html");

    return $response->finalize;

}

1;
