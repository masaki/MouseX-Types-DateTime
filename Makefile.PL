use inc::Module::Install;
name 'MouseX-Types-DateTime';
all_from 'lib/MouseX/Types/DateTime.pm';

readme_from 'lib/MouseX/Types/DateTime.pm';
readme_markdown_from 'lib/MouseX/Types/DateTime.pm';
auto_set_repository;

requires 'Mouse' => '0.15';
requires 'MouseX::Types' => '0.01';
requires 'Scalar::Util';
requires 'namespace::clean';
requires 'DateTime';
requires 'DateTime::Duration';
requires 'DateTime::TimeZone';
requires 'DateTime::Locale';
requires 'DateTimeX::Easy';
requires 'Time::Duration::Parse';

tests 't/*.t';
test_requires 'Test::More' => '0.94';
test_requires 'Test::UseAllModules';

author_tests 'xt';
author_requires 'Test::Pod';
author_requires 'Test::Pod::Coverage';
author_requires 'Test::Spelling';
author_requires 'ShipIt';
author_requires 'ShipIt::Step::Manifest';
author_requires 'ShipIt::Step::DistClean';
author_requires 'ShipIt::Step::Twitter';

auto_include_deps;
WriteAll;
