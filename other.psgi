use Compojure;
use Plack::Builder;

my $api_routes = routes(
    get('/get_thing', sub { my $req = shift; return "shibby" }),
    post('/add_thing', sub { return "dude" }),
);


my $authed_routes = get("/behind_auth", sub { my $req = shift; return "authed!" });

builder {

    enable 'ETag';
    mount "/api" => app($api_routes);

    enable 'Auth::Basic', authenticator => sub { return 1 };
    mount "/authed"    => app($authed_routes);

};

