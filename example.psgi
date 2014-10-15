use Compojure;

my $app = sub {
    get("/route", sub { my $req = shift; return "shibby" });
    post("/route", sub { return "dude" });
};

my $routes     = context("/one", context("/two", context("/three", $app)));
my $routes_two = context("/testing", $app);

app($routes, $routes_two);
