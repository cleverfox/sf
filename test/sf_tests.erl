%% Tests

-module(sf_tests).

-author('Leonardo Rossi <leonardo.rossi@studenti.unipr.it>').

-include_lib("eunit/include/eunit.hrl").

string_formatting_test() ->
  <<"hello worlds!">> = sf:format(
          <<"hello {{name}}!">>, [{<<"name">>, <<"worlds">>}]),

  <<"hello worlds!">> = sf:format(
          <<"hello {{name}}!">>, #{<<"name">> => <<"worlds">>}),

  <<"hello string!">> = sf:format("hello {{name}}!", [{"name", "string"}]),

  <<"hello 123!">> = sf:format("hello {{name}}!", [{"name", 123}]),

  <<"hello 12.3!">> = sf:format("hello {{name}}!", [{"name", 12.3}]),

  Pid = list_to_binary(pid_to_list(self())),
  String = << <<"hello ">>/binary, Pid/binary, <<"!">>/binary >>,
  String = sf:format("hello {{pid}}!", [{pid, self()}]),

  <<"hello {1,2,3}!">> = sf:format("hello {{name}}!", [{"name", {1,2,3}}]),

  ?assertEqual(<<"B = #{\"Hello\" => <<\"c\">>}">>,
               sf:format("B = {{bind}}", [{bind, #{"Hello" => <<"c">>}}])),

  ?assertEqual("hello 123!", sf:format("hello {{name}}!", [{"name", 123}], [string])),

  ok.

to_string_test() ->
  Pid = pid_to_list(self()),
  Pid = sf:to_string(self()),
  "test" = sf:to_string(test),
  "test" = sf:to_string(<<"test">>),
  "123" = sf:to_string(123),
  "12.3" = sf:to_string(12.3),
  "test" = sf:to_string("test"),
  "{1,2,3}" = sf:to_string({1,2,3}),
  ?assertEqual(
    "#{\"Hello\" => <<\"c\">>}",
    sf:to_string(#{"Hello" => <<"c">>})),

  ok.
