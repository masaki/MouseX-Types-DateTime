use Test::More;
eval "use Test::Dependencies exclude => ['MouseX::Types::DateTime']";
plan skip_all => "Test::Dependencies required for testing dependencies" if $@;
ok_dependencies();
