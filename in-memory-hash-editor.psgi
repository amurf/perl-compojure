use Compojure;
use Function::Parameters qw(:strict);
use Plack::Builder;

my %editable_hash = (
    one => 'two',
);

fun edit_hash($req) {
    my $args = $req->env->{args};

    my $hash_key = $args->{id};
    $editable_hash{$hash_key} = $args->{val};

    my $args = {
        hash => \%editable_hash,
    };

    template('view_hash.tt', $args);
}

fun view_hash($req) {
    my $args = {
        hash => \%editable_hash,
    };

    template('view_hash.tt', $args);
}

my $app_routes = routes(
    get('/view_hash' => \&view_hash),
    get('/edit_hash' => \&edit_hash),
);

app($app_routes);
