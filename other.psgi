use Compojure;
use Plack::Builder;

my $api_routes = routes(
    get('/get_thing', sub { my $req = shift; return "shibby" }),
    post('/add_thing', sub { return "dude" }),
);

my $authed_routes = get("/behind_auth", sub { my $req = shift; return "authed!" });

builder {
    mount '/api'    => app($api_routes);
    mount '/authed' => builder {
        enable 'Auth::Basic', authenticator => sub { return 1 };
        app($authed_routes);
    }
}
