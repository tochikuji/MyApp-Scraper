use inc::Module::Install;

name 'ImgScraper';
version 0.0.1;
license 'BSD License';
test_requires 'Test::More' => 0.98;

tests 't/*.t';

WriteAll;
